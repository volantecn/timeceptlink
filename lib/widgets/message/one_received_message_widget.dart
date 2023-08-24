import 'package:app_ios/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'bubble_frame_widget.dart';
import 'one_received_message_content_widget.dart';

class OneReceiveMessageContent extends StatelessWidget {
  final MessageModel?message;
  const OneReceiveMessageContent({super.key,@required this.message});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: BubbleFrameWidget(message:message,child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            OneReceivedMessageContentWidget(message: message,),

            SizedBox(height: 4,),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("${DateFormat("HH:mm:ss").format(message?.postDateTime??DateTime.now())}",style: const TextStyle(color: Colors.grey,fontSize: 12,)),

                if(message?.senderPosition!=null)Icon(Icons.location_on_outlined,size: 12,color: Theme.of(context).colorScheme.primary,)
              ],
            ),
          ],),
          isReceiver: true,
        ),flex: 4,),

        Expanded(child: SizedBox.shrink(),flex: 1,)
      ],
    );

  }
}
