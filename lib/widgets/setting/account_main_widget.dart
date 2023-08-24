
import 'package:app_ios/widgets/setting/schedule_setting_main_widget.dart';
import 'package:app_ios/widgets/setting/system_setting_widget.dart';
import 'package:app_ios/widgets/setting/user_thumbnail_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import '../../gen/strings.g.dart';
import 'other_functions_widget.dart';

class AccountMainWidget extends StatelessWidget {
  const AccountMainWidget({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(color: Colors.grey.shade200),

        child: SingleChildScrollView(
          child: Column(
            children: [

              const UserThumbnailWidget(),

              const SizedBox(height: 20,),

              const ScheduleSettingWidget(),

              const SizedBox(height: 20,),
              const SystemSettingWidget(),

              const SizedBox(height: 20,),

              const OtherFuncationsWidget()
            ],
          ),
        ),
      ),
    );

  }
}