import 'package:flutter/material.dart';

import '../../models/location_model.dart';
import 'map_spot_shot_widget.dart';

class DisplayShareLocationWidget extends StatelessWidget {
  final LocationThumbnail? location;
  final String? title;

  const DisplayShareLocationWidget({Key? key,@required this.location,this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${title??(location?.address)}"),
      ),
      body: SafeArea(
        child: MapSpotShotWidget(lng: location?.longitude??0,lat: location?.latitude,marker: location?.address??"",),


      ),
    );
  }
}