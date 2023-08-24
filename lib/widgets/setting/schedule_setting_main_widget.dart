import 'package:flutter/material.dart';

import '../../gen/strings.g.dart';
import '../no_disturbing/no_disturbing_setting_main_widget.dart';

class ScheduleSettingWidget extends StatelessWidget {
  const ScheduleSettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Container(
      color: Colors.white,
      child: ListTile(
        leading: const Icon(Icons.schedule,color: Colors.green,),
        title: Text(t.account.noDisturbSchedule),
        trailing: const Icon(Icons.arrow_right),
        onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const NotDistributeSettingWidget()),),
      ),
    );
  }
}



