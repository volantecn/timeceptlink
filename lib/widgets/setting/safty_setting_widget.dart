import 'package:app_ios/factory/dialogue_factory.dart';
import 'package:app_ios/factory/message_factory.dart';
import 'package:app_ios/services/pop_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';

import '../../gen/strings.g.dart';

class SaftySettingMainWidget extends StatelessWidget {
  const SaftySettingMainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(t.setting.privateAndSafety),

      ),
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child:Column(
          children: [

            SizedBox(height: 20,),

            ListTile(
              leading: const Icon(Icons.cleaning_services_outlined ,color: Colors.redAccent,),
              title: Text(t.setting.cleanLocal),
              subtitle: Text(t.setting.cleanLocalExplan),
              trailing: const Icon(Icons.arrow_right),
              onTap: ()async{

                var confirm=await PopDialog.of(context).delConfirm(title: t.setting.cleanLocalConfirm);

                if(confirm??false){


                  await MessageFactory.to.delAllLocalMessage();

                  await DialogueFactory.to.delAllLocal();



                  //
                   FlutterExitApp.exitApp();

                }
              },
            ),

            Divider(),

            ListTile(
              leading: const Icon(Icons.exit_to_app ,color: Colors.deepPurple,),
              title: Text(t.setting.unregister),
              subtitle: Text(t.setting.unregisterMessage),
              trailing: const Icon(Icons.arrow_right),
              onTap: ()async{

                var confirm=await PopDialog.of(context).delConfirm(title: t.setting.unregisterConfirm);
                if(confirm??false){


                  Future.delayed(Duration(seconds: 1));

                  //
                  FlutterExitApp.exitApp();

                }

              }
            ),
            Divider(),


          ],
        ),
      ),
    );
  }
}
