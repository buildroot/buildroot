// SPDX-License-Identifier: GPL-2.0
/*
 * This is a linux kernel driver for MIPI-DSI 
 * panel with touch panel attached to I2C bus.
 *
 * Copyright (c) 2020 Seeed Studio
 * Zhangqun Ming<north_sea@qq.com>
 *
 * I2C slave address: 0x45
 */
#include "mipi_dsi.h"


#define MIPI_DSI_DRIVER_NAME		"mipi_dsi"

/*static */int i2c_md_read(struct i2c_mipi_dsi *md, u8 reg, u8 *buf, int len)
{
	struct i2c_client *client = md->i2c;
	struct i2c_msg msgs[1];
	u8 addr_buf[1] = { reg };
	u8 data_buf[1] = { 0, };
	int ret;

	mutex_lock(&md->mutex);
	/* Write register address */
	msgs[0].addr = client->addr;
	msgs[0].flags = 0;
	msgs[0].len = ARRAY_SIZE(addr_buf);
	msgs[0].buf = addr_buf;

	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
	if (ret != ARRAY_SIZE(msgs)) {
		mutex_unlock(&md->mutex);
		return -EIO;
	}

	usleep_range(1000, 1500);

	/* Read data from register */
	msgs[0].addr = client->addr;
	msgs[0].flags = I2C_M_RD;
	if (NULL == buf) {
		msgs[0].len = 1;
		msgs[0].buf = data_buf;
	}
	else {
		msgs[0].len = len;
		msgs[0].buf = buf;
	}

	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
	if (ret != ARRAY_SIZE(msgs)) {
		mutex_unlock(&md->mutex);
		return -EIO;
	}
	mutex_unlock(&md->mutex);

	if (NULL == buf) {
		return data_buf[0];	
	}
	else {
		return ret;
	}
}

/*static */void i2c_md_write(struct i2c_mipi_dsi *md, u8 reg, u8 val)
{
	struct i2c_client *client = md->i2c;
	int ret;

	mutex_lock(&md->mutex);
	ret = i2c_smbus_write_byte_data(client, reg, val);
	if (ret)
		dev_err(&client->dev, "I2C write failed: %d\n", ret);

	usleep_range(1000, 1500);
	mutex_unlock(&md->mutex);
}


/* mipi driver */
static int mipi_dsi_probe(struct mipi_dsi_device *dsi)
{
	int ret;

	DBG_FUNC();
	ret = mipi_dsi_attach(dsi);
	if (ret) {
		dev_err(&dsi->dev, "failed to attach dsi to host: %d\n", ret);
	}

	return ret;
}

static struct mipi_dsi_driver mipi_dsi_driver = {
	.driver.name = MIPI_DSI_DRIVER_NAME,
	.probe = mipi_dsi_probe,
};


/* mipi device */
static struct mipi_dsi_device *mipi_dsi_device(struct device *dev)
{
	struct mipi_dsi_device *dsi = NULL;
	struct device_node *endpoint, *dsi_host_node;
	struct mipi_dsi_host *host;
	struct mipi_dsi_device_info info = {
		.type = MIPI_DSI_DRIVER_NAME,
		.channel = 0,
		.node = NULL,
	};

	DBG_FUNC();
	/* Look up the DSI host.  It needs to probe before we do. */
	endpoint = of_graph_get_next_endpoint(dev->of_node, NULL);
	if (!endpoint) {
		dev_err(dev, "No endpoint node!");
		return NULL;
	}

	dsi_host_node = of_graph_get_remote_port_parent(endpoint);
	if (!dsi_host_node) {
		dev_err(dev, "No dsi_host node!");
		goto error;
	}

	host = of_find_mipi_dsi_host_by_node(dsi_host_node);
	of_node_put(dsi_host_node);
	if (!host) {
		dev_err(dev, "Can't find mipi_dsi_host!");
		goto error;
	}

	info.node = of_graph_get_remote_port(endpoint);
	if (!info.node) {
		dev_err(dev, "Can't get remote port!");
		goto error;
	}

