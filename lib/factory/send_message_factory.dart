import 'package:app_ios/models/message_model.dart';
import 'package:get/get.dart';


class SendMessageFactory extends GetxController{
  static SendMessageFactory get to => Get.find();

  var expend=false.obs;



  var message=MessageModel().obs;

  void updateMessage(MessageModel m){
    message.value=m;
    update();

  }

  void emptyMessage()=>message.value=MessageModel();
}