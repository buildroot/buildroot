#include <SQLiteCpp/SQLiteCpp.h>

#include <iostream>
#include <string>

int main()
{
    SQLite::Database db(":memory:", SQLite::OPEN_READWRITE | SQLite::OPEN_CREATE);
    db.exec("CREATE TABLE fruits (name TEXT, color TEXT)");

    SQLite::Statement insert(db, "INSERT INTO fruits VALUES (?, ?)");
    insert.bind(1, "Banana");
    insert.bind(2, "Yellow");
    insert.exec();

    SQLite::Statement query(db, "SELECT name, color FROM fruits");
    if (!query.executeStep()) {
        return 1;
    }
    const std::string name = query.getColumn(0).getString();
    const std::string color = query.getColumn(1).getString();
    if (name != "Banana" || color != "Yellow" || query.executeStep()) {
        return 1;
    }
    std::cout << name << ": " << color << std::endl;
    return 0;
}
