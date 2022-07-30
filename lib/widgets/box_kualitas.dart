import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_altonik/widgets/widget.dart';

Widget boxKualitas(String title, [int value = 0]) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    child: Material(
      borderRadius: BorderRadius.circular(5),
      elevation: 5,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            border: Border.all(color: mainColor.withOpacity(0.7)),
            color: value == 1
                ? Colors.white
                : value == 0
                    ? Colors.green.withOpacity(0.5)
                    : mainColor,
            borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: value == 1 ? mainColor : Colors.white, fontSize: 24),
          ),
        ),
      ),
    ),
  );
}
