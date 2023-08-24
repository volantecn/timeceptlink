//聊天信息接受和发送的核心


import 'dart:convert';
import 'package:app_ios/factory/block_factory.dart';
import 'package:app_ios/factory/user_factory.dart';
import 'package:geolocator/geolocator.dart';

import 'package:app_ios/factory/notification_factory.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:uuid/uuid.dart';

import '../assistants/communcation/communcate.dart';
import '../contract/enums.dart';
import '../contract/pre_define.dart';
import '../models/location_model.dart';
import '../models/muted_action_model.dart';
import '../models/post_message_model.dart';
import '../models/url_model.dart';
import 'contact_factory.dart';
import 'dialogue_factory.dart';
import 'message_factory.dart';
import 'network_status_factory.dart';
import 'no_disturbing_factory.dart';

class SignalChatFactory{
  static final SignalChatFactory _singleton = SignalChatFactory._internal();

  factory SignalChatFactory() {
    return _singleton;
  }

  SignalChatFactory._internal();

  HubConnection? hubConnection;

  Future<void>connectStart()async{


    final httpOptions =  HttpConnectionOptions(accessTokenFactory: ()async=>await Communicate().getToken(),
      requestTimeout: 30000, skipNegotiation: true, transport: HttpTransportType.WebSockets,
    );



    hubConnection =HubConnectionBuilder()
        .withUrl(ConstantSetting.hub, options: httpOptions)
        .withAutomaticReconnect(retryDelays: [2000, 5000, 10000, 20000])

        .build();


    hubConnection?.onclose(({error}){
      NetWorkStatusFactory.to.connected(false);
      NetWorkStatusFactory.to.prompt("Error,network is cloesed");
      Future.delayed(const Duration(seconds: 20),()async=>await hubConnection?.start());
    });

    hubConnection?.onreconnecting(({error}) {
      NetWorkStatusFactory.to.connected(false);
      NetWorkStatusFactory.to.prompt("Network connecting again");
    });



    hubConnection?.onreconnected(({connectionId}) {
      NetWorkStatusFactory.to.connected(true);
      NetWorkStatusFactory.to.prompt("Network connected successfully");

    });
    hubConnection?.on("receipt",_handleIncommingReceipt );


    hubConnection?.on("message",_handleIncomingMessage);


    await hubConnection?.start();

    NetWorkStatusFactory.to.connected(true);



  }



  //处理获得的收据
  void _handleIncommingReceipt(List<Object?>? messages) {


    try{

      if(messages?.isNotEmpty??false){

        String message=  "${messages![0]}";

        debugPrint("$messages");

        var c=json.decode(message);

        var re=ResponseMessage.fromJson(c);

        //发现达到收据
        if(re.actionType=="Arrived" &&(re.done??false)){

          MessageFactory.to.setOneSendMessageReached(re.id??"");
        }

        //发现联系人状态改变收据
        if(re.actionType=="Connected"&&(re.done??false)){

          ContactFactory.to.modifyContactStatus(re.sender??"",UserStatus.Idle);
        }
        if(re.actionType=="Disconnected"&&(re.done??false)){

          ContactFactory.to.modifyContactStatus(re.sender??"",UserStatus.Offline);
        }

        //receiptController.add(re);

        //此处需要完善
      }

    }on Exception catch(_){
    }


  }

