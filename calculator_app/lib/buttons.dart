import 'package:flutter/material.dart';

//this class is the design for one button which can be reused later
class MyButton extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttonTapped;

  MyButton({this.color, this.textColor, required this.buttonText, this.buttonTapped});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
            BoxShadow(color: Colors.black26, offset: Offset.zero, blurRadius: 3, spreadRadius:-1),
          ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              color: color,
              child: Center(
                child: Text(
                  buttonText,
                  style: TextStyle(color: textColor, fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
