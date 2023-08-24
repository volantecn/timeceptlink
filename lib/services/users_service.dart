import '../assistants/communcation/communcate.dart';
import '../models/user_model.dart';

class UserSerive{

  Future<User> getOneUserById(String id)async{
    var params=<String,String>{"id":id};

    var re=await Communicate().withHost(actionUrl: "/api/user/getOne/ById",params:params);

    //debugPrint("${re.content}");

    var _user= User.fromJson(re.content);

    return _user;
  }

  Future<User>getOneByTel(String countryCode,String tel)async{

    var params=<String,String>{"countryCode":countryCode,"tel":tel};

    var re=await Communicate().withHost(actionUrl: "/api/user/getOne/ByTel",params:params);



    return User.fromJson(re.content);
  }

  Future<User>getOneById(String id)async{

    var params=<String,String>{"id":id};

    var re=await Communicate().withHost(actionUrl: "/api/user/getOne/ById",params:params);



    return User.fromJson(re.content);
  }


}