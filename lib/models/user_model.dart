
import 'package:app_ios/assistants/extend.dart';

import '../contract/enums.dart';
import 'contact_item_model.dart';

class User{
  final String? id; //UserId GUID标识
  final String? countryCode;//电话的国家代码
  final String? tel;
  final String? nickName;//名称

  final DateTime? createDateTime;

  String?timeZoneName;
  int? gmt;

  final UserStatus? userStatus;


  ContactThumbnail  toTempContact(){

    var _con=ContactThumbnail(id: id??"",createDateTime: DateTime.now(),desc:"$nickName",
        remark: "To be confirmed",contactTel: "$countryCode,$tel",isBlocked: false,isTemporary: true);



    return _con;

  }


  User({this.id,this.countryCode,this.tel,this.nickName,this.createDateTime,this.userStatus,this.timeZoneName,this.gmt});

  User.empty():id="",countryCode="",tel="",nickName="",createDateTime=DateTime.now(),userStatus=UserStatus.Offline,timeZoneName="",gmt=0;




  User.fromJson(Map<String, dynamic> json):
        id=json.confirmAndRead("id"),
        countryCode=json.confirmAndRead("countryCode"),
        tel=json.confirmAndRead("tel"),
        nickName=json.confirmAndRead("nickName"),
  //userStatus=UserStatus.idle,
        userStatus=UserStatus.values.firstWhere((e) => e.toString() == 'UserStatus.${json.containsKey("userStatus")?json["userStatus"]:'Offline'}'),
        timeZoneName=json.confirmAndRead("timeZoneName"),
        gmt=json.containsKey("gmt")?json["gmt"]:0,
        createDateTime=json.containsKey("createDateTime")?DateTime.tryParse(json["createDateTime"]):DateTime.now();
}

//登录以后返回的用户信息
class LoginUser{
  final String? token;
  final String? userId;
  final String? userName;
  final int?expiresIn;
  LoginUser({this.userId,this.userName,this.token,this.expiresIn});
  LoginUser.fromJson(Map<String, dynamic> json):
        token=json.confirmAndRead("token"),
        userId=json.confirmAndRead("userId"),
        userName=json.confirmAndRead("userName"),
        expiresIn=json.containsKey("expiresIn")?json["expiresIn"]:0;

}