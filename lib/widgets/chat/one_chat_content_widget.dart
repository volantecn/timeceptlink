import 'package:app_ios/factory/dialogue_factory.dart';
import 'package:app_ios/factory/message_factory.dart';
import 'package:app_ios/models/dialogue_model.dart';
import 'package:app_ios/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import '../message/one_message_main_widget.dart';
import '../public/clip_widget.dart';



class OneChatContentWidget extends StatelessWidget {
  final Dialogue?dialogue;
  final List<MessageModel>?messages;
  final ScrollController? controller;
  const OneChatContentWidget({super.key,@required this.dialogue,@required this.messages,this.controller});


  String _displayDate(String value){

    if(value==DateFormat("yyyy-MM-dd").format(DateTime.now())){

      return "Today";
    }else{
      if(value==DateFormat("yyyy-MM-dd").format(DateTime.now().subtract(Duration(days: 1)))){
        return "Yesterday";
      }else{
        return value;
      }
    }

  }


  @override
  Widget build(BuildContext context) {


    var filtedMessage=messages?.where((one) => one.messageType!="Action").toList()??[];



    DateTime lable=(filtedMessage.length??0)>0?(filtedMessage[0].postDateTime??DateTime.now()):DateTime.now();



    WidgetsBinding.instance.addPostFrameCallback((_){
      if(controller?.hasClients??false){
        //controller?.jumpTo(MessageFactory.to.position??0);
        debugPrint(">>>>>>>>>>>>>>>>>>>>DIM${controller?.position.viewportDimension}<<<<<<<<<<<<<<<<<<<<<<<<<<");
        DialogueFactory.to.enterDialogueCancelNewMessage(dialogue?.id??0);
      }
    });





    if(filtedMessage.isNotEmpty){
      filtedMessage[0].isFirst=true;

      for(int i=1;i<filtedMessage.length;i++){
        filtedMessage[i].isFirst=filtedMessage[i-1].receiver!=filtedMessage[i].receiver;
      }
    }




    return NotificationListener<ScrollEndNotification>(
      onNotification: (ScrollNotification t) {
        if(controller?.hasClients??false){

          MessageFactory.to.position=t.metrics.pixels;

          //到达顶部
          if(t.metrics.pixels==controller?.position.maxScrollExtent){


            debugPrint(">>>>>>>>>>>>>>>>>>>>DIM${controller?.position.viewportDimension}<<<<<<<<<<<<<<<<<<<<<<<<<<");
            debugPrint(">>>>>>>>>>>>>>>>>>>>MAX${controller?.position.maxScrollExtent}<<<<<<<<<<<<<<<<<<<<<<<<<<");
            debugPrint(">>>>>>>>>>>>>>>>>>>>P${t.metrics.pixels}<<<<<<<<<<<<<<<<<<<<<<<<<<");

            SmartDialog.showLoading();
            if(context.mounted){
              MessageFactory.to.loadOneChatNextPage30Messages("${dialogue?.id??""}", lable);
            }
            SmartDialog.dismiss();

          }
        }

        return true;
      },
      child: GroupedListView<MessageModel, String>(
        elements: filtedMessage,
        groupBy: (message) => message.groupDate,


        controller: controller,
        reverse: true,
        shrinkWrap: true,
          itemBuilder: (context, MessageModel message) =>OneMessageWidget(message: message,), //OneMessageWidget(message: message,),
          itemComparator: (item1, item2) => item1.postDateTime.toString().compareTo(item2.postDateTime.toString()), // optional
          useStickyGroupSeparators: false, // optional
          floatingHeader: true, // optional
          order: GroupedListOrder.DESC, // optional

          groupSeparatorBuilder: (String value) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: ClipWidget(
                child: Text(_displayDate(value),style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),),
              ),
            ),
          )

      ),
    );
  }
}
