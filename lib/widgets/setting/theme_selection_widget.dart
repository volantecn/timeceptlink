import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:restart_app/restart_app.dart';

import '../../contract/pre_define.dart';
import '../../factory/setting_factory.dart';
import '../../gen/strings.g.dart';
import '../public/selection_widget.dart';


class ThemeSelectionWidget extends StatefulWidget {
  const ThemeSelectionWidget({super.key});

  @override
  State<ThemeSelectionWidget> createState() => _ThemeSelectionWidgetState();
}

class _ThemeSelectionWidgetState extends State<ThemeSelectionWidget> {
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Container(
      color: Colors.white,
      child: ListTile(
        title: Text(t.setting.theme),

        trailing: SelectionWidget(selections: ConstantSetting().innerThemes,requiredLocalization: true,initValue: SettingFactory().flexScheme.toString(),
          selectedValue: (value)async{

              setState(() {
                SettingFactory().flexScheme=FlexScheme.values.firstWhere((e) => e.toString() == value);


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



