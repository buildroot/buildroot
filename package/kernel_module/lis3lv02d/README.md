GROVE 3-Axis Digital Accelerometer (+-400g)
===========================================

  After driver and configuration prepared well,
  the user could access ```/sys/bus/iio/devices/iio\:device<N>/XXX```,
  to get the sensor data results.

***

Usage
-----

***example:***

  ```bash
  # check the device<N> name, make sure it's hcsr04
  # where <N> is a number specific to your system.

  $ cat /sys/bus/iio/devices/iio\:device3/name
  lis331dlh
    
  # get the raw data
  $ cd /sys/bus/iio/devices/iio\:device3/
  $ cat in_accel_x_raw in_accel_y_raw in_accel_z_raw
  3
  10
  -9
  ```

  If you need customize the I2C-Port..., change it the device tree source.

