import '../../core.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tasks.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        isCompleted INTEGER NOT NULL,
        progress REAL NOT NULL,
        deadline TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE sub_tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        taskId INTEGER NOT NULL,
        title TEXT NOT NULL,
        isCompleted INTEGER NOT NULL,
        FOREIGN KEY (taskId) REFERENCES tasks (id) ON DELETE CASCADE
      )
    ''');
  }

  // Future<int> insertTask(TaskModel task) async {
  //   final db = await instance.database;
  //   // return await db.insert('tasks', task.toJson());
  //   int taskId = await db.insert('tasks', {
  //     'title': task.title,
  //     'description': task.description ?? "",
  //     'isCompleted': task.isCompleted ? 1 : 0,
  //     'progress': task.progress,
  //     'deadline': task.deadline?.toIso8601String(),
  //   });

  //   // Simpan SubTask ke tabel `sub_tasks`
  //   for (var subTask in task.subTasks) {
  //     await insertSubTask(subTask, taskId);
  //   }

  //   return taskId;
  // }

  // Future<int> updateTask(TaskModel task) async {
  //   final db = await instance.database;
  //   return await db.update(
  //     'tasks',
  //     task.toJson(),
  //     where: 'id = ?',
  //     whereArgs: [task.id],
  //   );
  // }

  // Future<List<TaskModel>> getTasks() async {
  //   print('call db get task');
  //   final db = await instance.database;
  //   final result = await db.query('tasks');
  //   // print('res db get task :: $result');
  //   // return result.map((json) => TaskModel.fromJson(json)).toList();
  //   List<TaskModel> tasks =
  //       result.map((json) => TaskModel.fromJson(json)).toList();

  //   for (var task in tasks) {
  //     task.subTasks = await getSubTasks(task.id!);
  //   }
  //   return tasks;
  // }

  // Future<int> deleteTask(int id) async {
  //   final db = await instance.database;
  //   return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  // }

  // Future<int> insertSubTask(SubTaskModel subTask, int taskId) async {
  //   final db = await instance.database;
  //   return await db.insert('sub_tasks', {
  //     'taskId': taskId,
  //     ...subTask.toJson(),
  //   });
  // }

  // Future<int> updateSubTask(SubTaskModel subTask) async {
  //   final db = await instance.database;
  //   return await db.update(
  //     'sub_tasks',
  //     subTask.toJson(),
  //     where: 'id = ?',
  //     whereArgs: [subTask.id],
  //   );
  // }

  // Future<int> deleteSubTask(int id) async {
  //   final db = await instance.database;
  //   return await db.delete(
  //     'sub_tasks',
  //     where: 'id = ?',
  //     whereArgs: [id],
  //   );
  // }

  // Future<List<SubTaskModel>> getSubTasks(int taskId) async {
  //   final db = await instance.database;
  //   final result =
  //       await db.query('sub_tasks', where: 'taskId = ?', whereArgs: [taskId]);
  //   return result.map((json) => SubTaskModel.fromJson(json)).toList();
  // }
}
