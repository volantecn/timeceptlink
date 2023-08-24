import 'package:app_ios/factory/location_factory.dart';
import 'package:app_ios/models/contact_item_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../models/dialogue_model.dart';

class OneChatTitleWidget extends StatelessWidget {
  final Dialogue? dialogue;
  const OneChatTitleWidget({super.key,@required this.dialogue});

  @override
  Widget build(BuildContext context) {

    var contact=dialogue?.sender();
    if(contact!=null){

      var tels=contact.contactTel?.split(",")??[];

      var _t=tels.fold("", (previousValue, element) => "$previousValue$element");

      return Text("${contact.desc} $_t");

    }else{

      return Text("");

    }
  }
}
