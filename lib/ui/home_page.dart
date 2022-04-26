import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_bestech/services/notification_services.dart';
import 'package:todo_bestech/services/theme_services.dart';
import 'package:todo_bestech/ui/theme.dart';

import '../widgets/button.dart';
import 'add_task_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
        ],
      ),
    );
  }

  _addDateBar() {
    return Container(
      child: DatePicker(
        DateTime.now(),
        height: 80,
        width: 60,
        initialSelectedDate: DateTime.now(),
        selectionColor: Colors.blue,
        dateTextStyle: GoogleFonts.lato(
          fontSize: 17,
          color: Colors.blueGrey,
        ),
        dayTextStyle: TextStyle(
          fontSize: 12,
          color: Colors.blueGrey,
        ),
        monthTextStyle: TextStyle(
          fontSize: 12,
          color: Colors.blueGrey,
        ),
        onDateChange: (date) {
          _selectedDate = date;
        },
      ),
    );
  }

  _addTaskBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat.yMMMMd().format(DateTime.now()),
                    style: subHeadingStyle),
                Text(
                  'Today',
                  style: headingStyle,
                ),
              ],
            ),
          ),
          MyButton(
              label: '+ Add Task',
              onTap: () {
                Get.to(() => AddTaskPage());
              }),
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          ThemeServices().switchTheme();
        },
        icon: Icon(
          Icons.nightlight_round_outlined,
          size: 20,
        ),
      ),
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage('images/profile.jpg'),
          radius: 15,
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
