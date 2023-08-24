import 'package:app_ios/factory/send_message_factory.dart';
import 'package:app_ios/models/dialogue_model.dart';
import 'package:app_ios/widgets/chat/send_some_near_me_buttons_widget.dart';
import 'package:flutter/material.dart';

import '../../contract/pre_define.dart';
import '../message/send_location_widget.dart';

class OneChatBottomExpendTootbarWidget extends StatelessWidget {
  final bool expended;
  final Dialogue? dialogue;

  const OneChatBottomExpendTootbarWidget({super.key,this.expended=false,@required this.dialogue});

  @override
  Widget build(BuildContext context) {
    return expended? SizedBox(
      height: kBottomNavigationBarHeight,
      child:ListView(
          scrollDirection: Axis.horizontal,
          children: [
            SendLoacationWidget(dialogue: dialogue,selectDone: (){
              SendMessageFactory.to.expend(false);
            },),

            ...ConstantSetting().symbolToIcon.keys.map((key) =>SendSomeNearMeButtonWidget(dialogue: dialogue,queryWord: key,selectDone: (){



            },) ).toList()



          ]
      )
    ):SizedBox.shrink();
  }
}
