import 'package:app_ios/factory/user_factory.dart';
import 'package:app_ios/models/user_model.dart';

import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:timezone_utc_offset/timezone_utc_offset.dart';

class TimeZoneFactory extends GetxController{
  static TimeZoneFactory get to => Get.find();

  TimeZoneFactory(User user){
    _user=user;
  }


  late User _user;

  var timeZoneName="".obs;



  var gmtOffset=0.obs;


  @override
  Future<void> onInit() async{
    // TODO: implement onInit
    super.onInit();
    timeZoneName.value=await FlutterTimezone.getLocalTimezone();


    var v=getTimezoneUTCOffset(timeZoneName.value);

    gmtOffset.value=v?.inHours??0;

    //比较获得的和服务器上面保存的是否一致，如果不一致就更新服务器，以实际获得为准
    if(_user.gmt!=gmtOffset || _user.timeZoneName!=timeZoneName){

      await UserFactory().updateTimeZone(timeZoneName.value, gmtOffset.value);

    }


    update();

  }


  String diffofTwoTimeZone(int gmt){

    int _diff=gmt-(gmtOffset.value);

    if(_diff==0){
      return "";
    }else{
      if(_diff>0){
        return "GMT+${gmt}, (${_diff}H ahead)";
      }else{
        return "GMT+${gmt}, (${-1*_diff}H behind)";
      }
    }


  }

  //获得另外一个时区的时间
  DateTime getTimeZoneDateTime(int gmt){
    int _diff=gmt-(gmtOffset.value);
    return DateTime.now().add(Duration(hours: _diff));
  }

  //将另外一个时间的时间转换到本时区
  DateTime getTimeZoneToLocalDateTime(DateTime? otherTimeZoneTime,int gmt){
    if(otherTimeZoneTime!=null){
      int _diff=(gmtOffset.value)-gmt;
      return otherTimeZoneTime.add(Duration(hours: _diff));
    }else{
      return DateTime.now();
    }
  }
}