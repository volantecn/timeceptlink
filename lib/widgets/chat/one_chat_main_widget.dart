import 'package:app_ios/factory/block_factory.dart';
import 'package:app_ios/factory/dialogue_factory.dart';
import 'package:app_ios/factory/message_factory.dart';
import 'package:app_ios/widgets/chat/one_chat_shart_loaction_switch_widget.dart';
import 'package:flutter/material.dart';

import '../../models/dialogue_model.dart';
import 'package:get/get.dart';
import 'one_chat_bottom_bar_widget.dart';
import 'one_chat_content_widget.dart';
import 'one_chat_share_location_warning_bar_widget.dart';
import 'one_chat_title_widget.dart';


class OneChatMainWidget extends StatelessWidget {
  final Dialogue? dialogue;
  const OneChatMainWidget({super.key,@required this.dialogue});

  @override
  Widget build(BuildContext context) {
    ScrollController _controller=ScrollController();




    return Scaffold(

      appBar: AppBar(
        title: OneChatTitleWidget(dialogue: dialogue,),

        actions: [
          OneChatShareLocationSwitchWidget()
          //后续必须补充位置信息
        ],
      ),

      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(

          children: [

            OneChatShareLocationWarningBarWidget(),


            Expanded(child: Obx(
                    ()=>OneChatContentWidget(dialogue: dialogue,messages: MessageFactory.to.messages.value
                    .where((one)=>one.chatId=="${dialogue?.id}").toList(),
                  controller: _controller,
                )
            )),
            GetBuilder<BlockFactory>(
                builder: (_){

                  return _.allowToReceive(dialogue?.receiverId??"")?OneChatBottomToolBarWidget(dialogue: dialogue,controller: _controller,):ListTile(title: Text("Blocked"),);

                }),
          ],
        ),
      ),
    );
  }
}











