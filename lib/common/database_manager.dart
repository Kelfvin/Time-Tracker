import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager extends GetxController {
  late Database database;

  connetDataBase() async {
    // 从数据库中读取数据
    database = await openDatabase(
      join(await getDatabasesPath(), 'time_tracker.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE events(id INTEGER PRIMARY KEY, startTimestamp INTEGER, endTimestamp INTEGER)",
        );
      },
      version: 1,
    );
  }
}
