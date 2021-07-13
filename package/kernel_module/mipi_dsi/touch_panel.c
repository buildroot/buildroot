#include "mipi_dsi.h"


#define GOODIX_STATUS_SIZE		        2
#define GOODIX_CONTACT_SIZE		        8
#define GOODIX_BUFFER_STATUS_READY	    (((uint32_t)0x01)<<7)//BIT(7)
#define GOODIX_HAVE_KEY			        (((uint32_t)0x01)<<4)//BIT(4)

#define TP_DEFAULT_WIDTH	1280
#define TP_DEFAULT_HEIGHT	720
#define TP_MAX_POINTS       5
#define TP_POLL_INTERVAL    15


static int goodix_ts_read_input_report(struct i2c_mipi_dsi *md, u8 *data)
{
	int header = GOODIX_STATUS_SIZE + GOODIX_CONTACT_SIZE;
	int i, ret, touch_num;

	for (i=0; i<2; i++) {
		ret = i2c_md_read(md, REG_TP_STATUS, data, header);
		if (ret < 0) {
			return -EIO;
		}

		if (data[0] & GOODIX_BUFFER_STATUS_READY) {
			touch_num = data[0] & 0x0f;
			if (touch_num > TP_MAX_POINTS)
				return -EPROTO;

			if (touch_num > 1) {
				ret = i2c_md_read(md, REG_TP_POINT, data+header, (touch_num-1)*GOODIX_CONTACT_SIZE);
				if (ret < 0)
					return -EIO;
			}
			return touch_num;
		}

		usleep_range(3000, 5000); /* Poll every 3 - 5 ms */
	}

	/*
	 * The Goodix panel will send spurious interrupts after a
	 * 'finger up' event, which will always cause a timeout.
	 */
	return -ENOMSG;
}

static void goodix_ts_report_touch_8b(struct i2c_mipi_dsi *md, u8 *coor_data)
{
	struct input_dev *input_dev = md->input;
	int id = coor_data[7];
	int input_x = 0;
	int input_y = 0;
	int input_w = coor_data[4];

	input_x = coor_data[1];
	input_x <<= 8;
	input_x += coor_data[0];
	
	input_y = coor_data[3];
	input_y <<= 8;
	input_y += coor_data[2];

	input_mt_slot(input_dev, id);
	input_mt_report_slot_state(input_dev, MT_TOOL_FINGER, true);
	touchscreen_report_pos(input_dev, &md->prop, input_x, input_y, true);
	input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR, input_w);
	input_report_abs(input_dev, ABS_MT_WIDTH_MAJOR, input_w);
}

static void tp_poll_func(struct input_dev *input)
{
	struct i2c_mipi_dsi *md = (struct i2c_mipi_dsi *)input_get_drvdata(input);
	u8  point_data[GOODIX_STATUS_SIZE + TP_MAX_POINTS * GOODIX_CONTACT_SIZE] = { 0 };
	int touch_num;
	int i;

	touch_num = goodix_ts_read_input_report(md, point_data);
	if (touch_num < 0) {
		return;
	}

	for (i = 0; i < touch_num; i++) {
		goodix_ts_report_touch_8b(md, &point_data[GOODIX_STATUS_SIZE + i*GOODIX_CONTACT_SIZE]);
	}

	input_mt_sync_frame(input);
	input_sync(input);
}

int tp_init(struct i2c_mipi_dsi *md)
{
	struct i2c_client *i2c = md->i2c;
	struct device *dev = &i2c->dev;
	struct input_dev *input;
	int ret;

	input = devm_input_allocate_device(dev);
	if (!input) {
		dev_err(dev, "Failed to allocate input device\n");
		return -ENOMEM;
	}
	md->input = input;
	input_set_drvdata(input, md);

	input->dev.parent = dev;
	input->name = "seeed-tp";
	input->id.bustype = BUS_I2C;
	input->id.vendor = 0x1234;
	input->id.product = 0x1001;
	input->id.version = 0x0100;

	input_set_abs_params(input, ABS_MT_WIDTH_MAJOR, 0, 255, 0, 0);
	input_set_abs_params(input, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
	input_set_abs_params(input, ABS_MT_POSITION_X, 0, TP_DEFAULT_WIDTH, 0, 0);
	input_set_abs_params(input, ABS_MT_POSITION_Y, 0, TP_DEFAULT_HEIGHT, 0, 0);
	//touchscreen_parse_properties(input, true, &md->prop);
 #if 0
	md->prop.max_x = 1024;//TP_DEFAULT_WIDTH;
	md->prop.max_y = 768;//TP_DEFAULT_HEIGHT;
	md->prop.invert_x = 0;
	md->prop.invert_y = 1;
	md->prop.swap_x_y = 1;
#endif
	ret = input_mt_init_slots(input, TP_MAX_POINTS, INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
	if (ret) {
		dev_err(dev, "could not init mt slots, %d\n", ret);
		return ret;
	}

	ret = input_setup_polling(input, tp_poll_func);
	if (ret) {
		dev_err(dev, "could not set up polling mode, %d\n", ret);
		return ret;
	}
	input_set_poll_interval(input, TP_POLL_INTERVAL);

	ret = input_register_device(input);
	if (ret) {
		dev_err(dev, "could not register input device, %d\n", ret);
		return ret;
	}

	return 0;
}

int tp_deinit(struct i2c_mipi_dsi *md)
{
	input_unregister_device(md->input);
	return 0;
}
