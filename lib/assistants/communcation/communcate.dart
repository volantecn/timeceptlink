import 'dart:collection';
import 'dart:convert';

import 'package:app_ios/assistants/extend.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../contract/pre_define.dart';
import 'communcate_model.dart';

class Communicate{
  static final Communicate _singleton = Communicate._internal();

  factory Communicate() {

    return _singleton;
  }

  Communicate._internal();


  JwtToken? _token;

  //获得当前正在使用的token
  Future<String>getToken()async{
    if(_token==null || (_token?.expiresIn??0)<DateTime.now().millisecondsSinceEpoch-200000){
      _token=await _getJwtToken(); //如果token不存在，或者过期了，就重新获取一次
    }


    return _token?.token??"";
  }

  Future<GeneralReturn> _communicating({String? actionUrl,  Map<String,String>?params,bool allowAnonymous=false})async{

    String ta="";
    BaseOptions options = BaseOptions(
      baseUrl: ConstantSetting.apiHostAddress,
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
      validateStatus: (int? status)=>(status??0)==200,
    );


    if(!allowAnonymous){
      if(_token==null || (_token?.expiresIn??0)<DateTime.now().millisecondsSinceEpoch-200000){
        _token=await _getJwtToken(); //如果token不存在，或者过期了，就重新获取一次
      }


      ta=_token?.token??"";

      //print(ta);
      options.headers['Authorization']="Bearer $ta";
    }



    final dio=Dio(options);


    try{

      var _t=jsonEncode(PostData(merchantId: "000000",staffId: "EF000000",actionParam: SplayTreeMap.from(params??<String,String>{})));



      var r=await dio.post("$actionUrl", data: _t);

      //print("${r.data}");

      return GeneralReturn.fromJson(Map<String, dynamic>.from(r.data));

    }
    on DioError catch (e){


      var message="";

      if(e.type==DioErrorType.badResponse){
        var error=CustomException.fromJson(Map<String, dynamic>.from(json.decode(e.response?.toString()??'{"message":""}')));
        message=error.message??"";
      }
      if(e.type==DioErrorType.sendTimeout || e.type==DioErrorType.connectionTimeout || e.type==DioErrorType.receiveTimeout){
        message="Time out:${e.type.toString().split('.').last}";
      }
      if(e.type==DioErrorType.unknown || e.type==DioErrorType.cancel){
        message="Error:${e.response??""}";
      }

      throw "$message";
    }
    catch(e){

      throw Exception(e);

    }

  }



  //连接使用了jwt的安全模式，需要额外获取jwt信息
  //缺省情况下，使用标准的ID= ，PWS作为前端连接的标准



  Future<GeneralReturn> withHost({String? actionUrl, Map<String,String>?params,bool allowAnonymous=false})async{

    return await _communicating(
        actionUrl: actionUrl,params: params,allowAnonymous: allowAnonymous);
  }




  //获取token
  //这个操作用于在正常工作过程中，不适应登录
  Future<JwtToken> _getJwtToken()async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String _pws=_prefs.get("pws")?.toString()??"";
    String _id=_prefs.get("userId")?.toString()??"";

    //print("登录账户 $_id");
    //print("密码 $_pws");

    var re= await _communicating(
        actionUrl: "/api/user/id/jwtToken",params: <String,String>{"id":_id,"pws":_pws},
        allowAnonymous: true
    );



    var token=JwtToken.fromJson(re.content);

    return token;
  }


}


class CustomException {

  final String? message;
  final String? apiName;
  CustomException({  this.message,  this.apiName});

  CustomException.fromJson(Map<String, dynamic> json):
        message=json.confirmAndRead("message"),
        apiName=json.confirmAndRead("apiName");
}