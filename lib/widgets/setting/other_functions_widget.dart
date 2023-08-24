import 'package:app_ios/widgets/setting/safty_setting_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';

import '../../factory/user_factory.dart';
import '../../gen/strings.g.dart';
import '../../services/pop_dialogs.dart';

class OtherFuncationsWidget extends StatelessWidget {
  const OtherFuncationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Container(
      color: Colors.white,
      child: Column(

        children: [
          ListTile(
            leading: const Icon(Icons.health_and_safety_outlined ,color: Colors.redAccent,),
            title: Text(t.setting.privateAndSafety),
            trailing: const Icon(Icons.arrow_right),
            onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SaftySettingMainWidget())),
          ),

          const Divider(indent: 10,endIndent: 10,),

          SizedBox(height: 46,width:double.infinity,

            child: Center(
              child: TextButton(onPressed: ()async{

                var confirm=await PopDialog.of(context).delConfirm(title: t.setting.confirmToExit);

                if(confirm??false){
                  await UserFactory().logOut();

                  FlutterExitApp.exitApp();
                }


              }, child: Text(t.setting.exit,style: TextStyle(fontSize: 16))
              ),
            ),
          )
        ],
      ),
    );
  }
}
