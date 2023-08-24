import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import '../../models/contact_item_model.dart';

class OneDialogueThumbnailStatusWidget extends StatelessWidget {
  final ContactThumbnail? receiver;


  const OneDialogueThumbnailStatusWidget({Key? key,@required this.receiver}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _temp=receiver?.isTemporary??true;



    return _temp?const Icon(BootstrapIcons.question_circle_fill,size: 24,color: Colors.grey,):CircleAvatar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: Text(receiver?.groupId??"",style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),),
    );
  }
}