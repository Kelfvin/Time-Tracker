import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:time_tracker/common/data/event.dart';
import 'package:time_tracker/common/database_manager.dart';

class DatabaseController extends GetxController {
  // 事件的列表
  List<Event> events = [];

  final databaseManager = Get.find<DatabaseManager>();

  DatabaseController();

  _initData() async {
    // 从数据库中读取数据
    await databaseManager.connetDataBase();

    // 打印数据库路径
    print("database.path = ${databaseManager.database.path}");

    // 从数据库中读取数据
    final List<Map<String, dynamic>> maps = await databaseManager.database
        .query('events', orderBy: 'startTimestamp');

    // 将数据转换为事件列表
    events = List.generate(maps.length, (i) {
      return Event(
        id: maps[i]['id'],
        startTimestamp:
            DateTime.fromMillisecondsSinceEpoch(maps[i]['startTimestamp']),
        endTimestamp:
            DateTime.fromMillisecondsSinceEpoch(maps[i]['endTimestamp']),
      );
    });

    update(["database"]);
  }

  addRecord() async {
    // 从数据库中读取数据
    await databaseManager.database.insert(
      'events',
      {
        'startTimestamp': DateTime.now().millisecondsSinceEpoch,
        'endTimestamp': DateTime.now().millisecondsSinceEpoch,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // 查询并打印数据
    final List<Map<String, dynamic>> maps = await databaseManager.database
        .query('events', orderBy: 'startTimestamp');

    // 将数据转换为事件列表
    events = List.generate(maps.length, (i) {
      return Event.fromMap(maps[i]);
    });

    print("--------------------");
    for (var event in events) {
      print("event.id = ${event.id}");
      print("event.startTimestamp = ${event.startTimestamp}");
      print("event.endTimestamp = ${event.endTimestamp}");
    }
    print("--------------------");
  }

  @override
  void onInit() {
    super.onInit();

    // 打开数据库
    _initData();
  }
}
