// SPDX-License-Identifier: LGPL-2.1-or-later

#include <ctype.h>
#include <errno.h>
#include <net/if.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

#include <netlink/genl/ctrl.h>
#include <netlink/genl/genl.h>
#include <linux/nl80211.h>

struct dump_data {
	bool first;
};

struct scan_results {
	int err;
	bool done;
	bool aborted;
};

void print_ssid(unsigned char *ie, int ielen)
{
	uint8_t len, *data;
	unsigned int i;

	while (ielen >= 2 && ielen >= ie[1]) {
		if (ie[0] == 0 && ie[1] >= 0 && ie[1] <= 32) {
			len = ie[1];
			data = ie + 2;

			for (i = 0; i < len; i++) {
				if (isprint(data[i]) && data[i] != ' ' && data[i] != '\\')
					printf("%c", data[i]);
				else if (data[i] == ' ' && (i != 0 && i != len -1))
					printf(" ");
				else
					printf("\\x%.2x", data[i]);
			}
			break;
		}

		ielen -= ie[1] + 2;
		ie += ie[1] + 2;
	}
}

static int dump_cb(struct nl_msg *msg, void *arg)
{
	static struct nla_policy bss_policy[NL80211_BSS_MAX + 1] = {
		[NL80211_BSS_TSF]			= { .type = NLA_U64 },
		[NL80211_BSS_FREQUENCY]			= { .type = NLA_U32 },
		[NL80211_BSS_BSSID]			= { },
		[NL80211_BSS_BEACON_INTERVAL]		= { .type = NLA_U16 },
		[NL80211_BSS_CAPABILITY]		= { .type = NLA_U16 },
		[NL80211_BSS_INFORMATION_ELEMENTS]	= { },
		[NL80211_BSS_SIGNAL_MBM]		= { .type = NLA_U32 },
		[NL80211_BSS_SIGNAL_UNSPEC]		= { .type = NLA_U8 },
		[NL80211_BSS_STATUS]			= { .type = NLA_U32 },
		[NL80211_BSS_SEEN_MS_AGO]		= { .type = NLA_U32 },
		[NL80211_BSS_BEACON_IES]		= { },
		[NL80211_BSS_CHAN_WIDTH]		= { .type = NLA_U32 },
	};
	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
	struct nlattr *tb[NL80211_ATTR_MAX + 1];
	struct nlattr *bss[NL80211_BSS_MAX + 1];
	struct nlattr *attr;
	struct dump_data *dump_data = arg;
	unsigned int channel, width, value;
	unsigned char *data, signal;
	int ret, len, signal_mbm;

	attr = genlmsg_attrdata(gnlh, 0);
	len = genlmsg_attrlen(gnlh, 0);

	ret = nla_parse(tb, NL80211_ATTR_MAX, attr, len, NULL);
	if (ret < 0) {
		fprintf(stderr, "Failed to parse attributes: %d\n", ret);
		return NL_SKIP;
	}

	if (!tb[NL80211_ATTR_BSS]) {
		fprintf(stderr, "BSS info missing\n");
		return NL_SKIP;
	}

	ret = nla_parse_nested(bss, NL80211_BSS_MAX, tb[NL80211_ATTR_BSS], bss_policy);
	if (ret < 0) {
		fprintf(stderr, "Failed to parse attributes: %d\n", ret);
		return NL_SKIP;
	}

	if (!bss[NL80211_BSS_BSSID] || !bss[NL80211_BSS_INFORMATION_ELEMENTS])
		return NL_SKIP;

	value = nla_get_u32(bss[NL80211_BSS_FREQUENCY]);
	channel = ((value - 2412) / 5) + 1;
	value = nla_get_u32(bss[NL80211_BSS_CHAN_WIDTH]);
	width = 20 / (1 << value);
	signal_mbm = nla_get_s32(bss[NL80211_BSS_SIGNAL_MBM]);
	signal = (10000 + signal_mbm) / 70;

	data = nla_data(bss[NL80211_BSS_BSSID]);

	if (dump_data->first)
		dump_data->first = false;
	else
		printf(",\n");

	printf("\t{ \"address\" : \"%02x:%02x:%02x:%02x:%02x:%02x\", "
	       "\"channel\" : %u, \"width\": %u, \"dBm\" : %d, "
	       "\"quality\" : %hhu, \"ssid\" : \"",
	       data[0], data[1], data[2], data[3], data[4], data[5],
	       channel, width, signal_mbm / 100, signal);

	data = nla_data(bss[NL80211_BSS_INFORMATION_ELEMENTS]);
	len = nla_len(bss[NL80211_BSS_INFORMATION_ELEMENTS]);
	print_ssid(data, len);
	printf("\" }");

	return NL_SKIP;
}

static int valid_cb(struct nl_msg *msg, void *arg)
{
	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
	struct scan_results *results = arg;

	switch (gnlh->cmd) {
	case NL80211_CMD_SCAN_ABORTED:
		results->aborted = true;
		/* fall-through */
	case NL80211_CMD_NEW_SCAN_RESULTS:
		results->done = true;
		/* fall-through */
	default:
		break;
	}

	return NL_SKIP;
}

