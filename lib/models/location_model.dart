

import 'package:isar/isar.dart';
import 'package:app_ios/assistants/extend.dart';
part 'location_model.g.dart';

@embedded
class LocationThumbnail{
  final double? longitude;
  final double? latitude;
  final double?  accuracy;
  final double? altitude;
  final double? speed;
  final String? address;

  LocationThumbnail({this.longitude,this.latitude,this.accuracy,this.altitude,this.speed,this.address});

  LocationThumbnail.fromJson(Map<String, dynamic> json):
        longitude=json.containsKey("longitude")?(double.tryParse(json["longitude"])??0):0,
        latitude=json.containsKey("latitude")?(double.tryParse(json["latitude"])??0):0,
        accuracy=json.containsKey("accuracy")?(double.tryParse(json["accuracy"])??0):0,
        altitude=json.containsKey("altitude")?(double.tryParse(json["altitude"])??0):0,
        speed=json.containsKey("speed")?(double.tryParse(json["speed"])??0):0,
        address=json.confirmAndRead("address");

  Map<String, dynamic> toJson() => <String, dynamic>{
    'longitude': "$longitude",
    'latitude': "$latitude",
    'accuracy': "$accuracy",
    'altitude': "$altitude",
    'speed': "$speed",
    'address':"$address"
  };
}