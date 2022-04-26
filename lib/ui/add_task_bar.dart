import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_bestech/controllers/task_controller.dart';
import 'package:todo_bestech/models/task.dart';
import 'package:todo_bestech/ui/theme.dart';
import 'package:todo_bestech/widgets/button.dart';
import '../widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  TextEditingController _titleController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime = '9:30 PM';
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedRepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
  int _selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        toolbarHeight: 40,
        elevation: 0,
        //backgroundColor: context.theme.backgroundColor,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Add Task',
                style: headingStyle,
              ),
              MyInputField(
                controller: _titleController,
                hint: 'Enter your title',
                title: 'Title',
              ),
              MyInputField(
                controller: _noteController,
                hint: 'Enter your note',
                title: 'Note',
              ),
              MyInputField(
                hint: DateFormat.yMMMd().format(_selectedDate),
                title: 'Date',
                widget: IconButton(
                  onPressed: () {
                    _getDateFromUser();
                  },
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      title: 'Start Time',
                      hint: _startTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: true);
                        },
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: MyInputField(
                      title: 'End Time',
                      hint: _endTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: false);
                        },
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              MyInputField(
                title: 'Remind',
                hint: '$_selectedRemind minutes early',
                widget: DropdownButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    iconSize: 25,
                    elevation: 4,
                    items:
                        remindList.map<DropdownMenuItem<String>>((int value) {
                      return DropdownMenuItem<String>(
                          value: value.toString(),
                          child: Text(value.toString()));
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRemind = int.parse(newValue!);
                      });
                    }),
              ),
              MyInputField(
                title: 'Repeat',
                hint: _selectedRepeat,
                widget: DropdownButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    iconSize: 25,
                    elevation: 4,
                    items: repeatList
                        .map<DropdownMenuItem<String>>((String? value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value!),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRepeat = newValue!;
                      });
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _colorPalette(),
                  MyButton(
                      label: 'Create Task',
                      onTap: () {
                        _validateData();
                      })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _validateData() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDb();

      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar('Required', 'All fields are required',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  _addTaskToDb() {
    task:
    Task(
      note: _noteController.text,
      title: _titleController.text,
      date: DateFormat.yMd().format(_selectedDate),
      startTime: _startTime,
      endTime: _endTime,
      remind: _selectedRemind,
      repeat: _selectedRepeat,
      color: _selectedColor,
      isCompleted: 0,
    );
  }

  Widget _colorPalette() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: subHeadingStyle,
        ),
        Wrap(
          children: List<Widget>.generate(
              3,
              (int index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColor = index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: index == 0
                            ? Colors.blue
                            : index == 1
                                ? Colors.red
                                : Colors.yellow,
                        child: _selectedColor == index
                            ? Icon(Icons.done)
                            : Container(),
                      ),
                    ),
                  )),
        )
      ],
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2023));
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      print('Pick up correct date');
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formattedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print('Time cancelled');
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formattedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formattedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay.now());
  }
}
