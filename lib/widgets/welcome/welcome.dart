import 'package:flutter/material.dart';

import 'package:intro_slider/intro_slider.dart';


import '../../gen/strings.g.dart';
import '../login/login_main_widget.dart';
class WelcomeWidget extends StatefulWidget {
  const WelcomeWidget({Key? key}) : super(key: key);

  @override
  State<WelcomeWidget> createState() => _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget> {

  List<Slide> slides = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    slides.add(Slide(



      backgroundOpacity: 0,

      backgroundImage: "assets/images/intro1.jpg",
      directionColorBegin: Alignment.topLeft,
      directionColorEnd: Alignment.bottomRight,


    ));
    slides.add(Slide(

      title:"", //"welcome.screen2".tr(),
      maxLineTitle: 2,
      backgroundOpacity: 0,
      styleTitle:const TextStyle(color:Colors.black87,fontSize: 26 ) ,

      backgroundImage: "assets/images/intro2.jpg",
      directionColorBegin: Alignment.topRight,
      directionColorEnd: Alignment.bottomLeft,
    ));

    slides.add(Slide(




      backgroundOpacity: 0,
      title: "",//"welcome.screen3".tr(),
      maxLineTitle: 2,
      styleTitle:const TextStyle(color:Colors.black87,fontSize: 26 ) ,

      backgroundImage: "assets/images/intro3.jpg",
      directionColorBegin: Alignment.topLeft,
      directionColorEnd: Alignment.bottomRight,


    ));
  }
  void onDonePress() {
    // Do what you want
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginMainWidget()),);
  }



  void onNextPress() {
    //print("onNextPress caught");
  }
  Widget renderNextBtn(BuildContext context) {
    final t = Translations.of(context);
    return  Text(
      "${t.next}",textScaleFactor: 1.2,style: TextStyle(color: Color(0xffF3B4BA)),
    );
  }

  Widget renderDoneBtn(BuildContext context) {
    final t = Translations.of(context);

    return  Text(
      "${t.start}",textScaleFactor: 1.2,style: TextStyle(color: Color(0xffF3B4BA)),
    );
  }

  Widget renderSkipBtn(BuildContext context) {
    final t = Translations.of(context);
    return Text(
        "${t.skip}",textScaleFactor: 1.2,style: TextStyle(color: Color(0xffF3B4BA)),
    );
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.all(12)),

      shape: MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder()),
      backgroundColor: MaterialStateProperty.all<Color>(const Color(0x33F3B4BA)),
      overlayColor: MaterialStateProperty.all<Color>(const Color(0x33FFA8B0)),
    );
  }
  @override
  Widget build(BuildContext context) {


    return IntroSlider(
      // List slides
      slides: slides,

      // Skip button
      renderSkipBtn: renderSkipBtn(context),
      skipButtonStyle: myButtonStyle(),
      onSkipPress: onDonePress,
      // Next button
      renderNextBtn: renderNextBtn(context),
      onNextPress: onNextPress,
      nextButtonStyle: myButtonStyle(),

      // Done button
      renderDoneBtn: renderDoneBtn(context),
      onDonePress: onDonePress,
      doneButtonStyle: myButtonStyle(),

      // Dot indicator
      colorDot: const Color(0x33FFA8B0),
      colorActiveDot: const Color(0xffFFA8B0),
      sizeDot: 13.0,

      // Show or hide status bar
      hideStatusBar: false,

      backgroundColorAllSlides: Colors.grey,

      // Scrollbar
      //verticalScrollbarBehavior: scrollbarBehavior.SHOW_ALWAYS,
    );
  }
}
