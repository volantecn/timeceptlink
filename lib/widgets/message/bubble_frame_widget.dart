



import 'dart:convert';

import 'package:app_ios/factory/block_factory.dart';
import 'package:app_ios/factory/contact_factory.dart';
import 'package:app_ios/factory/message_factory.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:bubble/bubble.dart';
import 'package:clipboard/clipboard.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../factory/chat_factory.dart';
import '../../factory/send_message_factory.dart';
import '../../factory/time_zone_factory.dart';
import '../../gen/strings.g.dart';
import '../../models/location_model.dart';
import '../../models/message_model.dart';
import '../../models/muted_action_model.dart';
import '../../models/url_model.dart';
import '../../services/pop_dialogs.dart';
import '../location/display_share_location_widget.dart';
import '../near_me/near_me_main_widget.dart';
import 'message_forward_main_widget.dart';

class PopMenuItem {
  String? title;
  IconData? icon;

  PopMenuItem(this.title, this.icon);
}

class BubbleFrameWidget extends StatefulWidget {
  final MessageModel? message;

  final bool isReceiver;

  final Widget? child;

  BubbleFrameWidget({Key? key,@required this.message,@required this.child,this.isReceiver=false}) : super(key: key);


  @override
  State<BubbleFrameWidget> createState() => _BubbleFrameWidgetState();
}

class _BubbleFrameWidgetState extends State<BubbleFrameWidget> {

  final CustomPopupMenuController controller=CustomPopupMenuController();


