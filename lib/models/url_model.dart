

import 'package:app_ios/assistants/extend.dart';

class UrlMessageThumbnail{
  final String? queryWord;
  final double? longitude;
  final double? latitude;

  UrlMessageThumbnail({this.queryWord,this.longitude,this.latitude});

  UrlMessageThumbnail.fromJson(Map<String, dynamic> json):
        longitude=json.containsKey("longitude")?(double.tryParse(json["longitude"])??0):0,
        latitude=json.containsKey("latitude")?(double.tryParse(json["latitude"])??0):0,

        queryWord=json.confirmAndRead("queryWord");

  Map<String, dynamic> toJson() => <String, dynamic>{
    'longitude': "$longitude",
    'latitude': "$latitude",

    'queryWord':"$queryWord"
  };
}