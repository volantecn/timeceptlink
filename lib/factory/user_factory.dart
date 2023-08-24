//当前用户的信息


import 'package:country_codes/country_codes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../assistants/communcation/communcate.dart';
import '../models/user_model.dart';

class UserFactory{
  static final UserFactory _singleton = UserFactory._internal();

  factory UserFactory() {
    return _singleton;
  }

  UserFactory._internal();


  String? _dialCode;
  String? get dialCode=>_dialCode;

  String? _tel;
  String? get tel=>_tel;


  String? _userId;
  String? get userId=>_userId;

  String? _pws;

  User? _user;

  User get user=>_user??User.empty();

  Future<void>init()async{

    await CountryCodes.init();

    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _userId= _userId??_prefs.get("userId")?.toString();

    _pws=_pws??_prefs.get("pws")?.toString();

    _tel=_tel??_prefs.get("tel")?.toString();

    _dialCode=_dialCode??_prefs.get("dialCode")?.toString();

    if(_dialCode?.isEmpty??true){
      final CountryDetails details = CountryCodes.detailsForLocale();
      _dialCode=details.dialCode??"+1";
    }
  }


  bool isLogIn()=>(_userId?.isNotEmpty??false)&&(_pws?.isNotEmpty??false)&&(_dialCode?.isNotEmpty??false);

  logOut()async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    await _prefs.setString("pws", "");


  }

  //基本注册
  Future<User>register(String nickName,String pws,String countryCode,String tel)async{

    var params=<String,String>{"nickName":nickName,"pws":pws,"countryCode":countryCode,"tel":tel};

    var re=await Communicate().withHost(actionUrl: "/api/user/register/byTel",params:params,allowAnonymous: true);



    return User.fromJson(re.content);
  }

  //基础登录
  //使用手机和密码
  Future<LoginUser>login(String countryCode,String tel,String pws)async{


    var params=<String,String>{"pws":pws,"countryCode":countryCode,"tel":tel};

    var re=await Communicate().withHost(actionUrl: "/api/user/tel/jwtToken",params:params,allowAnonymous: true);




    var userLogin= LoginUser.fromJson(re.content);

    SharedPreferences _prefs = await SharedPreferences.getInstance();

    await _prefs.setString("userId", "${userLogin.userId}");

    await _prefs.setString("pws", pws);

    await _prefs.setString("tel", tel);

    await _prefs.setString("dialCode", countryCode);

    _userId="${userLogin.userId}";
    _dialCode=countryCode;
    _pws=pws;

    return userLogin;
  }



  Future<User?>getCurrentUser({bool forcedReload=false})async{

    if(_user==null || forcedReload){
      var params=<String,String>{"id":_userId??""};

      var re=await Communicate().withHost(actionUrl: "/api/user/getOne/ById",params:params);


      _user= User.fromJson(re.content);
    }

    return _user;

  }

  Future<void>updateTimeZone(String timeZoneName,int gmt)async{
    var params=<String,String>{"userId":_userId??"","timeZoneName":timeZoneName,"gmt":"$gmt"};

    await Communicate().withHost(actionUrl: "/api/user/modify/timeZone",params:params);

    _user?.timeZoneName=timeZoneName;
    _user?.gmt=gmt;
  }

}