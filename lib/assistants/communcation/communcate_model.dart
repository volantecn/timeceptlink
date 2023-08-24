

import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:app_ios/assistants/extend.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';

enum ReturnDateType
{
  PaginationReturn,
  ListReturn,
  ObjectReturn,

}

class JwtToken{
  final int? expiresIn;
  final String? token;

  JwtToken({this.token,this.expiresIn});

  JwtToken.fromJson(Map<String, dynamic> json):
        token=json.confirmAndRead("token"),
        expiresIn=json.containsKey("expiresIn")?json["expiresIn"]:0;
}

class GeneralReturn{
  final ReturnDateType? returnDateType;

  // ignore: prefer_typing_uninitialized_variables
  final content;

  final String? comments;

  GeneralReturn({this.returnDateType,this.content,this.comments=""});

  GeneralReturn.fromJson(Map<String, dynamic> json):

        comments=json.containsKey("comments")?json["comments"]:"",
        returnDateType=ReturnDateType.values.firstWhere((e) => e.toString() == 'ReturnDateType.${json.containsKey("returnDateType")?json["returnDateType"]:'ObjectReturn'}'),
        content=json["content"];
}

class PaginationReturn<T>{
  final int? totalRecord;
  final int? page;
  final int? totalPage;
  final int? entries;
  final ReturnDateType? returnDateType;
  List<T> content;
  PaginationReturn({this.entries,this.totalPage,this.page,this.returnDateType,this.totalRecord}):content=<T>[];

  PaginationReturn.fromJson(Map<String, dynamic> json):
        totalRecord=json.containsKey("totalRecord")?json["totalRecord"]:1,
        page=json.containsKey("page")?json["page"]:1,
        totalPage=json.containsKey("totalPage")?json["totalPage"]:1,
        entries=json.containsKey("entries")?json["entries"]:1,
        returnDateType=ReturnDateType.values.firstWhere((e) => e.toString() == 'ReturnDateType.${json.containsKey("returnDateType")?json["returnDateType"]:'ObjectReturn'}'),
        content=<T>[];
}

class DoneResult<T>{
  bool done;
  T? content;
  String errPrompt;
  DoneResult({this.content,this.errPrompt='',this.done=true});

  DoneResult.error({this.errPrompt=""}):content=null,done=false;
}


class PostData
{

  final String appkey="Zc315TPXv2";
  final String from="PhonePos";

  final SplayTreeMap<String,String>? actionParam;



  final String timestamp;

  final String? merchantId;

  final String? staffId;

  final String random;

  String? token;


  PostData({@required this.merchantId,@required this.staffId,@required this.actionParam}):

        timestamp=DateTime.now().millisecondsSinceEpoch.toString(),
        random=Random().nextInt(99999).toString().padLeft(5,"0")
  {
    token=_createToken();
  }

  Map<String, dynamic> toJson()=>
      {
        "appkey":appkey,
        "from":from,
        "actionParam":actionParam,
        "merchantId":merchantId,
        "staffId":staffId,
        "random":random,
        "timestamp":timestamp,
        "token":token
      };

  String _createToken(){

    String plane = "";
    actionParam?.forEach((key, value) {
      if(value.isNotEmpty){
        plane+="${key.trim()}=${value.trim()}&";
      }

    });
    //print("拼接参数是：${plane} 结束");
    plane="$appkey&$merchantId&$staffId&$timestamp&$random&$plane&$appkey";

    //print("拼接字符串是：${plane} 结束");
    return md5.convert(utf8.encode(plane)).toString();
  }

}