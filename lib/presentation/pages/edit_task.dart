import 'package:intl/intl.dart';
import '../../core.dart';

class EditTaskPage extends StatefulWidget {
  final TaskModel task;
  const EditTaskPage({super.key, required this.task});

  @override
  EditTaskPageState createState() => EditTaskPageState();
}

class EditTaskPageState extends State<EditTaskPage> {
  final _formKey = GlobalKey<FormState>();

  final TaskController taskController = Get.put(TaskController());
  final TextEditingController titleCont = TextEditingController();
  final TextEditingController descCont = TextEditingController();
  DateTime? selectedDeadline;

  @override
  void initState() {
    super.initState();
    titleCont.text = widget.task.title;
    descCont.text = widget.task.description ?? '';
    selectedDeadline = widget.task.deadline;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHome(context, 'Update Task', 'Hello User'),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              tff(titleCont, 'Title Task'),
              hbox(10),
              tff(descCont, 'Description Task'),
              hbox(10),
              GestureDetector(
                onTap: () async {
                  selectedDeadline = await selectDate(context);
                  setState(() {});
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Deadline',
                    border: OutlineInputBorder(),
                  ),
                  child: Text(
                    selectedDeadline != null
                        ? DateFormat('dd MMM yyyy').format(selectedDeadline!)
                        : 'Select Date',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              hbox(20),
              buttonBlue('Update Task', () {
                if (_formKey.currentState!.validate()) {
                  final newTask = TaskModel(
                    id: widget.task.id,
                    title: titleCont.text,
                    description: descCont.text,
                    isCompleted: false,
                    progress: 0,
                    deadline: selectedDeadline,
                  );
                  print('update task :: $newTask');
                  taskController.updateTask(newTask);
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
