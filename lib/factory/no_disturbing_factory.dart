
import 'package:app_ios/factory/user_factory.dart';
import 'package:app_ios/models/distribute_scheduled_item_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../assistants/communcation/communcate.dart';

class NoDisturbingFactory extends GetxController{
  static NoDisturbingFactory get to => Get.find();


  var items=<ScheduledItem>[].obs;


  @override
  Future<void> onInit() async{
    // TODO: implement onInit
    super.onInit();

    var params=<String,String>{"memberId":UserFactory().userId??""};
    var re=await Communicate().withHost(actionUrl: "/api/distribute/item/list",params:params);


    items.value=(re.content as List).map((d)=>ScheduledItem.fromJson(d)).toList();

    update();
  }



  Future<ScheduledItem> newOneScheduledItem()async{

    var params=<String,String>{"memberId":UserFactory().userId??"",};
    var re=await Communicate().withHost(actionUrl: "/api/distribute/item/put",params:params);

    var newOne= ScheduledItem.fromJson(re.content);

    items.value=[...items,newOne];
    update();
    return newOne;
  }

  bool enabledShowNotification(){
    bool re=true;
    NumberFormat formatter = new NumberFormat("00");

    int weekDay=DateTime.now().weekday;

    var current="${formatter.format(DateTime.now().hour)}${formatter.format(DateTime.now().minute)}";
    items.forEach((item) {

      if(item.weekDays?.contains("$weekDay")??false){

        if((item.fromTime?.compareTo(current)??1)<=0 &&(item.toTime?.compareTo(current)??-1)>=0){

          re=false;
        }

      }


    });
    return re;
  }

  Future<ScheduledItem> putOneScheduledTime(String id,String fromTime,String toTime)async{

    var params=<String,String>{"id":id, "fromTime":fromTime,"toTime":toTime
    };
    var re=await Communicate().withHost(actionUrl: "/api/distribute/item/put",params:params);

    var item= ScheduledItem.fromJson(re.content);

    var index=items.indexWhere((one) => one.id==id);
    if( index>=0){
      items[index]=item;

      items.value=[...items];
    }
    update();
    return item;
  }

  Future<ScheduledItem> putOneScheduledWeekDays(String id,String weekDays)async{

    var params=<String,String>{"id":id, "weekDays":weekDays
    };
    var re=await Communicate().withHost(actionUrl: "/api/distribute/item/put",params:params);

    var item= ScheduledItem.fromJson(re.content);

    var index=items.indexWhere((one) => one.id==id);
    if( index>=0){
      items[index]=item;
      items.value=[...items];
    }
    update();
    return item;
  }

  Future<bool> delOneScheduledItem(String id)async{
    var params=<String,String>{"id":id};
    await Communicate().withHost(actionUrl: "/api/distribute/item/del",params:params);

    items.value=[...items.where((one) => one.id!=id).toList()];

    update();
    return true;
  }


}