import 'package:app_ios/factory/block_factory.dart';
import 'package:app_ios/factory/send_message_factory.dart';
import 'package:app_ios/factory/time_zone_factory.dart';
import 'package:app_ios/factory/user_factory.dart';
import 'package:get/get.dart';

import 'chat_factory.dart';
import 'contact_factory.dart';
import 'country_selection_factory.dart';
import 'dialogue_factory.dart';
import 'location_factory.dart';
import 'message_factory.dart';
import 'no_disturbing_factory.dart';
class SystemInit{

  Future <String>init()async{

    try{

      await await Get.putAsync(()async=>BlockFactory());

      var user=await UserFactory().getCurrentUser(forcedReload: false);




      await Get.putAsync(() async=>await TimeZoneFactory(user!));

      await Get.putAsync(() async=>await ContactFactory() ); //必须先获取Contacts

      await ContactFactory.to.loadContactsFromServer();


      await Get.put(DialogueFactory());

      await DialogueFactory.to.init();

      await Get.put(MessageFactory());

      await MessageFactory.to.init();


      await MessageFactory.to.loadUnReachedMessagesFromServer(ContactFactory.to.contacts.value);



      await Get.putAsync(() async=>await LocationFactory() );

      await LocationFactory.to.getCurrentPosition();


      Get.put(SendMessageFactory());

      await SignalChatFactory().connectStart();

      await Get.putAsync(() async=> await NoDisturbingFactory());

      return "";

    }catch(e){
      return "$e";
    }



  }

}