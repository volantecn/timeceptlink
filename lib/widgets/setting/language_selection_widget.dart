import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../contract/pre_define.dart';
import '../../factory/setting_factory.dart';
import '../../gen/strings.g.dart';
import '../public/selection_widget.dart';
import 'package:restart_app/restart_app.dart';

class LanguageSelectionWidget extends StatefulWidget {
  const LanguageSelectionWidget({super.key});

  @override
  State<LanguageSelectionWidget> createState() => _LanguageSelectionWidgetState();
}

class _LanguageSelectionWidgetState extends State<LanguageSelectionWidget> {
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Container(
      color: Colors.white,
      child:  ListTile(
        title: Text(t.setting.language),
        trailing: SelectionWidget(selections: ConstantSetting().languageCodes,initValue: SettingFactory().languageCode,requiredLocalization: false,
          selectedValue: (value)async{

            setState(() {
              SettingFactory().languageCode=value;
            });

            SmartDialog.showLoading();

            await Future.delayed(Duration(seconds: 1));

            SmartDialog.dismiss();

            Restart.restartApp();

          },),

      ),
    );
  }
}




