
import 'package:app_ios/factory/dialogue_factory.dart';
import 'package:app_ios/factory/location_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:geolocator/geolocator.dart';

import '../../factory/chat_factory.dart';
import '../../models/dialogue_model.dart';

import 'package:get/get.dart';
class OneChatShareLocationSwitchWidget extends StatelessWidget {


  const OneChatShareLocationSwitchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {




    return  GetBuilder<DialogueFactory>(
      builder: (_)=>Switch(

          activeColor: Theme.of(context).colorScheme.onPrimary,
          activeTrackColor: Theme.of(context).colorScheme.secondary,
          inactiveThumbColor: Colors.grey,

          value: _.currentDialogue.value.shareLocation??false,
          onChanged: (state)async{

            try{

              if(state){
                var position=await LocationFactory.to.firstGetCurrentPosition();

                debugPrint("new position value new value${position?.accuracy}");

                if(position!=null){

                  _.updateShareLocation(DialogueFactory.to.currentDialogue.value.id, state);

                  await SignalChatFactory().sendTextMessage(DialogueFactory.to.currentDialogue.value.receiverId??"", "${DialogueFactory.to.currentDialogue.value.id}", "Start sharing position",
                      position );

                }else{
                  throw Exception("Get location failure");
                }
              }else{
                _.updateShareLocation(DialogueFactory.to.currentDialogue.value.id, state);
                await SignalChatFactory().sendTextMessage(DialogueFactory.to.currentDialogue.value.receiverId??"", "${DialogueFactory.to.currentDialogue.value.id}", "Stop sharing position",
                    null);
              }



            }catch(e){

              SmartDialog.showToast("$e");
            }
            finally{
              SmartDialog.dismiss(status: SmartStatus.loading);
            }



          }),
    );

  }
}
