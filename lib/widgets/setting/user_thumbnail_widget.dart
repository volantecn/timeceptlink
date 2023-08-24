import 'package:app_ios/widgets/setting/user_qr_code_widget.dart';
import 'package:flutter/material.dart';

import '../../contract/pre_define.dart';
import '../../factory/user_factory.dart';
import '../../services/attached_dialog.dart';

class UserThumbnailWidget extends StatelessWidget {
  const UserThumbnailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var user=UserFactory().user;



    return Container(
      color: Colors.white,
      child: ListTile(
        leading: const Icon(Icons.person_add,size: 32,),
        title: Text("${user.nickName}"),
        subtitle: Text("${HtmlSymbol.tel} ${user.countryCode}${user.tel}"),

        trailing: IconButton(
          icon: const Icon(Icons.qr_code),
          onPressed: ()async{
            await AttachedDialog.of(context).smallDialog(const UserQrCodeWidget(),aligment: Alignment.bottomRight);
          },
        ),
      ),
    );
  }
}
