import 'package:flutter/material.dart';

import '../near_me/web_view_content.dart';



class BrowserWidget extends StatelessWidget {
  final String url;
  final String? title;
  const BrowserWidget({Key? key,this.url="https://google.com",this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text( title??url,overflow: TextOverflow.ellipsis,softWrap: true,),),
      body: SafeArea(
        child:WebViewContentWidget(url: url,),
      ),
    );
  }
}
