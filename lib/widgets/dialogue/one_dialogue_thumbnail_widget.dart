import 'package:app_ios/factory/dialogue_factory.dart';
import 'package:app_ios/factory/message_factory.dart';
import 'package:app_ios/models/contact_item_model.dart';
import 'package:app_ios/widgets/chat/one_chat_temp_content_widget.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../factory/contact_factory.dart';
import '../../factory/location_factory.dart';
import '../../gen/strings.g.dart';
import '../../models/dialogue_model.dart';
import '../chat/one_chat_main_widget.dart';
import 'one_dialogue_last_message_time_widget.dart';
import 'one_dialogue_last_message_widget.dart';
import 'one_dialogue_status_widget.dart';
import 'one_dialogue_thumbnail_content_widget.dart';

class OneDialogueThumbnailWidget extends StatelessWidget {
  final Dialogue? dialogue;
  const OneDialogueThumbnailWidget({Key? key,@required this.dialogue}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var receiver=dialogue?.sender();

    bool _isTemp=receiver?.isTemporary??true;




    final t = Translations.of(context);

    return Container(
      color: Colors.grey.shade50,
      child: Padding(
        // ignore: prefer_const_constructors
        padding: EdgeInsets.only(top:8,bottom: 8),
        child: ListTile(

          leading:OneDialogueThumbnailStatusWidget(receiver: receiver) ,

          title: OneDialogueThumbnailContentWidget(dialogue: dialogue,user: receiver,),

          subtitle: _isTemp?Text(t.contact.addRequirement):OneDialogueLastMessageWodget(dialogue: dialogue,),

          trailing: OneDialogueLastMessageTime(dialogue: dialogue),

          onTap: ()async{


            DialogueFactory.to.enterDialogueCancelNewMessage(dialogue?.id??0);

            MessageFactory.to.loadOneChatLast30Messages("${dialogue?.id??0}");

            if(dialogue?.shareLocation??false){

              await LocationFactory.to.firstGetCurrentPosition();

            }

            if(_isTemp){
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>OneChatTempContentWidget(dialogue: dialogue,),fullscreenDialog: false));

            }else{
              DialogueFactory.to.currentDialogue(dialogue!);
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>OneChatMainWidget(dialogue: dialogue,),fullscreenDialog: false));

            }





          },
        ),
      ),
    );
  }
}




