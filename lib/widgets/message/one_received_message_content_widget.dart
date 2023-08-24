import 'dart:convert';

import 'package:app_ios/models/message_model.dart';
import 'package:app_ios/widgets/message/position_message_thumnail_display_widget.dart';
import 'package:flutter/material.dart';

import '../../contract/pre_define.dart';
import '../../factory/contact_factory.dart';
import '../../models/url_model.dart';

class OneReceivedMessageContentWidget extends StatelessWidget {
  final MessageModel?message;
  const OneReceivedMessageContentWidget({super.key,@required this.message});

  @override
  Widget build(BuildContext context) {
    Widget re=const SizedBox.shrink();


    if(message?.messageType=="Text"){

      re= Text('${message?.content}');


    }
    if(message?.messageType=="Location"){

      re=PositionMessageThumbnailDisplayWidget(message: message,isReceiver: true,);
    }

    if(message?.messageType=="Url"){

      UrlMessageThumbnail url=UrlMessageThumbnail.fromJson( jsonDecode(message?.content??"{}"));
      re=SizedBox(
        height: 20,
        width:150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(ConstantSetting().symbolToIcon[url.queryWord]),
            const VerticalDivider(),
            Text("Near ${ContactFactory.to.getOneById(message?.poster??"")?.desc} ")
          ],
        ),
      );
    }


    return re;
  }
}
