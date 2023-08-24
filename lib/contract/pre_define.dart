
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

import '../gen/strings.g.dart';

class ConstantSetting{
  static const apiHostAddress="https://api.timeceptlink.com";
  static const hub="wss://api.timeceptlink.com/chat";

  static const mapKey="AIzaSyCYdo7i2jYrBROaMqielTATpIc1fktf8TU";
  //static const hub="wss://localhost:44345/chat";
  static const connectTimeout=50000;
  static const receiveTimeout=50000;

  final innerThemes=<String,String>{"FlexScheme.bahamaBlue" :"FlexScheme.bahamaBlue","FlexScheme.hippieBlue":"FlexScheme.hippieBlue",
    "FlexScheme.money":"FlexScheme.money","FlexScheme.redWine":"FlexScheme.redWine","FlexScheme.mango":"FlexScheme.mango",
    "FlexScheme.greyLaw":"FlexScheme.greyLaw","FlexScheme.shark":"FlexScheme.shark","FlexScheme.vesuviusBurn":"FlexScheme.vesuviusBurn",
    "FlexScheme.deepPurple":"FlexScheme.deepPurple","FlexScheme.espresso":"FlexScheme.espresso","FlexScheme.deepBlue":"FlexScheme.deepBlue",
    "FlexScheme.jungle":"FlexScheme.jungle","FlexScheme.ebonyClay":"FlexScheme.ebonyClay","FlexScheme.brandBlue":"FlexScheme.brandBlue",
    "FlexScheme.gold":"FlexScheme.gold","FlexScheme.indigo":"FlexScheme.indigo","FlexScheme.outerSpace":"FlexScheme.outerSpace",
    "FlexScheme.barossa":"FlexScheme.barossa"
  };



  final Map<String,IconData> symbolToIcon={"Restaurant":Icons.restaurant,"Shopping":Icons.shopping_cart_sharp,"Cinema":Icons.camera_indoor,
  "Bar":Icons.local_drink,"Park":Icons.park,"Sports+Ground":Icons.sports_football};

  final Map<String,String> languageCodes={"en":"English","zh-Hans":"简体中文","zh-Hant":"繁體中文"};


}



class HtmlSymbol{
  static final no=HtmlUnescape().convert("&#8470;");

  static final dot=HtmlUnescape().convert("&#8226;");

  static final rightDoubleArrow=HtmlUnescape().convert("&#187;");
  static final right=HtmlUnescape().convert("&#10003;");
  static final right2=HtmlUnescape().convert("&#10004;");
  static final wrong=HtmlUnescape().convert("&#10006;");
  static final copyright=HtmlUnescape().convert("&#169;");

  static final clock=HtmlUnescape().convert("&#9716;");

  static final enter=HtmlUnescape().convert("&#8629;");

  static final leftArrow=HtmlUnescape().convert("&#8592;");
  static final rightArrow=HtmlUnescape().convert("&#8594;");
  static final smileFace=HtmlUnescape().convert("&#9786;");

  static final tel=HtmlUnescape().convert("&#9990;");
  static final question=HtmlUnescape().convert("&#65533;");

  static final leftTriangle=HtmlUnescape().convert("&#9668;");
  static final rightTriangle=HtmlUnescape().convert("&#9658;");
  static final refresh=HtmlUnescape().convert("&#8635;");

  static final edit=HtmlUnescape().convert("&#9986;");

}

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}
class MenuItems {
  static const List<MenuItem> firstItems = [addContact, scanQrCode];
  static const List<MenuItem> secondItems = [settings];

  static const addContact = MenuItem(text: 'welcome.addFriend', icon: Icons.person_add_alt_1);
  static const scanQrCode = MenuItem(text: 'welcome.scanQrcode', icon: Icons.qr_code_scanner);
  static const settings = MenuItem(text: 'account.setting', icon: Icons.settings);


  static Widget buildItem(MenuItem item,BuildContext context) {
    final t = Translations.of(context);
    return Row(
      children: [
        Icon(
            item.icon,
            color: Colors.white,
            size: 18
        ),
        const SizedBox(
          width: 6,
        ),
        Text(
          t[item.text],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14
          ),
        ),
      ],
    );
  }


}