	of_node_put(endpoint);
	dsi = mipi_dsi_device_register_full(host, &info);
       if(IS_ERR(dsi)) {
               dev_err(dev, "Can't device register_full!");
               goto error;
       }

	return dsi;

error:
	of_node_put(endpoint);
	return NULL;
}


/* panel_funcs */
static int panel_prepare(struct drm_panel *panel)
{
	int ret = 0;
	struct i2c_mipi_dsi *md = panel_to_md(panel);
	const struct drm_panel_funcs *funcs = md->panel_data->funcs;

	DBG_FUNC("");

	/* i2c */
	/* reset pin */
	i2c_md_write(md, REG_LCD_RST, 0);
	msleep(20);
	i2c_md_write(md, REG_LCD_RST, 1);
	msleep(20);

	/* panel */
	if (funcs && funcs->prepare) {
		ret = funcs->prepare(panel);
		if (ret < 0)
			return ret;
	}

	return ret;
}

static int panel_unprepare(struct drm_panel *panel)
{
	int ret = 0;
	struct i2c_mipi_dsi *md = panel_to_md(panel);
	const struct drm_panel_funcs *funcs = md->panel_data->funcs;

	DBG_FUNC("");
	if (funcs && funcs->unprepare) {
		ret = funcs->unprepare(panel);
		if (ret < 0)
			return ret;
	}

	return ret;
}

static int panel_enable(struct drm_panel * panel)
{
	int ret = 0;
	struct i2c_mipi_dsi *md = panel_to_md(panel);
	const struct drm_panel_funcs *funcs = md->panel_data->funcs;

	DBG_FUNC("");
	/* panel */
	if (funcs && funcs->enable) {
		ret = funcs->enable(panel);
		if (ret < 0)
			return ret;
	}

	/* i2c */
	i2c_md_write(md, REG_PWM, md->brightness);

	return ret;
}

static int panel_disable(struct drm_panel * panel)
{
	int ret = 0;
	struct i2c_mipi_dsi *md = panel_to_md(panel);
	const struct drm_panel_funcs *funcs = md->panel_data->funcs;

	DBG_FUNC("");
	/* i2c */
	i2c_md_write(md, REG_PWM, 0);
	i2c_md_write(md, REG_LCD_RST, 0);

	/* panel */
	if (funcs && funcs->disable) {
		ret = funcs->disable(panel);
		if (ret < 0)
			return ret;
	}

	return ret;
}

static int panel_get_modes(struct drm_panel *panel, struct drm_connector *connector)
{
	int ret = 0;
	struct i2c_mipi_dsi *md = panel_to_md(panel);
	const struct drm_panel_funcs *funcs = md->panel_data->funcs;

//	DBG_FUNC("");
	if (funcs && funcs->get_modes) {
		ret = funcs->get_modes(panel, connector);
		if (ret < 0)
			return ret;
	}

	return ret;
}

static const struct drm_panel_funcs panel_funcs = {
	.prepare = panel_prepare,
	.unprepare = panel_unprepare,
	.enable = panel_enable,
	.disable = panel_disable,
	.get_modes = panel_get_modes,
};


/* backlight */
static int backlight_update(struct backlight_device *bd)
{
	struct i2c_mipi_dsi *md = bl_get_data(bd);
	int brightness = bd->props.brightness;

	if (bd->props.power != FB_BLANK_UNBLANK ||
		bd->props.fb_blank != FB_BLANK_UNBLANK ||
		bd->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK)) {
			brightness = 0;
		}

	md->brightness = brightness;
	i2c_md_write(md, REG_PWM, brightness);

	return 0;
}

static const struct backlight_ops backlight_ops = {
	.options = BL_CORE_SUSPENDRESUME,
	.update_status	= backlight_update,
};

