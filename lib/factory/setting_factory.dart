import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingFactory{
  static final SettingFactory _singleton = SettingFactory._internal();

  factory SettingFactory() {
    return _singleton;
  }
  SettingFactory._internal();

  late final SharedPreferences _prefs ;


  FlexScheme? _flexScheme;
  FlexScheme get flexScheme=>_flexScheme??FlexScheme.deepPurple;
  set flexScheme(FlexScheme value){
    _flexScheme=value;
    _prefs.setString("flexScheme", "$value");

  }
  //系统语言代码
  String? _languageCode;
  String get languageCode=>_languageCode??"en";

  int getLanguageIndex(){

    if(languageCode=="en"){
      return 0;
    }else{
      if(languageCode=="zh-Hans"){
        return 1;
      }else{
        return 2;
      }
    }


  }

  set languageCode(String value){
    _languageCode=value;

    _prefs.setString("languageCode", value);


  }

  Future<bool> loadAndInit() async{
    try{
      _prefs = await SharedPreferences.getInstance();
      _languageCode=_prefs.get("languageCode")?.toString()?? "en";
      _flexScheme=FlexScheme.values.firstWhere((element) => element.toString()==(_prefs.get("flexScheme")??'FlexScheme.deepPurple'));

      return true;
    }catch(e){
      return false;
    }
  }
}