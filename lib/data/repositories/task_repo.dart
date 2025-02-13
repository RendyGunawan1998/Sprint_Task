import '../../core.dart';

class TaskRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<List<TaskModel>> getAllTasks() async {
    try {
      final db = await _databaseHelper.database;
      final tasks = await db.query('tasks');
      List<TaskModel> taskList =
          tasks.map((json) => TaskModel.fromJson(json)).toList();

      for (var task in taskList) {
        task.subTasks = await getSubTasks(task.id!);
      }

      return taskList;
    } catch (e) {
      throw Exception('Failed to fetch tasks: $e');
    }
  }

  Future<int> addTask(TaskModel task) async {
    try {
      final db = await _databaseHelper.database;
      int taskId = await db.insert('tasks', task.toJson());

      for (var subTask in task.subTasks) {
        await addSubTask(subTask, taskId);
      }

      return taskId;
    } catch (e) {
      throw Exception('Failed to add task: $e');
    }
  }

  Future<void> updateTask(TaskModel task) async {
    try {
      final db = await _databaseHelper.database;
      await db.update(
        'tasks',
        task.toJson(),
        where: 'id = ?',
        whereArgs: [task.id],
      );
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }

  Future<void> removeTask(int id) async {
    try {
      final db = await _databaseHelper.database;
      await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }

  Future<int> addSubTask(SubTaskModel subTask, int taskId) async {
    try {
      final db = await _databaseHelper.database;
      return await db.insert('sub_tasks', {
        'taskId': taskId,
        ...subTask.toJson(),
      });
    } catch (e) {
      throw Exception('Failed to add sub-task: $e');
    }
  }

  Future<void> updateSubTask(SubTaskModel subTask) async {
    try {
      final db = await _databaseHelper.database;
      await db.update(
        'sub_tasks',
        subTask.toJson(),
        where: 'id = ?',
        whereArgs: [subTask.id],
      );
    } catch (e) {
      throw Exception('Failed to update sub-task: $e');
    }
  }

  Future<void> removeSubTask(int id) async {
    try {
      final db = await _databaseHelper.database;
      await db.delete('sub_tasks', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      throw Exception('Failed to delete sub-task: $e');
    }
  }

  Future<List<SubTaskModel>> getSubTasks(int taskId) async {
    try {
      final db = await _databaseHelper.database;
      final result =
          await db.query('sub_tasks', where: 'taskId = ?', whereArgs: [taskId]);
      return result.map((json) => SubTaskModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch sub-tasks: $e');
    }
  }

  Future<void> toggleTaskStatus(int taskId, bool isCompleted) async {
    final db = await _databaseHelper.database;
    await db.update(
      'tasks',
      {'isCompleted': isCompleted ? 1 : 0},
      where: 'id = ?',
      whereArgs: [taskId],
    );
  }

  Future<void> toggleSubTaskStatus(int subTaskId, bool isCompleted) async {
    final db = await _databaseHelper.database;
    await db.update(
      'sub_tasks',
      {'isCompleted': isCompleted ? 1 : 0},
      where: 'id = ?',
      whereArgs: [subTaskId],
    );
  }
}