static int backlight_init(struct i2c_mipi_dsi *md)
{
	struct device *dev = &md->i2c->dev;
	struct backlight_properties props;
	struct backlight_device *bd;

	memset(&props, 0, sizeof(props));
	props.type = BACKLIGHT_RAW;
	props.max_brightness = 255;
	bd = devm_backlight_device_register(dev, dev_name(dev),
					dev, md, &backlight_ops,
					&props);
	if (IS_ERR(bd)) {
		dev_err(dev, "failed to register backlight\n");
		return PTR_ERR(bd);
	}

	bd->props.brightness = 255;
	backlight_update_status(bd);

	return 0;
}


/* i2c */
static int i2c_md_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
{
	struct device *dev = &i2c->dev;
	struct i2c_mipi_dsi *md;
	int ret = 0;

	DBG_FUNC("start");
	md = devm_kzalloc(dev, sizeof(*md), GFP_KERNEL);
	if (!md)
		return -ENOMEM;

	i2c_set_clientdata(i2c, md);
	mutex_init(&md->mutex);
	md->i2c = i2c;
	md->panel_data = (struct panel_data *)of_device_get_match_data(dev);
	if (!md->panel_data) {
		dev_err(dev, "No valid panel data.\n");
		return -ENODEV;
	}

	ret = i2c_md_read(md, REG_ID, NULL, 0);
	if (ret < 0) {
		dev_err(dev, "I2C read id failed: %d\n", ret);
		return -ENODEV;
	}
	dev_info(dev, "I2C read id: 0x%x\n", ret);
	if (ret != 0xC3) {
		dev_err(dev, "Unknown chip id: 0x%02x\n", ret);
		return -ENODEV;
	}

	/* Turn off */
	i2c_md_write(md, REG_POWERON, 1);

	md->dsi = mipi_dsi_device(dev);
	if (NULL == md->dsi) {
		dev_err(dev, "DSI device registration failed!\n");
		return -ENODEV;
	}

	md->panel_data->set_dsi(md->dsi);
	drm_panel_init(&md->panel, dev, &panel_funcs, DRM_MODE_CONNECTOR_DSI);
	drm_panel_add(&md->panel);

	tp_init(md);
	backlight_init(md);

	DBG_FUNC("finished.");

	return 0;
}

static int i2c_md_remove(struct i2c_client *i2c)
{
	struct i2c_mipi_dsi *md = i2c_get_clientdata(i2c);

	DBG_FUNC();
	tp_deinit(md);

	/* Turn off power */
	i2c_md_write(md, REG_POWERON, 0);
	i2c_md_write(md, REG_LCD_RST, 0);
	i2c_md_write(md, REG_PWM, 0);

	mipi_dsi_detach(md->dsi);
	drm_panel_remove(&md->panel);
	mipi_dsi_device_unregister(md->dsi);
	kfree(md->dsi);

	return 0;
}

extern const struct panel_data ili9881d_data;
static const struct of_device_id i2c_md_of_ids[] = {
	{
		.compatible = "i2c_dsi,ili9881d",
		.data = (const void*)&ili9881d_data,
	},
	{ } /* sentinel */
};
MODULE_DEVICE_TABLE(of, i2c_md_of_ids);

static struct i2c_driver i2c_md_driver = {
	.driver = {
		.name = "i2c_mipi_dsi",
		.of_match_table = i2c_md_of_ids,
	},
	.probe = i2c_md_probe,
	.remove = i2c_md_remove,
};

static int __init i2c_md_init(void)
{
	int ret;

	DBG_FUNC("20210701 xiongj");
	ret = i2c_add_driver(&i2c_md_driver);
	if (ret < 0)
		return ret;

	ret = mipi_dsi_driver_register(&mipi_dsi_driver);
	if (ret < 0)
		return ret;

	return ret;
}
module_init(i2c_md_init);

static void __exit i2c_md_exit(void)
{
	DBG_FUNC();
	mipi_dsi_driver_unregister(&mipi_dsi_driver);
	i2c_del_driver(&i2c_md_driver);
}
module_exit(i2c_md_exit);

MODULE_AUTHOR("Zhangqun Ming <north_sea@qq.com>");
MODULE_AUTHOR("Seeed, Inc.");
MODULE_DESCRIPTION("MIPI-DSI driver");
MODULE_LICENSE("GPL v2");
