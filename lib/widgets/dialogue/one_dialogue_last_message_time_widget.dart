import 'package:app_ios/models/dialogue_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OneDialogueLastMessageTime extends StatelessWidget {
  final Dialogue?dialogue;
  const OneDialogueLastMessageTime({super.key,@required this.dialogue});

  @override
  Widget build(BuildContext context) {
    final message=dialogue!.lastMessageTime();

    return FutureBuilder<DateTime?>(
      future:message,
      builder: (_,m){
        return AutoSizeText("${DateFormat("yyyy-MM-dd HH:mm:ss").format(m.data??DateTime.now())}",maxLines: 1,overflow: TextOverflow.ellipsis,minFontSize: 12,);
      },
    );
  }
}
