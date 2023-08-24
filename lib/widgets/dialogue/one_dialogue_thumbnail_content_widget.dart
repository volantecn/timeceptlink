import 'package:app_ios/contract/pre_define.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';

import '../../models/contact_item_model.dart';
import '../../models/dialogue_model.dart';

class OneDialogueThumbnailContentWidget extends StatelessWidget {
  final Dialogue? dialogue;
  final ContactThumbnail?user;
  const OneDialogueThumbnailContentWidget({Key? key,@required this.dialogue,@required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {



    return RichText(
      text: TextSpan(
        text: '${user?.desc}',
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[

          if(dialogue?.shareLocation??false) TextSpan(text:"(Sharing position)", style: TextStyle(fontSize:16,color: Colors.grey)),
          TextSpan(text:((dialogue?.newMessage??false) ||(dialogue?.sender()?.isTemporary ??false) )?" ${HtmlSymbol.dot}":"", style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold,color: Colors.red)),

        ],
      ),
    );
  }
}