static int error_cb(struct sockaddr_nl *nla, struct nlmsgerr *err, void *arg)
{
	struct scan_results *results = arg;

	results->err = err->error;

	return NL_STOP;
}

static int finish_cb(struct nl_msg *msg, void *arg)
{
	return NL_SKIP;
}

static int ack_cb(struct nl_msg *msg, void *arg)
{
	return NL_STOP;
}

static int seq_check_cb(struct nl_msg *msg, void *arg)
{
	return NL_OK;
}

static int scan(struct nl_sock *s, int iface, int driver,
		struct scan_results *results)
{
	struct nl_msg *msg, *ssids;
	struct nl_cb *cb;
	int mcid, ret = -ENOMEM;

	mcid = genl_ctrl_resolve_grp(s, "nl80211", "scan");
	nl_socket_add_membership(s, mcid);

	msg = nlmsg_alloc();
	if (!msg) {
		fprintf(stderr, "Failed to allocate netlink message\n");
		goto out_drop_membership;
	}

	ssids = nlmsg_alloc();
	if (!ssids) {
		fprintf(stderr, "Failed to allocate netlink message\n");
		goto out_msg_free;
	}

	cb = nl_cb_alloc(NL_CB_DEFAULT);
	if (!cb) {
		fprintf(stderr, "Failed to allocate netlink callback\n");
		goto out_ssids_free;
	}

	/* Create the Netlink message */
	genlmsg_put(msg, 0, 0, driver, 0, 0, NL80211_CMD_TRIGGER_SCAN, 0);
	nla_put_u32(msg, NL80211_ATTR_IFINDEX, iface);
	nla_put(ssids, 1, 0, "");
	nla_put_nested(msg, NL80211_ATTR_SCAN_SSIDS, ssids);

	/* Set up the callback */
	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, valid_cb, results);
	nl_cb_err(cb, NL_CB_CUSTOM, error_cb, results);
	nl_cb_set(cb, NL_CB_FINISH, NL_CB_CUSTOM, finish_cb, results);
	nl_cb_set(cb, NL_CB_ACK, NL_CB_CUSTOM, ack_cb, results);
	nl_cb_set(cb, NL_CB_SEQ_CHECK, NL_CB_CUSTOM, seq_check_cb, results);

	/* Start the scan */
	ret = nl_send_auto(s, msg);
	if (ret < 0) {
		fprintf(stderr, "Unable to send netlink message: %d\n", ret);
		goto out_ssids_free;
	}

	/* Read netlink messages until the scan is done */
	do {
		ret = nl_recvmsgs(s, cb);
		if (ret < 0) {
			fprintf(stderr, "Unable to receive netlink message: %d\n", ret);
			goto out_ssids_free;
		}
	} while (!results->done);

out_ssids_free:
	nlmsg_free(ssids);
out_msg_free:
	nlmsg_free(msg);
out_drop_membership:
	nl_socket_drop_membership(s, mcid);
	return ret < 0 ? ret : 0;
}

static int read_scan_results(struct nl_sock *s, int iface, int driver)
{
	struct dump_data dump_data = { true };
	struct nl_msg *msg;
	struct nl_cb *cb;
	int ret;

	msg = nlmsg_alloc();
	if (!msg) {
		fprintf(stderr, "Failed to allocate netlink message\n");
		return -ENOMEM;
	}

	genlmsg_put(msg, 0, 0, driver, 0, NLM_F_DUMP, NL80211_CMD_GET_SCAN, 0);
	nla_put_u32(msg, NL80211_ATTR_IFINDEX, iface);
	nl_socket_modify_cb(s, NL_CB_VALID, NL_CB_CUSTOM, dump_cb, &dump_data);

	ret = nl_send_auto(s, msg);
	if (ret < 0) {
		fprintf(stderr, "Unable to send netlink message: %d\n", ret);
		goto out_msg_free;
	}

	ret = nl_recvmsgs_default(s);
	if (ret < 0) {
		fprintf(stderr, "Unable to receive netlink messages: %d\n", ret);
		goto out_msg_free;
	}

out_msg_free:
	nlmsg_free(msg);
	return ret < 0 ? ret : 0;
}

int main(int argc, char **argv)
{
	int iface, driver, ret;
	struct nl_sock *s;
	struct scan_results results;

	if (argc != 2) {
		fprintf(stderr, "Usage: wlan-scan <interface>\n");
		return EXIT_FAILURE;
	}

	iface = if_nametoindex(argv[1]);
	if (!iface) {
		fprintf(stderr, "Invalid interface name\n");
		return EXIT_FAILURE;
	}

	s = nl_socket_alloc();
	if (!s) {
		fprintf(stderr, "Out of memory\n");
		return EXIT_FAILURE;
	}

	genl_connect(s);

	driver = genl_ctrl_resolve(s, "nl80211");

	memset(&results, 0, sizeof(results));

	ret = scan(s, iface, driver, &results);
	if (ret) {
		nl_socket_free(s);
		return EXIT_FAILURE;
	}

	printf("[\n");

	ret = read_scan_results(s, iface, driver);
	if (ret) {
		nl_socket_free(s);
		return EXIT_FAILURE;
	}

	printf("\n]\n");

	nl_socket_free(s);

	return EXIT_SUCCESS;
}
