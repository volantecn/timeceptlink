//系统内所有的沟通都是基于对话

//一组对话
import 'package:app_ios/factory/contact_factory.dart';
import 'package:app_ios/factory/dialogue_factory.dart';
import 'package:app_ios/factory/message_factory.dart';
import 'package:app_ios/models/contact_item_model.dart';
import 'package:app_ios/services/users_service.dart';
import 'package:isar/isar.dart';

import 'package:flutter/cupertino.dart';

import 'location_model.dart';

part 'dialogue_model.g.dart';


@collection
class Dialogue{

  Id id = Isar.autoIncrement;


  final DateTime? createDateTime;//通话建立的时间,

  final String? receiverId;

  DateTime? lastDateTime;//最后一次通话的时间，用于排序

  bool? newMessage;//存在信息信息，意味着

  bool? shareLocation;//Sender分享地址。

  LocationThumbnail?sendLocation;//Sender分享的地址


  Dialogue({this.receiverId,this.lastDateTime,this.newMessage,this.shareLocation,this.sendLocation}):createDateTime=DateTime.now();


  ContactThumbnail? sender() =>ContactFactory.to.getOneById(receiverId??"") ;

  Future<String?> lastMessage()async{

     var re=await MessageFactory.to.lastMessageOfOneChat("$id");

     if(re?.messageType=="Action"){
       return  "";
     }else{
       if (re?.messageType=="Url" ){
         return "Sharing something interesting";
       }else{
         if (re?.messageType=="Location" ){
           return "Showing you map";
         }else{
           return re?.content;
         }
       }

     }

  }

  Future<DateTime?>lastMessageTime()async{
    var re=await MessageFactory.to.lastMessageOfOneChat("$id");

    return re?.displayDateTime;

  }
}