import 'package:app_ios/factory/contact_factory.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:badges/badges.dart' as badges;
import '../../contract/pre_define.dart';
import '../../factory/chat_factory.dart';
import '../../factory/time_zone_factory.dart';
import '../../gen/strings.g.dart' as tra;
import '../../models/muted_action_model.dart';
import '../../services/contact_service.dart';
import '../../services/users_service.dart';
import '../contacts/add_contact_widget.dart';
import '../contacts/contacts_main_widget.dart';
import '../contacts/scan_qr_code_widget.dart';
import '../dialogue/dialogue_list_widget.dart';
import '../location/location_main_widget.dart';
import '../setting/account_main_widget.dart';
import '../setting/setting_main_widget.dart';

class LobbyContentWidget extends StatefulWidget {
  const LobbyContentWidget({Key? key}) : super(key: key);

  @override
  State<LobbyContentWidget> createState() => _LobbyContentWidgetState();
}

class _LobbyContentWidgetState extends State<LobbyContentWidget> {

  late int _selectedIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex=0;
  }

  String lobbyTitle(int selectedIndex,BuildContext context){
    final t = tra.Translations.of(context);
    switch(selectedIndex) {
      case 0: {
        return t.message.message;
      }


      case 1: {
        return t.message.contact;
      }

      case 2: {
        return t.message.surrounding;
      }

      case 3: {
        return "${t.message.myself} (${TimeZoneFactory.to.timeZoneName},GMT+${TimeZoneFactory.to.gmtOffset})";//
      }
      default: {
        return "";
      }

    }


  }

  Widget? selectFloatingButton(int selectedIndex){
    switch(selectedIndex) {
      case 0: {
        return null;
      }


      case 1: {
        return FloatingActionButton(
          child: Icon(Icons.add,color: Theme.of(context).colorScheme.onSecondary,),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          onPressed: () {

            Navigator.of(context).push(MaterialPageRoute(builder: ((context)=>const AddContactWidget()),fullscreenDialog: false));

          },);
      }

      case 2: {
        return null;
      }

      case 3: {
        return null;
      }
      default: {
        return null;
      }

    }
  }

  Widget functionWidget(int selectedIndex){
    switch(selectedIndex) {
      case 0:
        {
          return  const DialogueMainWidget(); //;
        }


      case 1:
        {
          return const ContactsMainWidget(); // const ContactListWidget();
        }

      case 2:
        {
          return  LocationMainWidget(); // const LocationMainWidget();
        }

      case 3:
        {
          return AccountMainWidget(); // const AccountMainWidget();
        }
      default:
        {
          return Container();
        }
    }

  }

  @override
  Widget build(BuildContext context) {
    final t =tra.Translations.of(context);
    return Scaffold(

      appBar: AppBar(

        title: Text(lobbyTitle(_selectedIndex, context),overflow: TextOverflow.ellipsis,),
        actions: [
          IconButton(onPressed: (){
            //Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const SearchMainWidget(),fullscreenDialog: true));
          }, icon: const Icon(Icons.search)),


          DropdownButtonHideUnderline(
            child: DropdownButton2(
              customButton: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              customItemsHeights: [
                ...List<double>.filled(MenuItems.firstItems.length, 48),
                8,
                ...List<double>.filled(MenuItems.secondItems.length, 48),
              ],
              items: [
                ...MenuItems.firstItems.map(
                      (item) =>
                      DropdownMenuItem<MenuItem>(
                        value: item,
                        child: MenuItems.buildItem(item,context),
                      ),
                ),
                const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
                ...MenuItems.secondItems.map(
                      (item) =>
                      DropdownMenuItem<MenuItem>(
                        value: item,
                        child: MenuItems.buildItem(item,context),
                      ),
                ),
              ],
              onChanged: (value) async{
                var d=value as MenuItem;
                String actionKey=d.text.split(".")[1];

                debugPrint(actionKey);
                if(actionKey=="addFriend"){

                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const AddContactWidget() ));//

                }
                if(actionKey=="setting"){

                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const SettingMainWidget()));//const SettingMainWidget()

                }
                if(actionKey=="scanQrcode"){
                  Barcode? scanData=await Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ScanQrCodeWidget() ));//const ScanQrCodeWidget()

                  if(scanData!=null){

                    if(scanData.format==BarcodeFormat.qrcode && (scanData.code?.startsWith("TimeCeptUserId-")??false)){

                      String _id=scanData.code?.split("-")[1]??"";



                      try{
                        SmartDialog.showLoading();
                        var _user=await UserSerive().getOneById(_id);

                        //通过扫码添加无需认证，直接成为好友开始对话
                        var contact=await ContactService().applyForNewContact(_user.countryCode??"",_user.tel??"",false);



                        ContactFactory.to.addOneToContactList(contact);

                        //通知对方，已经添加成功
                        MutedAction action=MutedAction(action: "AsyncContacts",process: "",lable: "",expiredTime: DateTime.now().add(Duration(minutes: 3)));

                        await SignalChatFactory().sendActionMessage(contact.id??"", "",action,null);//要求对端同步CONTACTS


                        SmartDialog.showToast(t.contact.done);


                      }catch(e){

                        SmartDialog.showToast(t[e.toString().trim()]);
                      }finally{
                        SmartDialog.dismiss();
                      }

                    }else{

                      if(scanData.code?.toLowerCase().startsWith("http")??false){
                        //Navigator.of(context).push(MaterialPageRoute(builder: (_)=>BrowserWidget(url:scanData.code??"" ,)));

                      }else{
                        //Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ScanQrCodeResultWidget(scanData: scanData,)));

                      }

                    }

                  }

                }
              },
              itemHeight: 48,
              itemPadding: const EdgeInsets.only(left: 16, right: 16),
              dropdownWidth: 160,
              dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.grey,
              ),
              dropdownElevation: 8,
              offset: const Offset(0, 8),

            ),),



          const VerticalDivider()
        ],

      ),
      body: functionWidget(_selectedIndex),
      floatingActionButton: selectFloatingButton(_selectedIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavyBar(

        selectedIndex: _selectedIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        backgroundColor: Colors.grey.shade100,
        onItemSelected: (index) => setState(() => _selectedIndex = index),

        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: const Icon(Icons.message),
            title: Text(
              t.message.message,
            ),
            activeColor: Theme.of(context).colorScheme.primary,

            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: GetBuilder<ContactFactory>(
              builder: (_)=> badges.Badge(
                showBadge: _.showBadge,
                position: badges.BadgePosition.topEnd(top: -4, end: -8),
                child: Icon(Icons.contact_phone),
              ),
            ),
            title:Text(t.message.contact),
            activeColor: Theme.of(context).colorScheme.primary,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.location_on),
            title: Text(t.message.surrounding),
            activeColor: Theme.of(context).colorScheme.primary,
            textAlign: TextAlign.center,
          ),

          BottomNavyBarItem(
            icon: const Icon(Icons.person),
            title: Text(t.message.myself),
            activeColor: Theme.of(context).colorScheme.primary,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}