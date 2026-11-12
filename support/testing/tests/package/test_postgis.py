import os

import infra.basetest


class TestPostGIS(infra.basetest.BRTest):
    # We use a specific configuration for:
    # - using Aarch64, to have more than 256MB memory,
    # - to have an ext4 rootfs image exposed as a virtio storage
    #   (rather than cpio initrd). This will save some memory, as the
    #   rootfs image is big.
    config = \
        """
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.18.63"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_PACKAGE_POSTGIS=y
        BR2_PACKAGE_POSTGRESQL=y
        BR2_PACKAGE_POSTGRESQL_FULL=y
        BR2_TARGET_ROOTFS_EXT2=y
        BR2_TARGET_ROOTFS_EXT2_4=y
        BR2_TARGET_ROOTFS_EXT2_SIZE="256M"
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def __init__(self, names):
        super(TestPostGIS, self).__init__(names)
        self.db_admin = "postgres"
        self.db_user = "br_user"
        self.db_name = "br_database"
        self.backup_file = "dump.sql"
        self.pgdata_dir = "/var/lib/pgsql"

    def get_psql_cmd(self, user, database, query, opts=None):
        cmd = f"psql --username={user} --dbname={database}"
        cmd += f' --command="{query}"'
        if opts is not None:
            cmd += " " + opts
        return cmd

    def run_user_db_query(self, user, database, query, opts=None):
        cmd = self.get_psql_cmd(user, database, query, opts)
        self.assertRunOk(cmd)

    def run_admin_sql_query(self, query, opts=None):
        self.run_user_db_query(self.db_admin, self.db_admin, query, opts)

    def run_sql_query(self, query, opts=None):
        self.run_user_db_query(self.db_user, self.db_name, query, opts)

    def cleanup_database(self):
        # This cleanup is useful when run-test -k is used. It makes
        # this test idempotent. Since the drive storage is preserved
        # between reboots, this cleanup will prevent errors during the
        # user/db creation.

        # Drop the test database, if it exists.
        cmd = f"dropdb --username={self.db_admin} "
        cmd += f"--if-exists {self.db_name}"
        self.assertRunOk(cmd)

        # Drop the test user, if it exists.
        cmd = f"dropuser --username={self.db_admin} "
        cmd += f"--if-exists {self.db_user}"
        self.assertRunOk(cmd)

    def create_tables(self):
        sql_query = "CREATE TABLE my_points ("
        sql_query += "id SERIAL PRIMARY KEY, geom geometry);"
        self.run_sql_query(sql_query)

        sql_query = "CREATE TABLE my_poly ("
        sql_query += "id SERIAL PRIMARY KEY, geom geometry);"
        self.run_sql_query(sql_query)

    def insert_data(self):
        # We create 9 points on a 3x3 grid.
        for x in range(0, 41, 20):
            for y in range(0, 41, 20):
                sql_query = "INSERT INTO my_points (geom) "
                sql_query += f"VALUES ('POINT ({x} {y})');"
                self.run_sql_query(sql_query)

        # We create a square polygon which only overlap one point.
        sql_query = "INSERT INTO my_poly (geom) "
        sql_query += "VALUES ('POLYGON ((30 10, 30 30, 10 30, 10 10, 30 10))');"
        self.run_sql_query(sql_query)

    def test_run(self):
        drive = os.path.join(self.builddir, "images", "rootfs.ext4")
        kern = os.path.join(self.builddir, "images", "Image")
        self.emulator.boot(arch="aarch64",
                           kernel=kern,
                           kernel_cmdline=["root=/dev/vda console=ttyAMA0"],
                           options=["-M", "virt",
                                    "-cpu", "cortex-a57",
                                    "-m", "512M",
                                    "-smp", "2",
                                    "-drive", f"file={drive},if=virtio,format=raw"])
        self.emulator.login()

        # Check the postgresql server is ready.
        self.assertRunOk("pg_isready")

        # Query the server version from the client.
        sql_query = "SELECT version();"
        self.run_admin_sql_query(sql_query,
                                 opts="--tuples-only --no-align")

        self.cleanup_database()

        # Create a new user.
        cmd = f"createuser --username={self.db_admin} "
        cmd += "--no-superuser --no-createdb --no-createrole "
        cmd += self.db_user
        self.assertRunOk(cmd)

        # Create a new database.
        cmd = f"createdb --username={self.db_admin} "
        cmd += f"--owner={self.db_user} "
        cmd += f'{self.db_name} "Test Database for Buildroot Test"'
        self.assertRunOk(cmd)

        # Enable PostGIS in the new database.
        sql_query = "CREATE EXTENSION IF NOT EXISTS postgis;"
        self.run_user_db_query(self.db_admin, self.db_name, sql_query)

        # Query the postgis extension version
        sql_query = "SELECT postgis_version();"
        self.run_sql_query(sql_query, opts="--tuples-only --no-align")

        self.create_tables()
        self.insert_data()

        # We query which point intersects the square.
        sql_query = "SELECT ST_AsText(my_points.geom) "
        sql_query += "FROM my_points, my_poly "
        sql_query += "WHERE ST_Intersects(my_points.geom, my_poly.geom);"
        cmd = self.get_psql_cmd(self.db_user, self.db_name, sql_query,
                                opts="--tuples-only --no-align")
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], "POINT(20 20)")
