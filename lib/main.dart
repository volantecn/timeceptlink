import 'package:app_ios/factory/contact_factory.dart';
import 'package:app_ios/factory/network_status_factory.dart';
import 'package:app_ios/widgets/login/login_main_widget.dart';
import 'package:app_ios/widgets/welcome/welcome.dart';
import 'package:app_ios/widgets/workshop/lobby_main_widget.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';


import 'factory/country_selection_factory.dart';
import 'factory/notification_factory.dart';
import 'factory/setting_factory.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

import 'factory/system_init.dart';

import 'factory/user_factory.dart';
import 'gen/strings.g.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await SettingFactory().loadAndInit();






  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;
  }

  //LocaleSettings.useDeviceLocale(); // initialize with the right locale
  LocaleSettings.setLocale(AppLocale.values[SettingFactory().getLanguageIndex()]);

  //LocaleSettings.useDeviceLocale();
  runApp(TranslationProvider(
    // wrap with TranslationProvider
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {



    return MaterialApp(
      title: 'TimeCept',
      debugShowCheckedModeBanner: false,
      // The Mandy red, light theme.
      theme: FlexThemeData.light(scheme: SettingFactory().flexScheme),
      // The Mandy red, dark theme.
      darkTheme: FlexThemeData.dark(scheme: SettingFactory().flexScheme),
      // Use dark or light theme based on system setting.
      themeMode: ThemeMode.light,
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget with WidgetsBindingObserver{
  const MyHomePage({super.key});


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    if (state==AppLifecycleState.resumed ){
      //从服务器获取一次
      SystemInit().init();
      //TimeZoneFactory().init(UserFactory().user);
    }
  }
  @override
  Widget build(BuildContext context) {
    return FutureProvider<String?>(
        create: (_)async{

          var re="";
          try {
            Get.put(NetWorkStatusFactory());
            Get.put(CountrySelectionFactory());
            await NotificationFactory().init();

            await UserFactory().init();



            //如果本地保存有登录信息，就执行后续初始化，否则就取消
            if(UserFactory().isLogIn()){

              re= await SystemInit().init();

            }





            return re;

          }
          catch(e){
            return "$e";
          }
        },
        initialData: null,

        child: Consumer<String?>(

          builder: (_,prompt,__){

            if(prompt==""){
              if(UserFactory().isLogIn()){
                return const LobbyWidget();
              }else{

                debugPrint(UserFactory().userId);
                if(UserFactory().userId?.isNotEmpty??false){
                  return const LoginMainWidget();
                }else{
                  return const WelcomeWidget();
                }

              }

            }else{

              if(prompt==null){
                return Material(child: Center(child: CircularProgressIndicator(),),color: Colors.white,);

              }else{
                return  Material(child: Center(
                  child: ListTile(
                    leading: Icon(Icons.error),

                    title: Text("Error:$prompt"),
                  ),
                ),);

              }
            }

          },

        ),
    );
  }
}

