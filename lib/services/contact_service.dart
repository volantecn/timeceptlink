import 'package:app_ios/factory/user_factory.dart';
import 'package:app_ios/models/contact_item_model.dart';

import '../assistants/communcation/communcate.dart';

class ContactService{

  //申请添加联系人
  //会一次添加一对联系人
  //可以是临时也可以是正式的
  Future<ContactThumbnail> applyForNewContact(String countryCode,String tel,bool isTemp)async{
    var params=<String,String>{"countryCode":countryCode,"tel":tel,"senderId":UserFactory().userId??"","isTemp":"$isTemp"};

    var re=await Communicate().withHost(actionUrl: "/api/contact/new/group",params:params);



    var _user= ContactThumbnail.fromJson(re.content);

    return _user;
  }

  Future<ContactThumbnail>modifyOneContact(String userId,String contactId,bool isTemp)async{

    var params=<String,String>{"userId":userId,"contactId":contactId,"isTemp":"$isTemp"};

    var re=await Communicate().withHost(actionUrl: "/api/contact/modify/one",params:params);



    var _user= ContactThumbnail.fromJson(re.content);

    return _user;
  }

  Future<ContactThumbnail>modifyOneContactRemark(String userId,String contactId,String remark)async{

    var params=<String,String>{"userId":userId,"contactId":contactId,"remark":"$remark"};

    var re=await Communicate().withHost(actionUrl: "/api/contact/modify/one",params:params);



    var _user= ContactThumbnail.fromJson(re.content);

    return _user;
  }
}