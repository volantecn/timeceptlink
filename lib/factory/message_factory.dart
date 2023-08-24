import 'dart:convert';

import 'package:app_ios/factory/contact_factory.dart';
import 'package:app_ios/factory/user_factory.dart';
import 'package:app_ios/models/contact_item_model.dart';
import 'package:collection/collection.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

import '../assistants/communcation/communcate.dart';
import '../models/location_model.dart';
import '../models/message_model.dart';
import '../models/muted_action_model.dart';
import '../models/post_message_model.dart';
import 'dialogue_factory.dart';


class MessageFactory extends GetxController{
  static MessageFactory get to => Get.find();

  late Isar messageHandle;


  var messages=<MessageModel>[].obs; //全部的对话，未分组


  double? position;

  var pages=<String,int>{};

  String currentChatId="";


  Future<void> init() async{
    // TODO: implement onInit
    super.onInit();


    final dir = await getApplicationDocumentsDirectory();

    messageHandle = await Isar.open(

      [MessageModelSchema],
      name: 'messages',
      directory: dir.path,
    );



    //await loadUnReachedMessagesFromServer();
  }




  //从服务器获得最近一个月未送达给我的短信，
  //比较以后加入本地存储
  //此功能主要是用于APP每次恢复和载入以后与数据库同步
  Future<void> loadUnReachedMessagesFromServer(List<ContactThumbnail> contacts)async{

    var params=<String,String>{"receiverId":UserFactory().userId??""};


    var re=await Communicate().withHost(actionUrl: "/api/message/listRecentlyOneMonth/byChatId",params:params);


    var unReachedMessages=(re.content as List).map((d)=>MessageModel.fromJson(d)).toList();

    var contactsIds=contacts.map((one) => one.id).toList();

    unReachedMessages=unReachedMessages.where((one) => contactsIds.contains(one.poster)).toList();

    //查询对话，并把这些消息加入到合适的对话中
    for(var message in unReachedMessages){

      //这里需要一个对比，把已经保存的就无需二次保存了。



      var chat=await DialogueFactory.to.getOneOrNewDialogue(message.poster??"");

      message.groupDate=formatDate(message.postDateTime??DateTime.now(), [yyyy, '-', mm, '-', dd]) ;
      message.chatId="${chat?.id}";

    }

    await messageHandle.writeTxn(() async {
      //将获得数据保存到本地
       await messageHandle.messageModels.putAll(unReachedMessages);
    });
    //保存到本地，




  }



  //消息队列有2种进入方法，一种是从本地分页载入，一个是有消息加入到最后
  //载入一个消息的最后一页，当进入一个对话后，调用此功能
  Future<void>loadOneChatLast30Messages(String chatId)async{



    var _list=await messageHandle.messageModels.filter().chatIdEqualTo(chatId)
        .sortByPostDateTimeDesc().limit(30).findAllSync();  //载入的倒叙的符合这个对话的信息
                                                         //载入后面页面的时候，就需要那个MESSAGE的ID来确定


    messages.value=[..._list.reversed];

    position=null;
    update();
  }


  //在一个对话中，消息列表滚动到上面时候再载入新的一个页面
  //就是这个lastMessageId之前的全部30个消息
  Future<void>loadOneChatNextPage30Messages(String chatId,DateTime postDateTime)async{


    var _list=await messageHandle.messageModels.filter().chatIdEqualTo(chatId)
        .and().postDateTimeLessThan(postDateTime).sortByPostDateTimeDesc().limit(30).findAllSync();


    messages.value=[..._list.reversed,...messages.value,];


    update();
  }



  //将一个uploadMessage保存在本地。
  //此时消息的状态是已发送，未收到回执。还在等待回执。
  void sendOneTextMessage(UploadMessage message)async{



    var chatId=DialogueFactory.to.getOneByReceiverId(message.receiver??"")?.id??0;

    //debugPrint("**************************************************************************");
    //debugPrint("${chatId}");
    //debugPrint("**************************************************************************");


    var mes=MessageModel.message(id:message.id,chatId: "${chatId}",postDateTime: DateTime.now(),
      receiver: message.receiver,content: message.content,extended: message.extended,messageType: message.messageType,comments: message.comments,
    );


    mes.isScheduled=message.isScheduled; //补充处理了Message
    mes.scheduleDateTime=message.scheduleDateTime;

    messages.value=[...messages,mes];


    await messageHandle.writeTxn(() async {
      await messageHandle.messageModels.put(mes);
    });


    //messageController.add(mes);

    //对话的更新是在这里发生的
    //对话的更新在这里发生的。
    DialogueFactory.to.newMessageUpdateDialogue(message.chatId??"",false); //发送的消息肯定是当前打开的对话中的，接受的消息就未必是了。需要判断

    position=null;


    update();
    //对话更新
  }


  //接收到一个消息，并保存到本地队列中
  void receiveOneMessage(UploadMessage message,String chatId)async{
    var mes=MessageModel.receiveMessage(id: message.id,chatId: chatId,postDateTime: DateTime.now(),
        reachedDateTime: DateTime.now(),poster: message.poster,receiver: message.receiver,
        content: message.content,extended: message.extended,comments: message.comments,
        messageType: message.messageType);

    //_buffers.putIfAbsent(chatId, () => [...?_buffers[chatId],mes]);


    messages.value=[...messages,mes];
    await messageHandle.writeTxn(() async {
      await messageHandle.messageModels.put(mes);
    });
    DialogueFactory.to.newMessageUpdateDialogue(chatId,true);

    try{
      LocationThumbnail _location=LocationThumbnail.fromJson(jsonDecode(message.extended??"{}"));
      //如果成功，说明对端携带了地址信息
      debugPrint("****************************************************************************************************");
      debugPrint("收到地址${_location.altitude}");
      debugPrint("****************************************************************************************************");

      DialogueFactory.to.updateSendLocation(chatId,_location);
    }catch(e){
      DialogueFactory.to.updateSendLocation(chatId,null);
      //没有有成功，则清除地址
    }
    //messageController.add(mes);

    position=null;
    update();

  }

