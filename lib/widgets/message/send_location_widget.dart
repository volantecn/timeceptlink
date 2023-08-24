
import 'package:flutter/material.dart';


import '../../factory/chat_factory.dart';
import '../../models/dialogue_model.dart';
import '../../models/location_model.dart';
import '../location/map_search_picker_widget.dart';


class SendLoacationWidget extends StatelessWidget {
  final Dialogue? dialogue;

  final VoidCallback?selectDone;

  const SendLoacationWidget({Key? key,@required this.dialogue,@required this.selectDone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.location_on_sharp),
      onPressed: ()async{
        LocationThumbnail? address=await Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const MapSearchPickerWidget()));

        if(address!=null){
          SignalChatFactory().sendLocationMessage(dialogue?.receiverId??"", "${dialogue?.id??0}", address);

          selectDone!();
        }


      },
    );
  }
}