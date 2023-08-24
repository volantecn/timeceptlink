import 'package:app_ios/factory/country_selection_factory.dart';
import 'package:app_ios/widgets/login/social_login_widget.dart';
import 'package:app_ios/widgets/login/top_text_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import '../../assistants/login_help.dart';
import 'package:regexpattern/regexpattern.dart';
import '../../factory/system_init.dart';
import '../../factory/user_factory.dart';
import '../../gen/strings.g.dart';
import '../public/country_select_widget.dart';
import '../public/divider_text_widget.dart';
import '../workshop/lobby_main_widget.dart';
import 'bottom_text_widget.dart';
import 'package:get/get.dart';


class LoginContentWidget extends StatefulWidget {
  const LoginContentWidget({Key? key}) : super(key: key);

  @override
  State<LoginContentWidget> createState() => _LoginContentWidgetState();
}

class _LoginContentWidgetState extends State<LoginContentWidget> with TickerProviderStateMixin{


  late final List<Widget> createAccountContent;
  late final List<Widget> loginContent;


  final TextEditingController _telControl = TextEditingController();

  final TextEditingController _nameControl = TextEditingController();

  final TextEditingController _pwsControl = TextEditingController();

  final TextEditingController _pwsAgainControl = TextEditingController();

  final TextEditingController _telLoginControl = TextEditingController(text: "${UserFactory().tel??""}");
  final TextEditingController _pwsLoginControl = TextEditingController();



