import 'package:get/get.dart';
class NetWorkStatusFactory extends GetxController{

  static NetWorkStatusFactory get to => Get.find();

  var connected=false.obs;

  var prompt="Network connection, please wait".obs;

}