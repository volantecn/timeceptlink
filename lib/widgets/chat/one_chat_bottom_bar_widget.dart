import 'package:app_ios/factory/send_message_factory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/dialogue_model.dart';
import 'one_chat_bottom_expend_tool_bar_widget.dart';
import 'one_chat_bottom_main_bar_widget.dart';

class OneChatBottomToolBarWidget extends StatelessWidget {
  final Dialogue?dialogue;
  final ScrollController? controller;
  const OneChatBottomToolBarWidget({super.key,@required this.dialogue,@required this.controller});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        if(SendMessageFactory.to.expend.value){
          SendMessageFactory.to.expend(false);
          return false;
        }else{
          return true;
        }
      },
      child: SizedBox(
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade100
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 6,bottom: 4),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(()=>OneChatBottomMainBarWidget(dialogue: dialogue,controller: controller,editMessage: SendMessageFactory.to.message.value,)),//第一行的按键
                Obx(()=>OneChatBottomExpendTootbarWidget(dialogue: dialogue,expended: SendMessageFactory.to.expend.value,))

              ],
            ),

          ),
        ),
      ),
    );
  }
}
