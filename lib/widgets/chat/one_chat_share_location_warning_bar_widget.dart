import 'package:app_ios/factory/dialogue_factory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../factory/location_factory.dart';
import '../../gen/strings.g.dart';
import '../../models/contact_item_model.dart';
import '../../models/dialogue_model.dart';
import 'package:get/get.dart';
class OneChatShareLocationWarningBarWidget extends StatelessWidget {



  const OneChatShareLocationWarningBarWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<DialogueFactory>(builder: (_){

      var _dialogue=(_.currentDialogue.value);

      return  (_dialogue.shareLocation??false)? Container(
        decoration: BoxDecoration(
            color: Colors.amber
        ),
        child:  ListTile(
          leading: Icon(Icons.share_location_sharp),
          title: Text("${t.message.shareLocation(person:"${_dialogue.sender()?.desc??""}")}"),
        ),
      ):SizedBox.shrink();

    });


  }
}
