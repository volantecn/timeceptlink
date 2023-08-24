

import 'package:app_ios/assistants/extend.dart';

class MutedAction{
 final String?action;
 final String?process;
 final DateTime?expiredTime;
 final String?lable;
 MutedAction({this.action,this.process,this.expiredTime,this.lable});

 MutedAction.fromJson(Map<String, dynamic> json):
       action=json.confirmAndRead("action"),
       process=json.confirmAndRead("process"),
       lable=json.confirmAndRead("lable"),
       expiredTime=json.containsKey("expiredTime")?DateTime.tryParse(json["expiredTime"]):DateTime.now();

 Map<String, dynamic> toJson() => <String, dynamic>{
   'action': action??"",
   'process': process??"",
   'expiredTime':(expiredTime??DateTime.now()).toString(),
   'lable':lable??""
 };
}