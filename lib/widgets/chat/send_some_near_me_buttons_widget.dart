
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';



import '../../contract/pre_define.dart';
import '../../factory/chat_factory.dart';
import '../../factory/location_factory.dart';
import '../../models/dialogue_model.dart';
import '../../models/url_model.dart';




class SendSomeNearMeButtonWidget extends StatelessWidget {
  final Dialogue? dialogue;

  final String? queryWord;

  final VoidCallback?selectDone;


  const SendSomeNearMeButtonWidget({Key? key,@required this.dialogue,@required this.queryWord,@required this.selectDone}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: ()async{

      try{



        var lg=await LocationFactory.to.firstGetCurrentPosition();

        if(lg!=null){


          await SignalChatFactory().sendUrlMessage(dialogue?.receiverId??"","${ dialogue?.id??0}",
              UrlMessageThumbnail(queryWord: queryWord,longitude: lg.longitude,latitude: lg.latitude)
          );

          selectDone!;
        }

      }on Exception catch (_){

      }finally{

      }


    }, icon: Icon(ConstantSetting().symbolToIcon[queryWord]));
  }
}










