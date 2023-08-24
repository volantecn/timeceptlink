import 'package:app_ios/widgets/setting/theme_selection_widget.dart';
import 'package:flutter/material.dart';

import '../../gen/strings.g.dart';
import 'allow_get_location_widget.dart';
import 'language_selection_widget.dart';




class SettingMainWidget extends StatelessWidget {
  const SettingMainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(t.account.setting),
      ),
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: const [

            SizedBox(height: 10,),

            LanguageSelectionWidget(),
            ThemeSelectionWidget(),

            AllowGetLocationSwitchWidget(),
          ],
        ),
      ),
    );
  }
}
