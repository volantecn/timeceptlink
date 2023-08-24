import 'dart:convert';

import 'package:app_ios/models/message_model.dart';
import 'package:app_ios/models/url_model.dart';
import 'package:flutter/material.dart';

import '../../contract/pre_define.dart';
import '../../factory/message_factory.dart';
import '../../factory/time_zone_factory.dart';
import 'message_location_display_widget.dart';

class OneSendMessageContentMainWidget extends StatelessWidget {
  final MessageModel? message;
  const OneSendMessageContentMainWidget({super.key,@required this.message});

  @override
  Widget build(BuildContext context) {

    Widget re=SizedBox.shrink();

    if(message?.messageType=="Text") re= Text('${message?.content}',style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),);


    if(message?.messageType=="Url") {

      UrlMessageThumbnail url=UrlMessageThumbnail.fromJson(jsonDecode(message?.content??"{}"));

      re=SizedBox(
        height: 20,
        width: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(ConstantSetting().symbolToIcon[url.queryWord],color: Colors.white,),
            const VerticalDivider(),
            const Text("Near you",style:TextStyle(color: Colors.white))
          ],
        ),
      );

    }

    if(message?.messageType=="Location"){
      re=MessageLocationDisplayWidget(message: message,);
    }

    return re;
  }
}
