import 'package:flutter/material.dart';

class SettingCardFrameWidget extends StatelessWidget {
  final Widget? child;
  const SettingCardFrameWidget({Key? key,@required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        margin: EdgeInsets.zero,
        color: Colors.grey.shade50,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: child,
        ),
      ),
    );
  }
}
