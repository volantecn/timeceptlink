import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../../factory/user_factory.dart';

class UserQrCodeWidget extends StatelessWidget {
  const UserQrCodeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(20),

      child: PrettyQr(
        //image: AssetImage('assets/images/launcher.png'),
        size: double.infinity,
        data: "TimeCeptUserId-${UserFactory().userId??""}",
        errorCorrectLevel: QrErrorCorrectLevel.M,
        typeNumber: null,
        roundEdges: true,
      ),
    );
  }
}
