import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../factory/chat_factory.dart';
import '../../factory/contact_factory.dart';
import '../../factory/dialogue_factory.dart';
import '../../factory/message_factory.dart';
import '../../factory/time_zone_factory.dart';
import '../../factory/user_factory.dart';
import 'lobby_content_widget.dart';

class LobbyWidget extends StatelessWidget {
  const LobbyWidget({super.key});









  @override
  Widget build(BuildContext context) {


    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(

          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.grey.shade100, // Change Background color

          systemNavigationBarIconBrightness: Brightness.dark
      ),
      child: const LobbyContentWidget(),
    );




  }
}