  Widget inputField(String hint, IconData iconData,TextEditingController controller,{TextInputType keyboardType=TextInputType.text,
    bool obscureText=false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
      child: SizedBox(
        height: 50,
        child: Material(
          elevation: 8,
          shadowColor: Colors.black87,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          child: TextFormField(
            controller: controller,

            obscureText:obscureText,
            keyboardType: keyboardType,

            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: hint,

              prefixIcon: Icon(iconData),
              //prefixIconColor: Theme.of(context).colorScheme.onPrimary,
              //prefix: Text(prefix,style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),)
            ),

          ),
        ),
      ),
    );
  }


  Widget registerButton() {
    //final t = Translations.of(context);
    final english = AppLocale.en.build();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 16),
      child: ElevatedButton(
        onPressed: () async{

          String _tel=_telControl.text;
          String _pws=_pwsControl.text;
          String _name=_nameControl.text;
          String _pwsAgain=_pwsAgainControl.text;

          if(_tel.isNumeric()&&_tel.length>=8){
            //print(_telControl.text);

            if(_name.length>=2 && _name.length<=24){

              //print(_nameControl.text);

              if(_pws.isPasswordNormal1()){
                //print(_pwsControl.text);
                if(_pws.compareTo(_pwsAgain)==0){
                  //print(_pwsAgainControl.text);

                  //print(_countryCode);
                  //比较完成，可以正式注册了。

                  try{
                    SmartDialog.showLoading();

                    var user=await UserFactory().register(_name, _pws, CountrySelectionFactory.to.countryCode.value, _tel);

                    //注册成功以后正式登录
                    await UserFactory().login(user.countryCode??"", user.tel??"", _pws);

                    SmartDialog.dismiss();
                    await SmartDialog.showToast(english.login.registerDone,displayTime:const Duration(seconds: 2));

                    var re=await SystemInit().init();

                    if(re.isNotEmpty) throw Exception(re);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context)=>const LobbyWidget()),fullscreenDialog: false));

                  }catch(e){
                    SmartDialog.dismiss();
                    if("$e"=="numberRegistered"){
                      SmartDialog.showToast(english.numberRegistered,displayTime:const Duration(seconds: 5) );
                    }else{
                      SmartDialog.showToast("$e",displayTime:const Duration(seconds: 5) );
                    }



                  }

                  //注册以后返回注册结果

                }else{
                  SmartDialog.showToast(english.error.pwsNotMatch);
                }
              }else{
                SmartDialog.showToast(english.error.pwsIsTooSimple);
              }
            }else{
              SmartDialog.showToast(english.error.invalidNameLegth);
            }
          }else{
            SmartDialog.showToast(english.error.invalidNumber);
          }
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: const StadiumBorder(),
          //backgroundColor: kSecondaryColor,
          elevation: 8,
          shadowColor: Colors.black87,
        ),
        child: AutoSizeText(
          english.login.signUp,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,

          ),
        ),
      ),
    );
  }

  Widget loginButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 16),
      child: ElevatedButton(
        onPressed: () async{

          String _tel=_telLoginControl.text;
          String _pws=_pwsLoginControl.text;

          try{
            SmartDialog.showLoading();

            await UserFactory().login(CountrySelectionFactory.to.countryCode.value, _tel, _pws);


            SmartDialog.dismiss();

            var re=await SystemInit().init();

            if(re.isNotEmpty) throw Exception(re);

            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context)=>const LobbyWidget()),fullscreenDialog: false));

          }catch(e){
            SmartDialog.dismiss();
            SmartDialog.showToast(t[e.toString().trim()],displayTime:const Duration(seconds: 5) );



          }

        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: const StadiumBorder(),
          //backgroundColor: kSecondaryColor,
          elevation: 8,
          shadowColor: Colors.black87,
        ),
        child: AutoSizeText(
          t.login.login,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,

          ),
        ),
      ),
    );
  }



  Widget forgotPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 110),
      child: TextButton(
        onPressed: () {},
        child:TextButton(
          child: Text(t.login.forget,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: kSecondaryColor,
            ),),
          onPressed: (){},
        ),
      ),
    );
  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();



    createAccountContent = [
      Obx(()=>CountrySelect(initCountry:CountrySelectionFactory.to.countryCode.value,)),

      inputField(t.login.tel, Icons.phone_android,_telControl,
          keyboardType: TextInputType.phone),

      inputField(t.login.name, Icons.person,_nameControl),
      inputField(t.login.pws, Icons.lock,_pwsControl,obscureText:true),
      inputField(t.login.pwsAgain, Icons.lock,_pwsAgainControl,obscureText:true),
      registerButton(),

      const SocialLoginWidget(),

      DividerWithTextWidget(primaryColor: kPrimaryColor,title: t.or,),
    ];

    loginContent = [
      Obx(()=>CountrySelect(initCountry:CountrySelectionFactory.to.countryCode.value,)),

      inputField(t.login.tel, Icons.phone_android,_telLoginControl,keyboardType: TextInputType.phone),
      inputField(t.login.pws, Icons.lock,_pwsLoginControl,obscureText:true),
      const SizedBox(height: 60,),
      loginButton(),
      forgotPassword(),
      DividerWithTextWidget(primaryColor: kPrimaryColor,title: t.or,),
      //const SocialLoginWidget(),
    ];

    ChangeScreenAnimation.initialize(
      vsync: this,
      createAccountItems: createAccountContent.length,
      loginItems: loginContent.length,
    );
    for (var i = 0; i < createAccountContent.length; i++) {
      createAccountContent[i] = HelperFunctions.wrapWithAnimatedBuilder(
        animation: ChangeScreenAnimation.createAccountAnimations[i],
        child: createAccountContent[i],
      );
    }
    for (var i = 0; i < loginContent.length; i++) {
      loginContent[i] = HelperFunctions.wrapWithAnimatedBuilder(
        animation: ChangeScreenAnimation.loginAnimations[i],
        child: loginContent[i],
      );



    }

  }
  @override
  void dispose() {




    //_telControl.dispose();

    //_nameControl.dispose();

    //_pwsAgainControl.dispose();

    //_pwsAgainControl.dispose();

    //_pwsLoginControl.dispose();

    //_telLoginControl.dispose();

    ChangeScreenAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> display=[
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: createAccountContent,
      ),

      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: loginContent,
      ),

    ];



    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          const Padding(
            padding:EdgeInsets.only(top:90,left: 24),

            child: TopText(),
          ),
          Padding(
            padding:  const EdgeInsets.only(top:30),
            child: Stack(
              children: display,
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 50),
              child: BottomText(),
            ),
          ),
        ],
      ),
    );
  }
}
