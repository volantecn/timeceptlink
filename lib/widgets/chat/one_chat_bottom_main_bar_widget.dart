
import 'package:app_ios/factory/location_factory.dart';
import 'package:app_ios/factory/time_zone_factory.dart';
import 'package:app_ios/models/dialogue_model.dart';
import 'package:app_ios/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import '../../factory/chat_factory.dart';
import '../../factory/contact_factory.dart';
import '../../factory/send_message_factory.dart';

class OneChatBottomMainBarWidget extends StatelessWidget {
  final Dialogue?dialogue;
  final MessageModel?editMessage;
  final ScrollController? controller;
  const OneChatBottomMainBarWidget({super.key,@required this.dialogue,@required this.controller,this.editMessage});

  @override
  Widget build(BuildContext context) {

    TextEditingController _controller=TextEditingController(text: editMessage?.content??"");


    return Row(
      children: [
        Expanded(flex: 1,child: IconButton(icon: Icon(Icons.attach_file,),onPressed: (){

          SendMessageFactory.to.expend(!SendMessageFactory.to.expend.value);

        },)),
        Expanded(flex: 6,child:TextField(
          controller: _controller,
          keyboardType: TextInputType.multiline,
          autofocus: false,
          //focusNode: _editFocusNode,
          maxLines: 5,
          minLines: 1,


          decoration: const InputDecoration(

            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(6),
          ),
        ), ),
        Expanded(flex: 1,child: IconButton(icon: const Icon(Icons.schedule),onPressed: ()async{
          //发送预约信息
          int gmt=ContactFactory.to.getOneById(dialogue?.receiverId??"")?.gmt??0;
          var content=_controller.text;

          DateTime _receiverNow=TimeZoneFactory.to.getTimeZoneDateTime(gmt);

          DateTime _minTime=_receiverNow.add(const Duration(minutes: 4));

          DateTime currentTime=editMessage?.scheduleDateTime??(_minTime.add(const Duration(minutes: 1)));

          DateTime?sceduledDateTime =await showOmniDateTimePicker(
              context: context,
              is24HourMode: true,
              firstDate:DateTime.now().subtract(Duration(days: 1)),

              
              initialDate:currentTime
          );


          if(sceduledDateTime!=null && content.isNotEmpty){
            var response=await SignalChatFactory().sendScheduledTextMessage(dialogue?.receiverId??"", "${dialogue?.id??0}", content,sceduledDateTime,editMessage?.id,gmt); //MessageId =null新建一个预约信息，如果不空，修改一个

            if(response!=null){
              if(editMessage!=null){
                SendMessageFactory.to.emptyMessage();
              }
              _controller.text="";

            }else{
              ScaffoldMessenger.of(context).showMaterialBanner(const MaterialBanner(content: Text("Internet connection error"),actions: [], ));
            }

          }



        },)),
        Expanded(flex: 1,child: IconButton(icon: const Icon(Icons.send),onPressed: ()async{

          var content=_controller.text;

          if(content.isNotEmpty){
            var response=await SignalChatFactory().sendTextMessage(dialogue?.receiverId??"", "${dialogue?.id??""}", content,
                (dialogue?.shareLocation??false)? LocationFactory.to.currentPosition.value:null );

            if(response!=null){
              _controller.text="";

              controller?.jumpTo(0);

            }else{

              ScaffoldMessenger.of(context).showMaterialBanner(const MaterialBanner(content: Text("Internet connection error"),actions: [], ));
            }

          }else{

            SmartDialog.showToast("Please enter the content before sending");
          }



        },)),

      ],
    );
  }
}
