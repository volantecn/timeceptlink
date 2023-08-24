import 'package:app_ios/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'bubble_frame_widget.dart';
import 'one_send_message_content_widget.dart';
import 'one_send_message_status_widget.dart';

class OneSendMessageContentWidget extends StatelessWidget {
  final MessageModel?message;
  const OneSendMessageContentWidget({super.key,@required this.message});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;





    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(child: SizedBox.shrink(),flex: 1,),
        Expanded(child:BubbleFrameWidget(message: message,child:  Column(

          crossAxisAlignment: CrossAxisAlignment.end,
          children: [


            OneSendMessageContentMainWidget(message: message,),



            OneMessageStatusWidget(message: message,)
          ],),),flex: 4,)
      ],
    );
  }
}
