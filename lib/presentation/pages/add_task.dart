import 'dart:math';
import 'package:intl/intl.dart';
import '../../core.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  AddTaskPageState createState() => AddTaskPageState();
}

class AddTaskPageState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>();

  final TaskController taskController = Get.put(TaskController());
  final TextEditingController titleCont = TextEditingController();
  final TextEditingController descCont = TextEditingController();
  DateTime? selectedDeadline;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHome(context, 'Add Task', 'Hello User'),
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
              buttonBlue('Save New Task', () {
                if (_formKey.currentState!.validate()) {
                  Random random = Random();
                  int id = random.nextInt(1500) * 50;
                  final newTask = TaskModel(
                    id: id,
                    title: titleCont.text,
                    description: descCont.text,
                    isCompleted: false,
                    progress: 0,
                    deadline: selectedDeadline,
                  );
                  print('add task :: $newTask');
                  taskController.addTask(newTask);
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
