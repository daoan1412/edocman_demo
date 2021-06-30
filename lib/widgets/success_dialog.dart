import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessDialog extends StatelessWidget {
  final String title, descriptions, text;

  const SuccessDialog({Key? key, required this.title,required this.descriptions,required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    final defaultSize = 16.toDouble();

    return Container(
      padding: EdgeInsets.only(
          left: defaultSize,
          top: 2.5 * defaultSize,
          right: defaultSize,
          bottom: defaultSize),
      margin: EdgeInsets.only(top: 1.5 * defaultSize),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: defaultSize),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.check_circle,
                  size: 32,
                  color: Colors.green,
                ),
                SizedBox(width: defaultSize + 0.8),
                Flexible(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 1.5 * defaultSize,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultSize),
            child: Text(
              descriptions,
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 2.2 * defaultSize,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FlatButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  text,
                  style: TextStyle(fontSize: 18, color: Colors.indigo),
                )),
          ),
        ],
      ),
    );
  }
}
