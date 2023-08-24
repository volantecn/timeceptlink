import 'package:flutter/material.dart';

class DividerWithTextWidget extends StatelessWidget {
  final Color? primaryColor;
  final String?title;
  final double length;
  const DividerWithTextWidget({Key? key,@required this.primaryColor,@required this.title,this.length=130}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: length, vertical: 8),
      child: Row(
        children: [
          Flexible(
            child: Container(
              height: 1,
              color: primaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              title??"or",
              // ignore: prefer_const_constructors
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Flexible(
            child: Container(
              height: 1,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
