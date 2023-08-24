import 'dart:convert';

import 'package:isar/isar.dart';
import 'package:app_ios/assistants/extend.dart';
import 'package:date_format/date_format.dart';

import 'location_model.dart';

part 'message_model.g.dart';

@collection
class MessageModel{

  String? id;

  Id get isarId => Helper.fastHash(id!);
  DateTime?postDateTime; //消息发送时间
  final String?receiver;//收件人ID
  final String?poster;//发件人 ，这个两个是按照实际情况记录了。用于区分是接收的还是发送的
  bool?isScheduled;//是否计划信息

  DateTime?scheduleDateTime; //预约时间，仅对预约消息有意义

  final String? messageType;//消息类型

  String?content;  //消息主内容
  final String?extended; //消息扩展内容
  final String?comments; //消息备注

  String?chatId;//消息所在的对话ID

  bool?reached;//收件人已经收到。
  DateTime?reachedDateTime;//消息送达时间

  String groupDate="";

  bool?isFirst;

  //需要显示的状态时间
  DateTime get displayDateTime{
    var _d=postDateTime??DateTime.now();

    if(!(reached??false)){
      if(isScheduled??false){
        _d=scheduleDateTime??DateTime.now();

      }else{

        _d=postDateTime??DateTime.now();

      }
    }

    return _d;

  }

  LocationThumbnail? get senderPosition{

    try{
      LocationThumbnail _location=LocationThumbnail.fromJson(jsonDecode(extended??"{}"));

      return _location;
    }catch (e){
      return null;
    }


  }


  MessageModel({this.id,this.postDateTime,this.poster,this.receiver,this.isScheduled,this.reached,this.scheduleDateTime,
  this.reachedDateTime,this.content,this.extended,this.comments,this.messageType,this.chatId});

  MessageModel.message({this.id,this.chatId,this.postDateTime,this.reachedDateTime,this.poster,this.receiver,this.content,this.extended,this.messageType,this.comments}):isScheduled=false,reached=false,scheduleDateTime=DateTime.now(){
    groupDate=formatDate(postDateTime??DateTime.now(), [yyyy, '-', mm, '-', dd]);

  }

  MessageModel.receiveMessage({this.id,this.chatId,this.postDateTime,this.reachedDateTime,this.poster,this.receiver,this.content,this.extended,this.comments,this.messageType}):isScheduled=false,reached=true,scheduleDateTime=DateTime.now(){
    groupDate=formatDate(reachedDateTime??DateTime.now(), [yyyy, '-', mm, '-', dd]);
  }

  MessageModel.fromJson(Map<String, dynamic> json):
        id=json.confirmAndRead("id"),
        receiver=json.confirmAndRead("receiver"),
        isScheduled=false,
        messageType=json.confirmAndRead("messageType"),
        content=json["messageContent"]["content"],
        extended=json["messageContent"]["extended"],
        comments=json["messageContent"]["comments"],
        chatId=json.confirmAndRead("chatId"),
        poster=json.confirmAndRead("poster"),
        postDateTime=json.containsKey("postDateTime")?DateTime.tryParse(json["postDateTime"]):DateTime.now(),
        scheduleDateTime=json.containsKey("scheduleDateTime")?DateTime.tryParse(json["scheduleDateTime"]):DateTime.now(){
    reached=true;

  }
}