  //处理获得的信息数据
  void _handleIncomingMessage(List<Object?>? messages)async{
    try{



      if(messages?.isNotEmpty??false){
        String message=  "${messages![0]}";



        debugPrint("收到的 消息 :${message}");
        var c=json.decode(message);

        var re=UploadMessage.fromJson(c);

        //加入了黑名单检测

        if(!BlockFactory.to.allowToReceive(re.poster??"")) throw Exception("Poster was blocked");

        var contactIds=ContactFactory.to.contacts.map((one) => one.id).toList();


        if(re.messageType!="Action"){

          if(contactIds.contains(re.poster) ){



            /**
             *
             * var foundContact=ContactFactory.to.contacts.firstWhereOrNull((one)=>one.id==re.poster);


                if(foundContact==null){
                //没有找到联系人

                await ContactFactory.to.addOneTempContact(re.poster??"");

                }
             *
             * **/


            //这里记录消息.....................

            //找到或者生成一个对话
            var chat=await DialogueFactory.to.getOneOrNewDialogue(re.poster??"");//检查是否存在与这个用户的对话，如果没有就新建一个

            //j记录到接受信息中
            MessageFactory.to.receiveOneMessage(re, "${chat?.id??0}");


            _reponseReceipt(re.id??"",re.poster??"");

            var sender=ContactFactory.to.getOneById(re.poster??"");

            String displayContent="";

            if(re.messageType=="Text"){
              displayContent="${sender?.desc??""}:${re.content??""}";
            }
            if(re.messageType=="Location"){
              LocationThumbnail location=LocationThumbnail.fromJson( jsonDecode(re.content??"{}"));

              displayContent="${sender?.desc??""} @${location.address}";
            }
            //通知
            if(NoDisturbingFactory.to.enabledShowNotification() ){ //&&
              //NotificationController.createNewNotification(displayContent);

              NotificationFactory().showNotifications("New message", displayContent);

            }

          }

        }else{


          MessageFactory.to.receiveOneActionMessage(re, "");

        }





      }
    }on Exception catch(_){
    }
  }


  //发送回执
  void _reponseReceipt(String messageId,String receiver){
    hubConnection?.invoke("SendReceipt", args: <String>[messageId,receiver]);
  }

  sentSuccessfullyReceipt(String messageId,String receiver)=>_reponseReceipt(messageId, receiver);



  //发送一个普通的文本消息
  Future <UploadMessage?>sendTextMessage(String receiverId,String chatId,String content,Position? location)async{

    String loJson="";
    if(location!=null){
      LocationThumbnail lo=LocationThumbnail(longitude: location.longitude,latitude:location.latitude,
          accuracy: location.accuracy,altitude: location.altitude,speed:location.speed,address: "" );
      loJson=const JsonEncoder().convert(lo.toJson());
    }





    if(hubConnection?.state==HubConnectionState.Connected){

      return await _sendTextMessage(receiverId,chatId,content,loJson);

    }else{
      await hubConnection?.start();

      await Future.delayed(const Duration(seconds: 2),(){}); //两秒以后再试

      if(hubConnection?.state==HubConnectionState.Connected){
        return await _sendTextMessage(receiverId,chatId,content,loJson);
      }else{
        return null;
      }
    }

  }

  //发送一个行为信息

  Future <UploadMessage?>sendActionMessage(String receiverId,String chatId,MutedAction action,Position? location)async{

    String loJson="";
    if(location!=null){
      LocationThumbnail lo=LocationThumbnail(longitude: location.longitude,latitude:location.latitude,
          accuracy: location.accuracy,altitude: location.altitude,speed:location.speed,address: "" );
      loJson=const JsonEncoder().convert(lo.toJson());
    }


    if(hubConnection?.state==HubConnectionState.Connected){

      return await _sendActionMessage(receiverId,chatId,action,loJson);

    }else{
      await hubConnection?.start();

      await Future.delayed(const Duration(seconds: 2),(){}); //两秒以后再试

      if(hubConnection?.state==HubConnectionState.Connected){
        return await _sendActionMessage(receiverId,chatId,action,loJson);
      }else{
        return null;
      }
    }

  }


  //发送一个普通的位置消息
  Future <UploadMessage?>sendLocationMessage(String receiverId,String chatId,LocationThumbnail location)async{


    if(hubConnection?.state==HubConnectionState.Connected){

      return await _sendLocationMessage(receiverId,chatId,location);

    }else{
      await hubConnection?.start();

      await Future.delayed(const Duration(seconds: 2),(){}); //两秒以后再试

      if(hubConnection?.state==HubConnectionState.Connected){
        return await _sendLocationMessage(receiverId,chatId,location);
      }else{
        return null;
      }
    }

  }

  //发送一个普通的URL消息
  Future <UploadMessage?>sendUrlMessage(String receiverId,String chatId,UrlMessageThumbnail message)async{


    if(hubConnection?.state==HubConnectionState.Connected){

      return await _sendUrlMessage(receiverId,chatId,message);

    }else{
      await hubConnection?.start();

      await Future.delayed(const Duration(seconds: 2),(){}); //两秒以后再试

      if(hubConnection?.state==HubConnectionState.Connected){
        return await _sendUrlMessage(receiverId,chatId,message);
      }else{
        return null;
      }
    }

  }

