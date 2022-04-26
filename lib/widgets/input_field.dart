import 'package:flutter/material.dart';
import '../ui/theme.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  const MyInputField({
    Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: subHeadingStyle,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget == null ? false : true,
                    textAlign: TextAlign.center,
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                widget == null
                    ? Container()
                    : Container(
                        child: widget,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
