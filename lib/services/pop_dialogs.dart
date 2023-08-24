import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../gen/strings.g.dart';
import '../widgets/location/disabled_geo_tips_widget.dart';
import '../widgets/location/geo_location_permission_widget.dart';

class PopDialog{
  final BuildContext? context;
  PopDialog.of(this.context);

  Future<String?> delSelection()async{

    String _selection="";



    return await showDialog<String>(
        context: context!,
        builder: (context){
          final t = Translations.of(context);
          return AlertDialog(

            contentPadding: EdgeInsets.only(top:30),
            content: DelSelectionWidget(done: (value){
              _selection=value;
            },),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: Text(t.cancel),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child:Text(t.ok),
                onPressed: () {
                  Navigator.of(context).pop(_selection);
                },
              ),
            ],
          );
        }

    );
  }

  Future<bool?>delConfirm({required String title})async{

    return await showDialog<bool>(
        context: context!,
        builder: (context){
          return AlertDialog(

            contentPadding: EdgeInsets.only(top:30),
            content: ListTile(
              leading: Icon(Icons.question_mark_sharp),
              title: Text(title),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: Text(t.cancel),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child:Text(t.ok),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        }
    );
  }

  //举报
  Future<bool?>reportContent()async{

    return await showDialog<bool>(
        context: context!,
        builder: (context){
          return AlertDialog(

            title: Text("Report Inappropriate"),
            contentPadding: EdgeInsets.only(top:30),
            content: ListTile(
              title: Text("Is this post(message) inappropriate? We will review this report within 24 hrs and if deemed inappropriate the post will be removed within that timeframe. We will also take actions against it's author"),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: Text(t.cancel),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child:Text("Yes,report"),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        }
    );
  }


  //拉黑
  Future<bool?>blockConfirm()async{

    return await showDialog<bool>(
        context: context!,
        builder: (context){
          return AlertDialog(

            title: Text("Block this contact"),
            contentPadding: EdgeInsets.only(top:30),
            content: ListTile(

              title: Text("After blocking,this contact will not be able to send you any messages"),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: Text(t.cancel),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child:Text(t.ok),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        }
    );
  }

  Future<bool?> getLocationPermission()async{

    return await showDialog<bool>(
        context: context!,
        builder: (context)=>AlertDialog(


          content: GeoLocationPermissionWidget(),

        )
    );

  }

  Future<void>getLocationFailureTips()async{
    return await showDialog<void>(
        context: context!,
        builder: (context)=>AlertDialog(


          content: DisabledGeoTipsWidget(),

        )
    );
  }
}



class DelSelectionWidget extends StatefulWidget {

  final ValueSetter<String>?done;
  const DelSelectionWidget({Key? key,@required this.done}) : super(key: key);

  @override
  State<DelSelectionWidget> createState() => _DelSelectionWidgetState();
}

class _DelSelectionWidgetState extends State<DelSelectionWidget> {


  late String? _selection;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selection="local";

    widget.done!(_selection!);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: Radio<String>(
                value:"local",
                groupValue:_selection,
                onChanged: (value){
                  setState(() {
                    _selection=value;
                  });
                  widget.done!(value!);
                },
              ),
              title: Text(t.message.deleteLocal),

            ),
            Divider(indent: 20,),
            ListTile(
              leading: Radio<String>(
                value:"all",
                groupValue:_selection,
                onChanged: (value){
                  setState(() {
                    _selection=value;
                  });
                  widget.done!(value!);
                },
              ),
              title: Text(t.message.deleteAll),

            )

          ],
        ),
      ),
    );
  }
}