  //发送一个预约文本消息
  Future <UploadMessage?>sendScheduledTextMessage(String receiverId,String chatId,String content,DateTime scheduledDateTime,String? messageId,int gmt)async{


    if(hubConnection?.state==HubConnectionState.Connected){

      return await _sendScheduledTextMessage(receiverId,chatId,content,scheduledDateTime,messageId,gmt);

    }else{
      await hubConnection?.start();

      await Future.delayed(const Duration(seconds: 2),(){}); //两秒以后再试

      if(hubConnection?.state==HubConnectionState.Connected){
        return await _sendScheduledTextMessage(receiverId,chatId,content,scheduledDateTime,messageId,gmt);
      }else{
        return null;
      }
    }

  }

  Future <UploadMessage> _sendTextMessage(String receiverId,String chatId,String content,String extended)async{
    var message=UploadMessage.textMessage(id:const Uuid().v1(),poster: UserFactory().userId,receiver: receiverId,
        content: content,chatId: chatId,extended: extended);

    MessageFactory.to.sendOneTextMessage(message);//将消息记录

    hubConnection?.invoke("SendMessage", args: <String>[const JsonEncoder().convert(UploadMessage.toJson(message))]);

    return message;
  }

  Future <UploadMessage> _sendLocationMessage(String receiverId,String chatId,LocationThumbnail lo)async{





    var message=UploadMessage.locationMessage(id:const Uuid().v1(),poster: UserFactory().userId,receiver: receiverId,
        content: const JsonEncoder().convert(lo.toJson()),chatId: chatId,comments: "");


    MessageFactory.to.sendOneTextMessage(message);//将消息记录

    hubConnection?.invoke("SendMessage", args: <String>[const JsonEncoder().convert(UploadMessage.toJson(message))]);

    return message;
  }

  Future <UploadMessage> _sendUrlMessage(String receiverId,String chatId,UrlMessageThumbnail url)async{


    var message=UploadMessage.urlMessage(id:const Uuid().v1(),poster: UserFactory().userId,receiver: receiverId,
        content: const JsonEncoder().convert(url.toJson()),chatId: chatId,comments: "");


    MessageFactory.to.sendOneTextMessage(message);//将消息记录
    //print("${UploadMessage.toJson(message)}");
    hubConnection?.invoke("SendMessage", args: <String>[const JsonEncoder().convert(UploadMessage.toJson(message))]);

    return message;
  }

  Future <UploadMessage> _sendActionMessage(String receiverId,String chatId,MutedAction action,String extended)async{


    var message=UploadMessage.actionMessage(id:const Uuid().v1(),poster: UserFactory().userId,receiver: receiverId,
        content: const JsonEncoder().convert(action.toJson()),chatId: chatId,extended: extended);

    //行为消息不做任何记录，仅仅是完成

    //print("${UploadMessage.toJson(message)}");

    hubConnection?.invoke("SendMessage", args: <String>[const JsonEncoder().convert(UploadMessage.toJson(message))]);

    return message;
  }

  Future<UploadMessage> _sendScheduledTextMessage(String receiverId,String chatId,String content,DateTime scheduleDateTime,String?messageId,int gmt)async{

    late UploadMessage message;

    if(messageId==null){
      message=UploadMessage.scheduledMessage(id:const Uuid().v1(),poster: UserFactory().userId,receiver: receiverId,
          content: content,chatId: chatId,scheduleDateTime: scheduleDateTime,extended: "$gmt");
      MessageFactory.to.sendOneTextMessage(message);//将消息记录
    }else{

      message=UploadMessage.scheduledMessage(id:messageId,poster: UserFactory().userId,receiver: receiverId,
          content: content,chatId: chatId,scheduleDateTime: scheduleDateTime,extended: "$gmt");



      MessageFactory.to.updateOneTextMessage(message);//更新消息
    }



    hubConnection?.invoke("SendMessage", args: <String>[const JsonEncoder().convert(UploadMessage.toJson(message))]);

    return message;
  }

}