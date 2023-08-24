

import 'package:app_ios/assistants/extend.dart';

class ScheduledItem{
  final String? id;
  final String? comments;
  final String? fromTime;
  final String? toTime;
  final String? weekDays;
  final String? memberId;

  ScheduledItem({this.id,this.comments,this.fromTime,this.toTime,this.weekDays,this.memberId});

  ScheduledItem.fromJson(Map<String, dynamic> json):
        id=json.confirmAndRead("id"),
        comments=json.confirmAndRead("comments"),
        fromTime=json.confirmAndRead("fromTime"),
        toTime=json.confirmAndRead("toTime"),
        weekDays=json.confirmAndRead("weekDays"),
        memberId=json.confirmAndRead("memberId");
}