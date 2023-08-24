//上传给服务器的消息信息


import 'package:app_ios/assistants/extend.dart';

class UploadMessage{
  final String?id;
  final String?poster;
  final String?receiver;
  final bool?isScheduled;
  final DateTime?scheduleDateTime;
  final String? messageType;
  final String? chatId;

  final String?content;
  final String?extended;
  final String?comments;

  UploadMessage.textMessage({this.id,this.poster,this.receiver,this.content,this.chatId,this.extended}):isScheduled=false,scheduleDateTime=DateTime.now(),messageType="Text",comments="";

  UploadMessage.locationMessage({this.id,this.poster,this.receiver,this.content,this.chatId,this.comments}):isScheduled=false,scheduleDateTime=DateTime.now(),messageType="Location",extended="";

  UploadMessage.urlMessage({this.id,this.poster,this.receiver,this.content,this.chatId,this.comments}):isScheduled=false,scheduleDateTime=DateTime.now(),messageType="Url",extended="";

  UploadMessage.actionMessage({this.id,this.poster,this.receiver,this.content,this.chatId,this.extended}):isScheduled=false,scheduleDateTime=DateTime.now(),messageType="Action",comments="";


  UploadMessage.scheduledMessage({this.id,this.poster,this.receiver,this.content,this.chatId,this.scheduleDateTime,this.extended}):isScheduled=true,messageType="Text",comments="";

  UploadMessage.fromJson(Map<String, dynamic> json):
        id=json.confirmAndRead("id"),
        receiver=json.confirmAndRead("receiver"),
        isScheduled=false,
        messageType=json.confirmAndRead("messageType"),
        content=json.confirmAndRead("content"),
        extended=json.confirmAndRead("extended"),
        comments=json.confirmAndRead("comments"),
        chatId=json.confirmAndRead("chatId"),
        poster=json.confirmAndRead("poster"),
        scheduleDateTime=json.containsKey("scheduleDateTime")?DateTime.tryParse(json["scheduleDateTime"]):DateTime.now();


  static Map<String, dynamic> toJson(UploadMessage instance)=>
      <String, dynamic>{
        'id': instance.id,
        'receiver': instance.receiver,
        'poster': instance.poster,
        'chatId': instance.chatId,
        'isScheduled': instance.isScheduled.toString(),
        'scheduleDateTime': instance.scheduleDateTime.toString(),

        'messageType': instance.messageType,
        'comments': instance.comments,
        'content': instance.content,
        'extended': instance.extended,

      };
}


class ResponseMessage{
  final String? sender;
  final String? id;
  final bool? done;
  final String? actionType;
  final String? comments;

  ResponseMessage({this.id,this.sender,this.done,this.actionType,this.comments});

  ResponseMessage.fromJson(Map<String, dynamic> json):
        id=json.confirmAndRead("Id"),
        sender=json.confirmAndRead("Sender"),
        actionType=json.confirmAndRead("ActionType"),
        comments=json.confirmAndRead("Comments"),
        done=json.containsKey("Done")?json["Done"]:false;
}