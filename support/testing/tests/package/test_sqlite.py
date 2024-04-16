import os

import infra.basetest


class TestSQLite(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_SQLITE=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """
    db_file = "buildroot.db"
    db_backup = "db_dump.sql"

    def run_sql_query(self, query):
        cmd = f'sqlite3 "{self.db_file}" "{query}"'
        self.assertRunOk(cmd)

    def create_tables(self):
        sql_query = "CREATE TABLE fruits ("
        sql_query += "id integer PRIMARY KEY, name varchar(16) NOT NULL);"
        self.run_sql_query(sql_query)

        sql_query = "CREATE TABLE colors ("
        sql_query += "id integer PRIMARY KEY, name varchar(16) NOT NULL);"
        self.run_sql_query(sql_query)

        sql_query = "CREATE TABLE fruit_colors ("
        sql_query += "fruit_id integer REFERENCES fruits(id), "
        sql_query += "color_id integer REFERENCES colors(id), "
        sql_query += "UNIQUE (fruit_id, color_id));"
        self.run_sql_query(sql_query)

    def insert_data(self):
        fruits = ["Banana", "Blueberry", "Orange", "Raspberry"]
        fruit_id = 1
        for fruit in fruits:
            sql_query = "INSERT INTO fruits (id, name) "
            sql_query += f"VALUES ({fruit_id}, '{fruit}');"
            self.run_sql_query(sql_query)
            fruit_id += 1

        colors = ["Blue", "Orange", "Red", "Yellow"]
        color_id = 1
        for color in colors:
            sql_query = "INSERT INTO colors (id, name) "
            sql_query += f"VALUES ({color_id}, '{color}');"
            self.run_sql_query(sql_query)
            color_id += 1

        fruit_colors = [(1, 4), (2, 1), (3, 2), (4, 3)]
        for fruit_color in fruit_colors:
            fruit_id, color_id = fruit_color
            sql_query = "INSERT INTO fruit_colors (fruit_id, color_id) "
            sql_query += f"VALUES ({fruit_id}, {color_id});"
            self.run_sql_query(sql_query)

    def query_database(self):
        sql_query = "SELECT "
        sql_query += "fruits.name AS fruit, colors.name AS color "
        sql_query += "FROM fruits, colors, fruit_colors "
        sql_query += "WHERE fruits.id = fruit_colors.fruit_id "
        sql_query += "AND colors.id = fruit_colors.color_id "
        sql_query += "ORDER BY fruit;"
        self.run_sql_query(sql_query)

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # The sqlite3 binary can execute.
        self.assertRunOk("sqlite3 --version")

        self.create_tables()
        self.insert_data()
        self.query_database()

        sql_query = "UPDATE fruits SET name = 'Lemon' WHERE id = 1;"
        self.run_sql_query(sql_query)

        # Dump the test database for a backup.
        cmd = f'echo .dump | sqlite3 "{self.db_file}" > "{self.db_backup}"'
        self.assertRunOk(cmd)

        # Drop all the tables.
        tables = ["fruit_colors", "fruits", "colors"]
        for table in tables:
            sql_query = f"DROP TABLE {table};"
            self.run_sql_query(sql_query)

        # Restore the backup.
        cmd = f'sqlite3 "{self.db_file}" < "{self.db_backup}"'
        self.assertRunOk(cmd)

        # Query on last time our data, to check the backup restoration
        # succeeded.
        self.query_database()
