import 'package:app_ios/factory/dialogue_factory.dart';
import 'package:app_ios/factory/network_status_factory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/dialogue_model.dart';
import 'network_status_display_widget.dart';
import 'one_dialogue_thumbnail_widget.dart';

class DialogueMainWidget extends StatelessWidget {
  const DialogueMainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(()=>NetWorkStatusDisplayWidget(connected: NetWorkStatusFactory.to.connected.value,)),


        Expanded(child: Obx(()=>DialogueListWidget(dialogues: DialogueFactory.to.dialogues.value,))),
      ],
    );
  }
}




class DialogueListWidget extends StatelessWidget {
  final List<Dialogue>? dialogues;
  const DialogueListWidget({super.key,@required this.dialogues});

  @override
  Widget build(BuildContext context) {

    var _list=dialogues?.where((one) => !(one.sender()?.isTemporary??true)).toList() ??[];

    return ListView.separated(
      itemCount: _list.length,

      itemBuilder: (_,index)=>OneDialogueThumbnailWidget(dialogue:_list[index] ,),
      // ignore: prefer_const_constructors
      separatorBuilder: (BuildContext context, int index) =>SizedBox(height: 10,),
    );
  }
}
