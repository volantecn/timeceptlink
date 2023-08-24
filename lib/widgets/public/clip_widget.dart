import 'package:flutter/material.dart';

class ClipWidget extends StatelessWidget {

  final Widget? child;
  const ClipWidget({super.key,@required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),

        child: child,
      ),
    );
  }
}
