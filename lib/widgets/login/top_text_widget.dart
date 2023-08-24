import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';


import '../../assistants/login_help.dart';
import '../../contract/enums.dart';
import '../../gen/strings.g.dart';


class TopText extends StatefulWidget {
  const TopText({Key? key}) : super(key: key);

  @override
  State<TopText> createState() => _TopTextState();
}

class _TopTextState extends State<TopText> {
  @override
  void initState() {
    ChangeScreenAnimation.topTextAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return HelperFunctions.wrapWithAnimatedBuilder(
      animation: ChangeScreenAnimation.topTextAnimation,
      child: AutoSizeText(
        ChangeScreenAnimation.currentScreen == Screens.createAccount
            ? t.login.makeAccount
            : t.login.welcome,
        style: const TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}