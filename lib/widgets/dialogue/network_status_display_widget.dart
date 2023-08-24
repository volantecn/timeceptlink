import 'package:app_ios/factory/network_status_factory.dart';
import 'package:flutter/material.dart';

class NetWorkStatusDisplayWidget extends StatelessWidget {

  final bool?connected;
  const NetWorkStatusDisplayWidget({super.key,@required this.connected});

  @override
  Widget build(BuildContext context) {
    return (connected??false)?SizedBox.shrink():SizedBox(
      height: 48,
      child: Container(
        color: Colors.amber,
        child:Center(child:  Text("${NetWorkStatusFactory.to.prompt}"),),
      ),
    );
  }
}
