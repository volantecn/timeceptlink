import 'package:app_ios/widgets/setting/setting_main_widget.dart';
import 'package:flutter/material.dart';

import '../../gen/strings.g.dart';
import 'about_us_widget.dart';
import 'allow_get_location_widget.dart';

class SystemSettingWidget extends StatelessWidget {
  const SystemSettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Container(
      color: Colors.white,

      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.settings,color: Colors.amber,),
            title: Text(t.account.setting),
            trailing: const Icon(Icons.arrow_right),
            onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const SettingMainWidget()),),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline,color: Colors.indigo,),
            title: Text(t.setting.aboutUs),
            trailing: const Icon(Icons.arrow_right),
            onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const AboutUsWidget(),fullscreenDialog: true),),
          ),



        ],
      ),
    );
  }
}
