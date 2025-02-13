import '../../core.dart';

class ListTaskScreen extends StatefulWidget {
  const ListTaskScreen({super.key});

  @override
  State<ListTaskScreen> createState() => _ListTaskScreenState();
}

class _ListTaskScreenState extends State<ListTaskScreen> {
  final TaskController taskController = Get.put(TaskController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHome(context, 'List Task', 'Hello User'),
      body: Container(
        width: Get.width,
        height: Get.height,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Column(
            children: [
              hbox(20),
              Obx(() {
                if (taskController.tasks.isEmpty) {
                  return Center(child: Text("No tasks available."));
                }
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: taskController.tasks.length,
                    itemBuilder: (context, index) {
                      final datas = taskController.tasks[index];
                      return paddingData(
                        () {
                          Get.to(() => AddSubTaskPage(taskModel: datas));
                        },
                        AssetsHelper.icTask,
                        datas.title,
                        isOverdue(datas.deadline),
                        datas.description!,
                        datas,
                        datas.subTasks,
                        () {
                          Get.to(() => EditTaskPage(
                                task: datas,
                              ));
                        },
                        () {
                          showMyDialog(context, 'Delete?',
                              'Are you sure want to delete this data?', () {
                            taskController.deleteTask(datas.id!);
                            Navigator.pop(context);
                          });
                        },
                      );
                    });
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: Get.width,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: buttonBlue('Add New Task', () {
            Get.to(() => AddTaskPage());
          }),
        ),
      ),
    );
  }
}
