import '../../core.dart';

class TaskController extends GetxController {
  final TaskRepository taskRepo = TaskRepository();
  var tasks = <TaskModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  Future<void> loadTasks() async {
    tasks.value = await taskRepo.getAllTasks();
  }

  Future<void> addTask(TaskModel task) async {
    await taskRepo.addTask(task);
    loadTasks();
  }

  Future<void> deleteTask(int id) async {
    await taskRepo.removeTask(id);
    loadTasks();
  }

  Future<void> updateTask(TaskModel task) async {
    await taskRepo.updateTask(task);
    loadTasks();
  }

  Future<void> addSubTask(int taskId, SubTaskModel subTask) async {
    await taskRepo.addSubTask(subTask, taskId);
    loadTasks();
  }

  Future<void> updateSubTask(SubTaskModel subTask) async {
    await taskRepo.updateSubTask(subTask);
    loadTasks();
  }

  Future<void> deleteSubTask(int id) async {
    await taskRepo.removeSubTask(id);
    loadTasks();
  }

  Future<void> toggleTaskStatus(int taskId, bool isCompleted) async {
    await taskRepo.toggleTaskStatus(taskId, isCompleted);
    await deleteTask(taskId);
    loadTasks();
  }

  Future<void> toggleSubTaskStatus(int subTaskId, bool isCompleted) async {
    await taskRepo.toggleSubTaskStatus(subTaskId, isCompleted);
    loadTasks();
  }
}
