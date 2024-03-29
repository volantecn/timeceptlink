import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../gen/strings.g.dart';

class SocialLoginWidget extends StatelessWidget {
  const SocialLoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Center(
      child: TextButton(
        child: Padding(
          padding: EdgeInsets.only(left: 20,right: 20),
          child: AutoSizeText(t.welcome.rules),
        ),
        onPressed: ()async{
          final Uri _url = Uri.parse('https://timeceptlink.com/private.html');


          await launchUrl(
            _url,
            mode: LaunchMode.inAppWebView,
            webViewConfiguration: const WebViewConfiguration(enableJavaScript: false),
          );
        },
      ),
    );
  }
}
