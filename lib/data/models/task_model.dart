class TaskModel {
  int? id;
  String title;
  String? description;
  bool isCompleted;
  double progress;
  DateTime? deadline;
  List<SubTaskModel> subTasks;

  TaskModel({
    this.id,
    required this.title,
    this.description,
    required this.isCompleted,
    required this.progress,
    this.deadline,
    List<SubTaskModel>? subTasks,
  }) : subTasks = subTasks ?? [];

  double calculateProgress() {
    if (subTasks.isEmpty) return 0;
    int completedSubtasks = subTasks.where((task) => task.isCompleted).length;
    return (completedSubtasks / subTasks.length) * 100;
  }

  @override
  String toString() {
    return 'TaskModel(id: $id, title: $title, description: $description, isCompleted: $isCompleted, progress: $progress, deadline: $deadline, subTasks: $subTasks)';
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'] == 1,
      progress: (json['progress'] as num).toDouble(),
      deadline:
          json['deadline'] != null ? DateTime.parse(json['deadline']) : null,
      subTasks: (json['subTasks'] as List<dynamic>?)
              ?.map((task) => SubTaskModel.fromJson(task))
              .toList() ??
          [],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0,
      'progress': progress,
      'deadline': deadline?.toIso8601String(),
      // 'subTasks': subTasks.map((task) => task.toJson()).toList(),
    };
  }
}

class SubTaskModel {
  int? id;
  String title;
  bool isCompleted;

  SubTaskModel({
    this.id,
    required this.title,
    required this.isCompleted,
  });

  factory SubTaskModel.fromJson(Map<String, dynamic> json) {
    return SubTaskModel(
      id: json['id'],
      title: json['title'],
      isCompleted: json['isCompleted'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }
}
