
import 'package:app_ios/factory/contact_factory.dart';
import 'package:app_ios/models/message_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/dialogue_model.dart';
import '../models/location_model.dart';


class DialogueFactory extends GetxController{

  static DialogueFactory get to => Get.find();



  late Isar diaHandle;

  var dialogues=<Dialogue>[].obs;


  var currentDialogue=Dialogue().obs;



  Future<void> init()async {
    // TODO: implement onInit
    super.onInit();

    final dir = await getApplicationDocumentsDirectory();

    diaHandle = await Isar.open(
      [DialogueSchema],
      name: 'dialogues',
      directory: dir.path,
    );

    //获得本地保存的全部对话，
    //新建的对话也会立刻本地保存，所以这个队列是最新的
    //根据最后一次对话时间倒叙
    dialogues.value=await diaHandle.dialogues.filter().lastDateTimeIsNotNull().findAll(); //排序在显示时候处理



    update();
  }


  //根据接收者的ID，删除一个对话
  removeOneByReceiverId(String receiverId)async{

    var found=dialogues.firstWhereOrNull((one) => one.receiverId==receiverId);

    if(found!=null){


      dialogues.value=[...dialogues.where((one) => one.receiverId!=receiverId).toList()];


      await diaHandle.writeTxn(
              ()async{
                await diaHandle.dialogues.delete(found.id);
          }
      );



      update();
    }


  }

  Dialogue?getOneByReceiverId(String receiverId)=>dialogues.firstWhereOrNull((one) => one.receiverId==receiverId);

  //根据receiverID查询一个对话，如果没有找到就新建一个
  Future<Dialogue?> getOneOrNewDialogue(String receiverId)async{
    var found =dialogues.firstWhereOrNull((one) => one.receiverId==receiverId);

    //var contact=await ContactFactory.to.getOneById(receiverId);

    if(found!=null){

      found.lastDateTime=DateTime.now();

      await diaHandle.writeTxn(
              ()async{
            await diaHandle.dialogues.put(found);
          }
      );

      dialogues.value=[...dialogues]; //这里理论上可以取消

      update();

      return found;

    }else{

      var newDia=Dialogue(

          receiverId: receiverId,

          newMessage: true,

          lastDateTime: DateTime.now(),



          shareLocation: false
      );
      //同时给本地也保存一个副本

      await diaHandle.writeTxn(
              ()async{
                await diaHandle.dialogues.put(newDia);
          }
      );


      dialogues.value=[newDia,...dialogues];

      update();

      return newDia;


    }



  }


  //收到消息，更新对话目录
  newMessageUpdateDialogue(String id,bool isNewOne)async{

    var found =dialogues.firstWhereOrNull((one) => "${one.id}"==id);

    if(found!=null){

      found.lastDateTime=DateTime.now();

      found.newMessage=isNewOne;


      await diaHandle.writeTxn(
              ()async{
                await diaHandle.dialogues.put(found);
          }
      );



      dialogues.value=[...dialogues];

      update();
    }
  }

  //对话中间出现了共享地址，进行了更新，类似于消息更新，不同类型
  updateShareLocation(int id,bool newValue)async{

    currentDialogue.value.shareLocation=newValue;




    var found =dialogues.firstWhereOrNull((one) => one.id==id);



    if(found!=null){


      await diaHandle.writeTxn(
              ()async{
                found.shareLocation=newValue;
                await diaHandle.dialogues.put(found);
          }
      );

      dialogues.value=[...dialogues.value];

      update();

    }
  }

  updateLastDate(MessageModel lastMessage)async{


    var found =dialogues.firstWhereOrNull((one) => "${one.id}"==lastMessage.chatId);

    if(found!=null){

      await diaHandle.writeTxn(
              ()async{
            found.lastDateTime=lastMessage.reachedDateTime??DateTime.now();
            await diaHandle.dialogues.put(found);
          }
      );

      dialogues.value=[...dialogues];

      update();

    }
  }




  //进入一个对话的时候，调用此功能，将有新消息提示取消
  enterDialogueCancelNewMessage(int dialogueId)async{
    var found =dialogues.firstWhereOrNull((one) => one.id==dialogueId);
    if(found!=null){

      if(found.newMessage??false){
        await diaHandle.writeTxn(
                ()async{
              found.newMessage=false;
              await diaHandle.dialogues.put(found);
            }
        );

        dialogues.value=[...dialogues];

        update();
      }


    }
  }

  Future<void>delAllLocal()async{
    await diaHandle.writeTxn(() async {
      final count = await diaHandle.dialogues.filter()
          .createDateTimeIsNotNull()
          .deleteAll();
      print('We deleted $count Dialogues');
    });
  }


  //如果是空，则确定是共享
  updateSendLocation(String chatId,LocationThumbnail? location,)async{
    var found =dialogues.firstWhereOrNull((one) => "${one.id}"==chatId);

    if(found?.sendLocation?.altitude!=location?.altitude){

      if(found!=null){

        await diaHandle.writeTxn(
                ()async{
              found.sendLocation=location;
              await diaHandle.dialogues.put(found);
            }
        );

        dialogues.value=[...dialogues];

        update();

      }

    }


  }
}