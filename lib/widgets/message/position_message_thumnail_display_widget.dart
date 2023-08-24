import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../models/location_model.dart';
import '../../models/message_model.dart';

class PositionMessageThumbnailDisplayWidget extends StatelessWidget {
  final MessageModel? message;
  final bool isReceiver;
  const PositionMessageThumbnailDisplayWidget({super.key,@required this.message,this.isReceiver=false});

  Set<Marker> _createMarker() {
    LocationThumbnail location=LocationThumbnail.fromJson( jsonDecode(message?.content??"{}"));
    return {

      Marker(
        markerId: MarkerId(message?.comments??""),
        position: LatLng(location.latitude??0, location.longitude??180),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;

    LocationThumbnail location=LocationThumbnail.fromJson( jsonDecode(message?.content??"{}"));
    final LatLng _kMapCenter = LatLng(location.latitude??0, location.longitude??180);
    final CameraPosition _kInitialPosition = CameraPosition(target: _kMapCenter, zoom: 12.0, tilt: 1, bearing: 1);

    return SizedBox(
      width: width*0.4,
      height: width*0.5,
      child:  Column(
        children: [Expanded(child: GoogleMap(
          compassEnabled: false,
          mapToolbarEnabled: false,
          rotateGesturesEnabled: false,
          scrollGesturesEnabled: false,
          zoomControlsEnabled: false,
          zoomGesturesEnabled: false,
          tiltGesturesEnabled: false,
          initialCameraPosition: _kInitialPosition,

          markers: _createMarker(),
        )),

          SizedBox(height: 20,width: double.infinity,

            child: Text("${location.address}",softWrap: false,overflow: TextOverflow.ellipsis,style: TextStyle(color: isReceiver?Colors.black:Theme.of(context).colorScheme.onSecondary),),
          )
        ],
      ),
    );
  }
}
