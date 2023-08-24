import 'package:app_ios/factory/block_factory.dart';
import 'package:app_ios/factory/message_factory.dart';
import 'package:app_ios/factory/user_factory.dart';
import 'package:app_ios/services/contact_service.dart';
import 'package:app_ios/services/pop_dialogs.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';

import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';


import '../../contract/enums.dart';
import '../../factory/chat_factory.dart';
import '../../factory/contact_factory.dart';
import '../../factory/dialogue_factory.dart';
import '../../factory/location_factory.dart';
import '../../factory/time_zone_factory.dart';
import '../../gen/strings.g.dart';
import '../../models/contact_item_model.dart';
import '../../models/muted_action_model.dart';
import '../chat/one_chat_main_widget.dart';


class OneContactThumbnailWidget extends StatelessWidget {
  final ContactThumbnail? contact;
  const OneContactThumbnailWidget({Key? key,@required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    final t = Translations.of(context);
    var tels=contact?.contactTel?.split(",");

    var status=contact?.userStatus==UserStatus.Idle?"  Idle ":"Offline";

    String explain="${contact?.timeZoneName??""} GMT+${contact?.gmt??0}";

    bool requireAgree=false;

    if(contact?.isTemporary??true){

      if(contact?.comments=="Sender"){

        explain="正在等待对方通过您的添加请求";
      }
      if(contact?.comments=="Receiver"){
        requireAgree=true;
        explain="对方正在等待您通过添加请求";
      }

      if(contact?.remark=="Refused"){
        explain="您的请求已被拒绝";
      }

    }

    Widget icon=BlockFactory.to.allowToReceive(contact?.id??"")?  Column(

      children: [
        contact?.userStatus==UserStatus.Idle?Icon(BootstrapIcons.person_check,color: Colors.green,size: 24,)
            :Icon(BootstrapIcons.person_exclamation,color: Colors.grey,size: 24,),
        SizedBox(height: 6,),
        Text(status,style: TextStyle(color: Colors.grey),)
      ],
    ): Column(

      children: [
        Icon(Icons.block,color: Colors.grey,size: 24,),
        SizedBox(height: 6,),
        Text("Blocked",style: TextStyle(color: Colors.grey),)
      ],
    );


    return Card(
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        margin: const EdgeInsets.only(top:6,bottom: 6),
        color: Colors.grey.shade50,
        child:Padding(
          padding: EdgeInsets.only(left:0,right: 0,top:10,bottom: 10),
          child:  Column(
            children: [
              ListTile(
                leading: icon,
                title: Text("${contact?.desc}"),

                subtitle: Text("${tels?.fold("", (previousValue, element) => "$previousValue$element")}\n$explain"), //${TimeZoneFactory().diffofTwoTimeZone(contact?.gmt??0)}



                trailing:!(contact?.isTemporary??true)? DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    customButton: const Padding(
                      padding: EdgeInsets.only(left: 40,right: 5,top: 10,bottom: 10),
                      child: Icon(
                        Icons.more_vert,

                      ),
                    ),
                    onChanged: (value)async {
                      if(value=="Message"){

                        var dialogue=await DialogueFactory.to.getOneOrNewDialogue(contact?.id??"");

                        DialogueFactory.to.enterDialogueCancelNewMessage(dialogue?.id??0);

                        MessageFactory.to.loadOneChatLast30Messages("${dialogue?.id??0}");

                        if(dialogue?.shareLocation??false){

                          await LocationFactory.to.firstGetCurrentPosition();

                        }

                        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>OneChatMainWidget(dialogue: dialogue,),fullscreenDialog: false));
                      }
                      if(value=="Remove"){

                        var confirm=await PopDialog.of(context).delConfirm(title: t.contact.deleteConfirm);

                        if(confirm??false){
                          ContactFactory.to.removeOneFromServer(contact?.id??"");

                          DialogueFactory.to.removeOneByReceiverId(contact?.id??"");
                        }

                      }
                    },
                    itemHeight: 48,
                    itemPadding: const EdgeInsets.only(left: 16, right: 16),
                    dropdownWidth: 160,
                    dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      //color: Colors.redAccent,
                    ),
                    dropdownElevation: 8,
                    offset: const Offset(0, 8),
                    items: [
                      DropdownMenuItem<String>(
                        value: "Message",
                        child: Text(t.contact.message),
                      ),
                      DropdownMenuItem<String>(
                        value: "Remove",
                        child: Text(t.contact.remove),
                      ),

                      /*
                  *
                  *
                  * DropdownMenuItem<String>(
                    value: "Block",
                    child: Text(t.contact.block),
                  )
                  *
                  * */
                    ],
                  ),
                ):(contact?.remark=="Refused")?TextButton(onPressed: ()async{


                  try{

                    SmartDialog.showLoading();



                    await ContactFactory.to.removeOneFromServer(contact?.id??"");

                    await DialogueFactory.to.removeOneByReceiverId(contact?.id??"");

                  }catch(e){

                  }finally{
                    SmartDialog.dismiss();
                  }



                }, child: Text(t.contact.remove)):SizedBox.shrink(),


              ),

              if((contact?.isTemporary??true)&&(contact?.comments=="Receiver"))
                ButtonBar(
                  children: [
                    TextButton(onPressed: ()async{

                      try{
                        SmartDialog.showLoading();
                        await ContactService().modifyOneContact(UserFactory().user.id??"",contact?.id??"" , false);

                        await ContactService().modifyOneContact(contact?.id??"",UserFactory().user.id??"" , false);

                        MutedAction action=MutedAction(action: "AsyncContacts",process: "",lable: "",expiredTime: DateTime.now().add(Duration(minutes: 3)));

                        SignalChatFactory().sendActionMessage(contact?.id??"", "",action,null);//要求对端同步CONTACTS

                        ContactFactory.to.loadContactsFromServer(forcedReload: true);

                        DialogueFactory.to.update();

                      }catch(e){

                      }finally{
                        SmartDialog.dismiss();
                      }




                    }, child: Text(t.contact.newContact)),
                    TextButton(onPressed: ()async{


                      //拒绝加入，只需删除临时通讯录记录即可。

                      try{
                        SmartDialog.showLoading();
                        await ContactFactory.to.removeOneFromServer("${contact?.id}");

                        await DialogueFactory.to.removeOneByReceiverId("${contact?.id}");


                        //修改对端的记录，增加备注
                        await ContactService().modifyOneContactRemark("${contact?.id}", UserFactory().user.id??"", "Refused");

                        MutedAction action=MutedAction(action: "AsyncContacts",process: "",lable: "",expiredTime: DateTime.now().add(Duration(minutes: 3)));

                        SignalChatFactory().sendActionMessage(contact?.id??"", "",action,null);//要求对端同步CONTACTS


                        MessageFactory.to.update();
                      }catch(e){

                      }finally{
                        SmartDialog.dismiss();
                      }




                    }, child: Text(t.contact.block))
                  ],
                )
            ],
          ),
        )
    );
  }
}