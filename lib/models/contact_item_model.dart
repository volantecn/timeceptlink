
import 'package:app_ios/assistants/extend.dart';


import '../contract/enums.dart';
import 'package:isar/isar.dart';





//从服务器端获得的联系人摘要，需要二次加工以后存储在本地，
class ContactThumbnail{
  final String? id; //UserId GUID标识
  final DateTime? createDateTime;
  final String? remark;
  final String? desc;
  final String? contactTel;
  final bool? isBlocked;
  final String?timeZoneName;
  final int? gmt;

  final bool? isTemporary;
  String? groupId;

  final String?comments;


  UserStatus? userStatus;


  ContactThumbnail({this.id,this.createDateTime,this.desc,this.remark,this.contactTel,this.isBlocked,
  this.timeZoneName,this.gmt,this.userStatus,this.isTemporary,this.comments}):this.groupId="";

  ContactThumbnail.fromJson(Map<String, dynamic> json):
        id=json.confirmAndRead("id"),
        isBlocked=json.containsKey("isBlocked")?json["isBlocked"]:false,
        remark=json.confirmAndRead("remark"),
        desc=json.confirmAndRead("desc"),
        contactTel=json.confirmAndRead("contactTel"),
        comments=json.confirmAndRead("comments"),
        createDateTime=json.containsKey("createDateTime")?DateTime.tryParse(json["createDateTime"]):DateTime.now(),

        userStatus=UserStatus.values.firstWhere((e) => e.toString() == 'UserStatus.${json.containsKey("userStatus")?json["userStatus"]:'Offline'}'),
        timeZoneName=json.confirmAndRead("timeZoneName"),
        gmt=json.containsKey("gmt")?json["gmt"]:0,


        groupId="",
        isTemporary=json.containsKey("isTemp")?json["isTemp"]:false;

}