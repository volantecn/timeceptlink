import 'package:app_ios/models/message_model.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OneMessageStatusWidget extends StatelessWidget {
  final MessageModel?message;
  const OneMessageStatusWidget({super.key,@required this.message});

  @override
  Widget build(BuildContext context) {



    var sendTime=Text(DateFormat("HH:mm:ss").format(message?.postDateTime??DateTime.now()),style: TextStyle(fontSize: 12,color: Theme.of(context).colorScheme.onSecondary));

    var status=Icon(BootstrapIcons.check_all,color:Theme.of(context).colorScheme.onPrimary,);


    if(!(message?.reached??false)){
      if(message?.isScheduled??false){
        sendTime=Text(DateFormat("yyyy-MM-dd HH:mm").format(message?.scheduleDateTime??DateTime.now()),style: TextStyle(fontSize: 12,color: Theme.of(context).colorScheme.onSecondary));

        status= Icon(BootstrapIcons.clock,color:Theme.of(context).colorScheme.onSecondary,size: 12,);

      }else{

        sendTime=Text(DateFormat("HH:mm:ss").format(message?.postDateTime??DateTime.now()),style: TextStyle(fontSize: 12,color: Theme.of(context).colorScheme.onSecondary));


        status=Icon(BootstrapIcons.check ,color: Theme.of(context).colorScheme.onSecondary,);
      }


    }

    return  Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [

        sendTime,

        status

      ],

    );
  }
}
