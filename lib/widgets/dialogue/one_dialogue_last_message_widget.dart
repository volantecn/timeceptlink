import 'package:app_ios/models/dialogue_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class OneDialogueLastMessageWodget extends StatelessWidget {
  final Dialogue?dialogue;
  const OneDialogueLastMessageWodget({super.key,@required this.dialogue});

  @override
  Widget build(BuildContext context) {

    final message=dialogue!.lastMessage();

    return FutureBuilder<String?>(
        future:message,
        builder: (_,m){
          return AutoSizeText("${m.data??""}",maxLines: 1,overflow: TextOverflow.ellipsis,minFontSize: 12,);
        },
    );
  }
}
