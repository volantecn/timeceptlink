import 'package:app_ios/factory/no_disturbing_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart' hide Trans;
import '../../gen/strings.g.dart' as ts;
import 'no_disturbing_item_list_widget.dart';

class NotDistributeSettingWidget extends StatelessWidget {
  const NotDistributeSettingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = ts.Translations.of(context);
    return   Scaffold(
      appBar: AppBar(
        title: Text(t.account.noDisturbSchedule),
      ),
      body: SafeArea(
        child: Obx(()=>NoDisturbingItemsListWidget(items: NoDisturbingFactory.to.items.value,)),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          try{
            SmartDialog.showLoading();
            await NoDisturbingFactory.to.newOneScheduledItem();
          }catch(e){
            SmartDialog.showToast("$e");
          }finally{
            SmartDialog.dismiss(status: SmartStatus.loading);
          }

        },
        child: const Icon(Icons.add),
      ),
    );
  }
}