  List<PopMenuItem> menuItems = [];
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }


  Widget _buildLongPressMenu() {
    final t = Translations.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        width: 240,
        color:Color(0xFF4C4C4C),
        child: GridView.count(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing:15,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: menuItems
              .map((item) => InkWell(
            onTap: ()async{
              if(item.title=="Share"){
                controller.hideMenu();
                await FlutterShare.share(
                    title: 'Share from timeceptLink',
                    text: widget.message?.content??"",
                    //linkUrl: 'https://flutter.dev/',
                    chooserTitle: 'Share from timeceptLink'
                );

              }

              if(item.title=="Copy"){
                controller.hideMenu();
                await FlutterClipboard.copy(widget.message?.content??"");

                SmartDialog.showToast("Copied");


              }

              if(item.title=="Map"){
                controller.hideMenu();
                LocationThumbnail location=LocationThumbnail.fromJson( jsonDecode(widget.message?.content??"{}"));

                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>DisplayShareLocationWidget(location: location,),fullscreenDialog: false));
              }

              if(item.title=="Details"){
                controller.hideMenu();
                UrlMessageThumbnail me=UrlMessageThumbnail.fromJson(jsonDecode(widget.message?.content??"{}"));
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>NearMeMainWidget(message:me),fullscreenDialog: false));
              }
              if(item.title=="Delete"){
                controller.hideMenu();

                Duration diff = DateTime.now().difference(widget.message?.postDateTime??DateTime.now());

                //15分钟之内的，可以删除全部，之外的只能删除本地的

                String from=t.message.delFrom(from:ContactFactory.to.getOneById(widget.message?.poster??"")?.desc??"" );


                if(widget.isReceiver){
                  var select=await PopDialog.of(context).delConfirm(title:from);
                  debugPrint("$select");

                  if(select??false){

                    try{
                      SmartDialog.showLoading();
                      await MessageFactory.to.delOneMessageLocalAndServer(widget.message);
                    }catch(e){

                    }finally{
                      SmartDialog.dismiss();
                    }

                  }

                }else{

                  if(diff.inMinutes<16){
                    var select=await PopDialog.of(context).delSelection();

                    debugPrint(select);
                    try{
                      SmartDialog.showLoading();

                      if(select=="local"){

                        await MessageFactory.to.delOneMessageLocalAndServer(widget.message);

                      }
                      if(select=="all"){

                        await MessageFactory.to.delOneMessageLocalAndServer(widget.message);//首先从本地和服务器上删除，再发布指令，让对端删除

                        MutedAction action=MutedAction(action: "DelMessage",process: "${widget.message?.id}",lable: "${widget.message?.chatId}",expiredTime: DateTime.now().add(Duration(minutes: 3)));

                        SignalChatFactory().sendActionMessage(widget.message?.receiver??"", widget.message?.chatId??"",action,null);//删除无需位置信息

                      }
                    }catch(e){

                    }finally{
                      SmartDialog.dismiss();
                    }

                  }else{
                    var select=await PopDialog.of(context).delConfirm(title: t.message.confirmDel);
                    if(select??false){

                      try{
                        SmartDialog.showLoading();
                        await MessageFactory.to.delOneMessageLocalAndServer(widget.message);
                      }catch(e){

                      }finally{
                        SmartDialog.dismiss();
                      }

                    }
                  }
                }


              }

              if(item.title=="Forward"){
                controller.hideMenu();

                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>MessageForwardMainWidget(messgae:widget.message),fullscreenDialog: false));
              }


              if(item.title=="Edit"){
                controller.hideMenu();
                //编译一条未发送的消息
                SendMessageFactory.to.updateMessage(widget.message!);
              }

              if(item.title=="Position"){
                controller.hideMenu();
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>DisplayShareLocationWidget(location:widget.message?.senderPosition,),fullscreenDialog: false));

              }

              if(item.title=="Cancel"){
                controller.hideMenu();
                var select=await PopDialog.of(context).delConfirm(title: t.message.confirmDel);
                if(select??false){

                  await MessageFactory.to.delOneMessageLocalAndServer(widget.message);

                }

              }

              if(item.title=="Report"){
                controller.hideMenu();
                var select=await PopDialog.of(context).reportContent();

                if(select??false){

                  SmartDialog.showToast("Your report has been successfully submitted");
                }

              }


              if(item.title=="Block"){
                controller.hideMenu();
                var select=await PopDialog.of(context).blockConfirm();
                if(select??false){

                  await BlockFactory.to.blockContact(widget.message?.poster??"");

                  SmartDialog.showToast("Contact blocked");
                }

              }

            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  item.icon,
                  size: 20,
                  color: Colors.white,
                ),
                Container(
                  margin: EdgeInsets.only(top: 2),
                  child: Text(
                    item.title??"",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
          ))
              .toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    menuItems=[
      PopMenuItem('Copy', BootstrapIcons.clipboard2),
      PopMenuItem('Share', BootstrapIcons.share),
      PopMenuItem('Forward', BootstrapIcons.send),
    ];
    if(widget.message?.messageType=="Location"){
      menuItems.add(PopMenuItem('Map', BootstrapIcons.map));
    }
    if(widget.message?.messageType=="Url"){

      menuItems.add(PopMenuItem('Details', BootstrapIcons.eye));
    }

    //如果是还没有过期的
    if(widget.message?.isScheduled??false){

      int _gmt=int.tryParse(widget.message?.extended??"0")??0;



      //判断SchdeuledMessage是否可以发送
      var _editEnabled=(TimeZoneFactory.to.getTimeZoneToLocalDateTime(widget.message?.scheduleDateTime,_gmt).compareTo(DateTime.now().add(Duration(minutes: 2)))>0);



      if(_editEnabled){
        menuItems.add(PopMenuItem('Edit', BootstrapIcons.pencil_square));
        menuItems.add(PopMenuItem('Cancel', BootstrapIcons.x_lg));
      }else{
        menuItems.add(PopMenuItem('Delete', BootstrapIcons.trash3));
      }



    }else{
      menuItems.add(PopMenuItem('Delete', BootstrapIcons.trash3));
    }

    if(widget.isReceiver&& widget.message?.senderPosition!=null){
      menuItems.add(PopMenuItem('Position', BootstrapIcons.geo_fill));
    }

    if(widget.isReceiver){
      menuItems.add(PopMenuItem('Report', BootstrapIcons.send_slash));
      menuItems.add(PopMenuItem('Block', BootstrapIcons.cloud_minus));

    }


    //debugPrint("IS first ${(widget.message?.isFirst)}");


    return Bubble(
      margin: BubbleEdges.only(top: 10,left:((widget.message?.isFirst)??false)?0:10,
         right: ((widget.message?.isFirst)??false)?0:10),
      alignment:widget.isReceiver?Alignment.topLeft: Alignment.topRight,

      //nipWidth: 8,
      nipHeight: 24,
      nip:((widget.message?.isFirst)??false)? (!widget.isReceiver?BubbleNip.rightTop:BubbleNip.leftTop):null,
      color:widget.isReceiver?Colors.white:  Theme.of(context).colorScheme.secondary,
      child: CustomPopupMenu(
        controller: controller,
        menuBuilder: _buildLongPressMenu,
        barrierColor: Colors.transparent,
        pressType: PressType.longPress,

        child: widget.child??SizedBox.shrink(),
      ),
    );
  }
}



