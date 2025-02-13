import 'dart:math';
import '../../core.dart';

class AddSubTaskPage extends StatefulWidget {
  final TaskModel taskModel;
  const AddSubTaskPage({super.key, required this.taskModel});

  @override
  AddSubTaskPageState createState() => AddSubTaskPageState();
}

class AddSubTaskPageState extends State<AddSubTaskPage> {
  final _formKey = GlobalKey<FormState>();

  final TaskController taskController = Get.put(TaskController());
  final TextEditingController titleCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHome(context, 'Add Subtask', 'Hello User'),
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
              buttonBlue('Save New Subtask', () {
                if (_formKey.currentState!.validate()) {
                  Random random = Random();
                  int id = random.nextInt(1500) * 50;
                  final newTask = SubTaskModel(
                    id: id,
                    title: titleCont.text,
                    isCompleted: false,
                  );
                  print('add subtask :: $newTask');
                  taskController.addSubTask(widget.taskModel.id!, newTask);
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
