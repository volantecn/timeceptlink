
import 'package:app_ios/widgets/near_me/web_view_content.dart';
import 'package:flutter/material.dart';

import '../../models/url_model.dart';



class NearMeMainWidget extends StatelessWidget {
  final UrlMessageThumbnail? message;
  const NearMeMainWidget({Key? key,@required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${message?.queryWord}"),
      ),

      body: SafeArea(
        child: WebViewContentWidget(url: "https://www.google.com/maps/search/${message?.queryWord??""}/@${message?.latitude},${message?.longitude}",),
      ),
    );
  }
}