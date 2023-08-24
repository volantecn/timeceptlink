
import 'package:app_ios/models/dialogue_model.dart';
import 'package:app_ios/services/pop_dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/location/disabled_geo_tips_widget.dart';
import '../widgets/location/geo_location_permission_widget.dart';
class LocationFactory extends GetxController{
  static LocationFactory get to => Get.find();

  late final SharedPreferences _prefs ;

  bool allowToGetLocation=false;

  bool askAgain=true;

  @override
  Future<void> onInit() async{
    // TODO: implement onInit
    super.onInit();
    _prefs = await SharedPreferences.getInstance();

    allowToGetLocation=_prefs.getBool("allowToGetLocation")??false;

    askAgain=_prefs.getBool("askAgain")??true;
  }


  Future<void>setaskAgain(bool value)async{
    askAgain=value;
    await _prefs.setBool("askAgain", value);
  }


  Future<void> setAllowToGetLocation(bool allow)async{

    //需要开放地址

    allowToGetLocation=allow;



    await _prefs.setBool("allowToGetLocation", allow);
  }





  var currentPosition=Position(longitude: 0, latitude: 0, speed: 0,accuracy: 0,altitude: 0,heading: 0,speedAccuracy: 0,floor: 0, timestamp: null).obs;


  //如果有权限，直接获取最新的地址，否则返回记录的当前地址
  Future<Position?> getCurrentPosition()async{

    if(allowToGetLocation){
      var permission = await Geolocator.checkPermission();

      if(permission==LocationPermission.always || permission==LocationPermission.whileInUse){

        currentPosition.value= await Geolocator.getCurrentPosition();

        update();
      }


    }


    return currentPosition.value;

  }

  Future<Position?> _getCurrentPosition()async{


    var serviceEnabled = await Geolocator.isLocationServiceEnabled(); //检查设备是否支持

    if(serviceEnabled){

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {

          throw Exception("Location permission are denied.");
        }
      }

      if (permission == LocationPermission.deniedForever) {

        throw Exception('Location permissions are permanently denied, we cannot request permissions.');
      }

      currentPosition.value= await Geolocator.getCurrentPosition();


      update();

      return currentPosition.value;

    }else{

      throw Exception("No usable location(geo) devices found");
    }


  }


  //返回系统当前的位置
  Future<Position?> firstGetCurrentPosition()async{

    if(!allowToGetLocation){

      var re=await SmartDialog.show<bool?>(builder: (_)=>Container(color: Colors.white,child: GeoLocationPermissionWidget(),));

      if(re??false){

        //如果同意使用GEO

        var re=await _getCurrentPosition();

        if(re!=null){

          allowToGetLocation=true;



          await _prefs.setBool("allowToGetLocation", true);
        }

        return re;



      }else{

        SmartDialog.show(builder: (_)=>Container(color: Colors.white,child: DisabledGeoTipsWidget(),));
        return null;
      }

    }else{


      var re=await _getCurrentPosition();

      return re;
    }

  }



}