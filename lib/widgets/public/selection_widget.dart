import 'package:flutter/material.dart';

import '../../gen/strings.g.dart';

class SelectionWidget extends StatefulWidget {

  final Map<String,String>?selections;

  final ValueSetter<String>? selectedValue;

  final String? initValue;

  final bool? requiredLocalization;

  const SelectionWidget({Key? key,@required this.selections,@required this.initValue,@required this.selectedValue,this.requiredLocalization=true}) : super(key: key);

  @override
  _SelectionWidgetState createState() => _SelectionWidgetState();
}

class _SelectionWidgetState extends State<SelectionWidget> {




  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return DropdownButton<String>(
      value: widget.initValue,
      items:widget.selections?.entries.map((e) => DropdownMenuItem<String>(
        value: e.key,
        child: Text((widget.requiredLocalization??true)?t[e.value]:e.value),
      )).toList()??[],
      onChanged: (value){
        widget.selectedValue!(value??"");
      },
    );
  }
}