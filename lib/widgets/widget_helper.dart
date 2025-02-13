import '../core.dart';

hbox(double h) {
  return SizedBox(height: h);
}

wbox(double w) {
  return SizedBox(width: w);
}

buttonBlue(String title, Function() func) {
  return Padding(
    padding: EdgeInsets.all(12),
    child: InkWell(
      onTap: func,
      child: Container(
        height: Get.height * 0.06,
        width: Get.width,
        decoration: BoxDecoration(
            color: Colors.blue[200], borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
    ),
  );
}

paddingData(
  Function() funcTap,
  String assets,
  String titleNama,
  bool overdue,
  String desc,
  TaskModel datas,
  List<SubTaskModel> subtask,
  Function() funcEdit,
  Function() funcDel,
) {
  final TaskController taskController = Get.put(TaskController());
  return Padding(
    padding: EdgeInsets.only(bottom: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: Get.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 0.7, color: Colors.black87)),
                child: Image.asset(
                  assets,
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ),
              wbox(15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            textInter(
                                titleNama, Colors.black, FontWeight.bold, 16),
                            wbox(15),
                            textInter(overdue == false ? '' : '⚠ Overdue',
                                Colors.black, FontWeight.bold, 16),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Checkbox(
                              value: datas.isCompleted,
                              onChanged: (value) {
                                taskController.toggleTaskStatus(
                                    datas.id!, value!);
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                    hbox(2),
                    textInter(desc, Colors.black87, FontWeight.w600, 14),
                    hbox(6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: funcEdit,
                          child: Image.asset(
                            AssetsHelper.icEditing,
                            height: 20,
                            width: 20,
                          ),
                        ),
                        wbox(10),
                        InkWell(
                          onTap: funcDel,
                          child: Image.asset(
                            AssetsHelper.icBin,
                            height: 20,
                            width: 20,
                          ),
                        ),
                        wbox(10),
                        InkWell(
                          onTap: funcTap,
                          child: Container(
                            width: Get.width * 0.25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.blue[100]),
                            child: Padding(
                              padding: EdgeInsets.all(4),
                              child: Center(
                                child: textInter('+Add Subtask', Colors.black,
                                    FontWeight.bold, 12),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    subtask.isEmpty ? hbox(0) : hbox(10),
                    subtask.isEmpty
                        ? hbox(0)
                        : textInter(
                            'Subtask :', Colors.black, FontWeight.w600, 14),
                    subtask.isEmpty
                        ? hbox(0)
                        : Container(
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: subtask.length,
                                itemBuilder: (context, i) {
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          textInter(
                                              subtask[i].title,
                                              Colors.black87,
                                              FontWeight.w600,
                                              14),
                                          Checkbox(
                                            value: subtask[i].isCompleted,
                                            onChanged: (value) {
                                              taskController
                                                  .toggleSubTaskStatus(
                                                      subtask[i].id!, value!);
                                            },
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.offAll(() => EditSubTaskPage(
                                                  taskModel: datas,
                                                  subtaskModel: subtask[i]));
                                            },
                                            child: Image.asset(
                                              AssetsHelper.icEditing,
                                              height: 20,
                                              width: 20,
                                            ),
                                          ),
                                          wbox(10),
                                          InkWell(
                                            onTap: () {
                                              taskController.deleteSubTask(
                                                  subtask[i].id!);
                                            },
                                            child: Image.asset(
                                              AssetsHelper.icBin,
                                              height: 20,
                                              width: 20,
                                            ),
                                          ),
                                          wbox(10),
                                        ],
                                      ),
                                    ],
                                  );
                                }),
                          )
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1,
          color: Colors.grey[400],
          indent: 90,
        )
      ],
    ),
  );
}

AppBar appBarHome(BuildContext context, String title, String subtitle) {
  return AppBar(
    leading: Padding(
      padding: EdgeInsets.only(left: 10),
      child: Image.asset(
        AssetsHelper.imgProfile,
        height: 15,
        width: 15,
      ),
    ),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textInter(title, Colors.black, FontWeight.w700, 16),
        textInter(subtitle, Colors.black87, FontWeight.w300, 14),
      ],
    ),
  );
}

Future<void> showMyDialog(BuildContext context, String title, String subtitle,
    Function() funcYes) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(subtitle),
        actions: <Widget>[
          TextButton(
            child: Text('No'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text('Yes'),
            onPressed: funcYes,
          ),
        ],
      );
    },
  );
}

DropdownButtonFormField<String> dropdownString(String title, String? value,
    List<DropdownMenuItem<String>>? items, Function(String?)? onChanged) {
  return DropdownButtonFormField<String>(
    value: value,
    items: items,
    onChanged: onChanged,
    decoration: InputDecoration(
      labelText: title,
      border: OutlineInputBorder(),
    ),
  );
}

dropdownStringRadius(String title, String? value,
    List<DropdownMenuItem<String>>? items, Function(String?)? onChanged) {
  return Container(
    padding: EdgeInsets.only(
      left: 15,
    ),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black87, width: 0.8)),
    child: DropdownButtonFormField<String>(
      icon: SizedBox(),
      value: value,
      isExpanded: true,
      items: items,
      onChanged: onChanged,
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.arrow_drop_down_outlined),
        labelText: title,
        border: InputBorder.none,
      ),
    ),
  );
}

DropdownButtonFormField<String> dropdownStringExpand(
    String title,
    String? value,
    List<DropdownMenuItem<String>>? items,
    Function(String?)? onChanged) {
  return DropdownButtonFormField<String>(
    isExpanded: true,
    value: value,
    items: items,
    onChanged: onChanged,
    decoration: InputDecoration(
      labelText: title,
      border: OutlineInputBorder(),
    ),
  );
}

DropdownButtonFormField<int> dropdownInt(String title, int? value,
    List<DropdownMenuItem<int>>? items, Function(int?)? onChanged) {
  return DropdownButtonFormField<int>(
    value: value,
    items: items,
    onChanged: onChanged,
    decoration: InputDecoration(
      labelText: title,
      border: OutlineInputBorder(),
    ),
  );
}
