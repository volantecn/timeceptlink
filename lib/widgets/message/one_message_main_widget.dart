import 'package:app_ios/models/message_model.dart';
import 'package:flutter/material.dart';

import '../../factory/user_factory.dart';
import 'one_received_message_widget.dart';
import 'one_send_message_widget.dart';

class OneMessageWidget extends StatelessWidget {
  final MessageModel? message;
  const OneMessageWidget({super.key,@required this.message});

  @override
  Widget build(BuildContext context) {


    bool toMe=message?.receiver==UserFactory().userId;

    //var _width=MediaQuery.of(context).size.width;

    return  !toMe?  OneSendMessageContentWidget(message: message,):OneReceiveMessageContent(message: message);
  }
}
