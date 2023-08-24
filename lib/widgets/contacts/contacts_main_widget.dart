import 'package:app_ios/factory/contact_factory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'contacts_content_widget.dart';
class ContactsMainWidget extends StatelessWidget {
  const ContactsMainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200
      ),

      child: Padding(
        padding: EdgeInsets.only(top: 10,bottom: 10),

        child:  Obx(()=>ContactContentWidget(contacts: ContactFactory.to.contacts.value,)),

      ),
    );
  }
}
