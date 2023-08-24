import 'package:app_ios/factory/user_factory.dart';

import 'package:get/get.dart';
import 'package:lpinyin/lpinyin.dart';

import '../assistants/communcation/communcate.dart';
import '../contract/enums.dart';
import '../models/contact_item_model.dart';

import '../services/users_service.dart';



class ContactFactory extends GetxController{
  static ContactFactory get to => Get.find();




  var contacts=<ContactThumbnail>[].obs;


  addOneToContactList(ContactThumbnail contact){
    var r=PinyinHelper.getPinyinE(contact.desc??"");
    if(r.isNotEmpty){
      contact.groupId=r.substring(0,1).toUpperCase();
    }else{
      contact.groupId=" ";
    }
    contacts.value=[contact,...contacts];
    update();
  }

  //ContactThumbnail? getOne(String id)=>contacts.firstWhereOrNull((one) => one.id==id);


  String? getOneName(String? id){
    if(id==null || id==UserFactory().userId){
      return "Me";

    }else{
      return getOneById(id)?.desc;
    }
  }

  //从服务器获得全部的联系人
  Future<void>loadContactsFromServer({bool forcedReload=false})async{

    if(contacts.isEmpty || forcedReload){
      var params=<String,String>{"userId":UserFactory().userId??""};


      var re=await Communicate().withHost(actionUrl: "/api/contact/listAll/byUserId",params:params);


      var items=(re.content as List).map((d)=>ContactThumbnail.fromJson(d)).toList();

      for (var contact in items) {
        String r=PinyinHelper.getPinyinE(contact.desc??"");
        if(r.isNotEmpty){
          contact.groupId=r.substring(0,1).toUpperCase();
        }else{
          contact.groupId=" ";
        }

      }

      contacts.value=items;

      update();
    }


  }

  //删除一个联系人
  Future<ContactThumbnail>removeOneFromServer(String id)async{
    var params=<String,String>{"userId":UserFactory().userId??"","id":id};


    var re=await Communicate().withHost(actionUrl: "/api/contact/del/one",params:params);



    contacts.value=[...contacts..removeWhere(((one)=>one.id==id))];

    update();

    return ContactThumbnail.fromJson(re.content);

  }

  ContactThumbnail? getOneById(String contactId)=>contacts.firstWhereOrNull((one) => one.id==contactId);


  //加入一个临时联系人，临时联系人需要等待确认
  //收到加好友的申请以后，则先加入临时联系人，此功能主要是为了保证后续的操作，避免本机没有数据，需要异步获取
  //降低复杂度
  //用于新增联系人的第一步
  Future<void> addOneTempContact(String contactId)async{

    //首先检查联系人信息是否已经存在，避免重复添加
    var found=getOneById(contactId);



    if(found==null){ //没有找到再添加

      //debugPrint("开始添加");
      //从服务器获得临时联系人的信息.
      var _user=await UserSerive().getOneUserById(contactId);


      var _con=ContactThumbnail(id: _user.id??"",createDateTime: DateTime.now(),desc:"${_user.nickName}",
          remark: "To be confirmed",contactTel: "${_user.countryCode},${_user.tel}",isBlocked: false,isTemporary: true);



      contacts.value=[_con,...contacts];
      update();
    }


  }

  //将一个联系人确定为正式联系人，对方已经确定
  modifyTempToReal(String contactId){
    var found=getOneById(contactId);

    //found?.isTemporary=false;

    String r=PinyinHelper.getPinyinE(found?.desc??"");
    if(r.isNotEmpty){
      found?.groupId=r.substring(0,1).toUpperCase();
    }else{
      found?.groupId=" ";
    }

    contacts.value=[...contacts];
    update();
  }

  //修改一个联系人的状态
  modifyContactStatus(String contactId,UserStatus status){
    var found=getOneById(contactId);
    found?.userStatus=status;

    contacts.value=[...contacts];
    update();
  }

  bool get showBadge=>contacts.map((one)=>one.isTemporary??true).fold(false, (p, e) => p || e);


}