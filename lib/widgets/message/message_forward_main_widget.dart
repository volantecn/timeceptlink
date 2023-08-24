
import 'package:app_ios/factory/dialogue_factory.dart';
import 'package:app_ios/factory/message_factory.dart';
import 'package:app_ios/models/dialogue_model.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../gen/strings.g.dart';
import '../../models/message_model.dart';
import '../chat/one_chat_main_widget.dart';

class MessageForwardMainWidget extends StatelessWidget {
  final MessageModel?messgae;

  const MessageForwardMainWidget({super.key,@required this.messgae});

  @override
  Widget build(BuildContext context) {

    //全部非暂时的对话，
    //按照最后更新时间倒叙排列
    var chatList=DialogueFactory.to.dialogues.value.where((one) => !(one.sender()?.isTemporary??false))
      .sorted((a, b) => b.lastDateTime?.compareTo(a.lastDateTime??DateTime.now())??-1);

    final t = Translations.of(context);


    return Scaffold(
    appBar: AppBar(

      title: Text(t.message.forward),
    ),
    backgroundColor: Colors.grey.shade200,
    body: SafeArea(
    child: Column(
      children: [
        SizedBox(height: 10,),
        SizedBox(
          height: 50,
          child: Text(t.message.chatList,textScaleFactor: 1.2,),
        ),
        Expanded(child: ListView(
          children: [
            ...chatList.map((one) => Padding(padding: EdgeInsets.only(bottom: 10),

              child: Container(
                color: Colors.white,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    child: Text(one.sender()?.groupId??"",style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),),

                  ),
                  title: Text("${one.sender()?.desc??""}"),

                  onTap: ()async{

                    messgae?.postDateTime=DateTime.now();
                    messgae?.reachedDateTime=DateTime.now();

                    await MessageFactory.to.addReSendMessage(messgae!,one.receiverId??"","${one.id}");




                    SmartDialog.showToast("消息已发送");

                  },
                ),
              ),

            )).toList()
          ],
        ))
      ],
    ),
    ),
    );
  }
}
