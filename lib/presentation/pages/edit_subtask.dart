import '../../core.dart';

class EditSubTaskPage extends StatefulWidget {
  final TaskModel taskModel;
  final SubTaskModel subtaskModel;
  const EditSubTaskPage(
      {super.key, required this.taskModel, required this.subtaskModel});

  @override
  EditSubTaskPageState createState() => EditSubTaskPageState();
}

class EditSubTaskPageState extends State<EditSubTaskPage> {
  final _formKey = GlobalKey<FormState>();

  final TaskController taskController = Get.put(TaskController());
  final TextEditingController titleCont = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleCont.text = widget.subtaskModel.title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHome(context, 'Update Subtask', 'Hello User'),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              tff(titleCont, 'Title Subtask'),
              hbox(10),
              hbox(20),
              buttonBlue('Update Subtask', () {
                if (_formKey.currentState!.validate()) {
                  final newTask = SubTaskModel(
                    id: widget.subtaskModel.id,
                    title: titleCont.text,
                    isCompleted: widget.subtaskModel.isCompleted,
                  );
                  print('update subtask :: $newTask');
                  taskController.updateSubTask(newTask);
                  Get.offAll(() => ListTaskScreen());
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
