

import 'package:app_ios/factory/contact_factory.dart';
import 'package:app_ios/models/muted_action_model.dart';
import 'package:flutter/material.dart';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:regexpattern/regexpattern.dart';

import '../../factory/chat_factory.dart';
import '../../gen/strings.g.dart';
import '../../models/user_model.dart';
import '../../services/contact_service.dart';
import '../../services/users_service.dart';

class AddContactWidget extends StatefulWidget {
  const AddContactWidget({Key? key}) : super(key: key);

  @override
  State<AddContactWidget> createState() => _AddContactWidgetState();
}

class _AddContactWidgetState extends State<AddContactWidget> {

  final TextEditingController controller = TextEditingController();

  late PhoneNumber _number;



  User? _user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    _number=PhoneNumber(isoCode: "HK");
  }


  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.contact.newContact),),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [



              InternationalPhoneNumberInput(
                formatInput: false,

                ignoreBlank: true,
                onFieldSubmitted: (number)async{



                  if(number.trim().length>=8&&number.trim().isNumeric()){

                    try{
                      SmartDialog.showLoading();
                      _user=await UserSerive().getOneByTel(_number.dialCode??"",number.trim());

                      setState(() {

                      });
                    }catch(e){
                      SmartDialog.showToast(t[e.toString().trim()]);
                    }finally{
                      SmartDialog.dismiss();
                    }


                  }
                },
                hintText: t.contact.inputNumber,
                selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                ),
                initialValue: _number,

                onInputChanged: (PhoneNumber value) {
                  _number=value;
                },
              ),

              const Divider(),

              _user!=null?Card(
                color: Colors.grey.shade100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    ListTile(

                      subtitle: Text("${_user?.countryCode}${_user?.tel}"),
                      title: Text("${_user?.nickName}"),
                      trailing: Text("${_user?.timeZoneName}\nGMT+${_user?.gmt}"),
                    ),

                    Padding(padding: const EdgeInsets.only(left: 10,top: 20),

                      child: TextButton.icon(

                        icon: const Icon(Icons.person_add),
                        label: Text(t.contact.add),
                        onPressed: ()async{

                          try{
                            SmartDialog.showLoading();
                            //通过手机号码添加的必然是临时联系人
                            var contact=await ContactService().applyForNewContact(_user?.countryCode??"",_user?.tel??"",true);


                            ContactFactory.to.addOneToContactList(contact);
                            SmartDialog.showToast(t.contact.done);

                            //给对端发送一个通知，万一对端没有收到通知，那么下次唤起的时候也会同步到
                            MutedAction action=MutedAction(action: "AsyncContacts",process: "",lable: "",expiredTime: DateTime.now().add(Duration(minutes: 3)));

                            SignalChatFactory().sendActionMessage(contact.id??"", "",action,null);//要求对端同步CONTACTS


                            Navigator.of(context).pop();
                          }catch(e){

                            SmartDialog.showToast(t[e.toString().trim()]);
                          }finally{
                            SmartDialog.dismiss();
                          }



                        },
                      ),
                    ),

                    /*
                    * Padding(padding: const EdgeInsets.only(left: 12,top: 20),

                      child: TextButton.icon(

                        icon: const Icon(Icons.block),
                        label: Text(t.contact.block),
                        onPressed: (){

                        },
                      ),
                    )
                    * */
                  ],
                ),
              ):const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