  //接收到一个行为消息，执行，不保存
  Future<void>receiveOneActionMessage(UploadMessage message,String chatId)async{

    var mes=MessageModel.receiveMessage(id: message.id,chatId: chatId,postDateTime: DateTime.now(),
        reachedDateTime: DateTime.now(),poster: message.poster,receiver: message.receiver,
        content: message.content,extended: message.extended,comments: message.comments,
        messageType: message.messageType);
    await _execAction(mes);
  }


  //将一个发送消息设置为已经接受了
  //在收到回执以后调用此功能
  void setOneSendMessageReached(String messageId)async{
    var found=messages.firstWhereOrNull((element) => element.id==messageId);

    if(found!=null){
      found.reached=true;
      found.reachedDateTime=DateTime.now();
      //messageController.add(found);

      await messageHandle.writeTxn(
          ()async{
            await messageHandle.messageModels.put(found);
          }
      );

      messages.value=[...messages];
      update();
    }
  }


  //转发一个信息
  addReSendMessage(MessageModel message,String newReceiverId,String chatId)async{


    MessageModel mes=MessageModel.message(id:const Uuid().v1(),
        postDateTime:DateTime.now(),poster: "",receiver: newReceiverId,
        reachedDateTime: message.reachedDateTime,
        content: message.content,extended: message.extended,comments: message.comments,messageType: message.messageType,
        chatId: chatId);


    messages.value=[...messages,mes];

    await messageHandle.writeTxn(() async {
      await messageHandle.messageModels.put(mes);
    });

    DialogueFactory.to.newMessageUpdateDialogue(chatId,true);



    update();

  }


  //删除一个消息
  //同时从本地和服务器删除
  Future<void> delOneMessageLocalAndServer(MessageModel? message)async{

    if(message!=null){
      var params=<String,String>{"id":message.id??""};


      await Communicate().withHost(actionUrl: "/api/message/del/one",params:params);



      var lastMessage=await lastMessageOfOneChat(message.chatId??"");


      await messageHandle.writeTxn(
              ()async{
            await messageHandle.messageModels.delete(message.isarId);
          }
      );

      if(lastMessage!=null)await DialogueFactory.to.updateLastDate(lastMessage);

      messages.value=[...messages.where((one) => one.id!=message.id)];

      update();
    }

  }

  //删除掉本地的全部信息
  Future<void> delAllLocalMessage()async{
    await messageHandle.writeTxn(() async {
      final count = await messageHandle.messageModels.filter()
          .chatIdIsNotEmpty()
          .deleteAll();
      print('We deleted $count Messages');
    });
  }


  Future<void>updateOneTextMessage(UploadMessage? m)async{

    var found=messages.firstWhereOrNull((one) => one.id==m?.id);

    if(found!=null){

      found.content=m?.content??"";
      found.scheduleDateTime=m?.scheduleDateTime??DateTime.now();
      await messageHandle.writeTxn(() async {
        await messageHandle.messageModels.put(found);
      });

      messages.value=[...messages];
      update();
    }

  }


  //根据收到的消息,执行后台操作指令
  _execAction(MessageModel message)async{



    MutedAction action=MutedAction.fromJson(jsonDecode(message.content??"{}"));


    debugPrint("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
    debugPrint("${action.action}");


    if((action.expiredTime?.compareTo(DateTime.now())??-1)>0){
      if(action.action=="ShareLocation"){



        //对方分享他的地址
        if(action.process=="true"){

          try{
            LocationThumbnail location=LocationThumbnail.fromJson(jsonDecode(message.extended??"{}"));

            DialogueFactory.to.updateSendLocation(message.chatId??"", location);
          }catch (e){

          }

          //停止分享他的地址
        }else{
          DialogueFactory.to.updateSendLocation(message.chatId??"", null);

        }
      }

      if(action.action=="DelMessage"){
        //String chatId=action.lable??"";
        String messageId=action.process??"";

        var message=messages.firstWhereOrNull((one) => one.id==messageId);

        if(message!=null){
          await messageHandle.writeTxn(
                  ()async{
                await messageHandle.messageModels.delete(message.isarId);
              }
          );

          messages.value=[...messages.where((one) => one.id!=message.id)];

          update();

        }


      }

      if(action.action=="AsyncContacts"){
        ContactFactory.to.loadContactsFromServer(forcedReload: true);
      }
    }
  }

  //返回一个对话的最后一个消息
  Future<String?> lastMessageContentOfOneChat(String chatId)async{

    var _list=messages.where((one) => one.chatId==chatId).toList();

    if(_list.length==0){
      //队列中没有找到，就去本地存储中找
      var founds=await messageHandle.messageModels.filter().chatIdEqualTo("$chatId")
          .sortByPostDateTimeDesc().limit(1).findAllSync();

      if(founds.length==1){
        return founds[0].content;
      }else{
        return null;
      }

    }else{
      return _list[_list.length-1].content;
    }

  }

  Future<MessageModel?> lastMessageOfOneChat(String chatId)async{

    var _list=messages.where((one) => one.chatId==chatId).toList();

    if(_list.length==0){
      //队列中没有找到，就去本地存储中找
      var founds=await messageHandle.messageModels.filter().chatIdEqualTo("$chatId")
          .sortByPostDateTimeDesc().limit(1).findAllSync();

      if(founds.length==1){
        return founds[0];
      }else{
        return null;
      }

    }else{
      return _list[_list.length-1];
    }

  }
}