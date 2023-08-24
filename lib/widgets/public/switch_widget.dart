import 'package:flutter/material.dart';

class SwitchWidget extends StatefulWidget {
  final ValueSetter<bool>? swithChanged;
  final bool? initValue;

  const SwitchWidget({Key? key,@required this.initValue, @required this.swithChanged}) : super(key: key);

  @override
  _SwitchWidgetState createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {

  bool? _initValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initValue=widget.initValue??false;

  }

  @override
  Widget build(BuildContext context) {

    return Switch(
        value: _initValue??false,
        onChanged: (value) {
          setState(() {
            _initValue=value;
          });
          widget.swithChanged!(value);

        }
    );
  }
}