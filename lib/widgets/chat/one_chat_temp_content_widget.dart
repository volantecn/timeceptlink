import 'package:app_ios/models/dialogue_model.dart';
import 'package:app_ios/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

import '../../factory/chat_factory.dart';
import '../../factory/contact_factory.dart';
import '../../factory/dialogue_factory.dart';
import '../../factory/message_factory.dart';
import '../../factory/user_factory.dart';
import '../../gen/strings.g.dart';
import '../../models/muted_action_model.dart';
import '../../services/contact_service.dart';
import 'one_chat_title_widget.dart';

class OneChatTempContentWidget extends StatelessWidget {
  final Dialogue?dialogue;
  const OneChatTempContentWidget({super.key,@required this.dialogue});

  @override
  Widget build(BuildContext context) {
    var receiver=dialogue?.sender();

    var tels=receiver?.contactTel?.split(",");
    var tel=tels?.fold("", (p, e) => "$p $e");


    final t = Translations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: OneChatTitleWidget(dialogue: dialogue,),
      ),

      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: Colors.grey.shade100),

          child: Padding(
            padding: EdgeInsets.all(10),
            child: Card(
              color: Colors.grey.shade50,
              child: Column(
                children: [
                  ListTile(
                    title: Text("${t.message.hello}",),
                  ),
                  ListTile(
                    title: Text("$tel"),
                  ),
                  const Divider(),
                  ListTile(


                    title: Text(t.contact.addRequirement),

                  ),
                  const Divider(indent: 30,),
                  ListTile(
                    leading: const Icon(Icons.person_add),
                    title: Text(t.contact.newContact),

                    onTap: ()async{
                      try{
                        try{
                          SmartDialog.showLoading();
                          await ContactService().modifyOneContact(UserFactory().user.id??"",receiver?.id??"" , false);

                          await ContactService().modifyOneContact(receiver?.id??"",UserFactory().user.id??"" , false);

                          MutedAction action=MutedAction(action: "AsyncContacts",process: "",lable: "",expiredTime: DateTime.now().add(Duration(minutes: 3)));

                          SignalChatFactory().sendActionMessage(receiver?.id??"", "",action,null);//要求对端同步CONTACTS

                          ContactFactory.to.loadContactsFromServer(forcedReload: true);

                          DialogueFactory.to.update();

                        }catch(e){

                        }finally{
                          SmartDialog.dismiss();
                        }

                        Navigator.of(context).pop();
                      }catch(e){

                        SmartDialog.showToast(t[e.toString().trim()]);
                      }finally{
                        SmartDialog.dismiss();
                      }

                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.block),
                    title: Text(t.contact.block),
                  )


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
