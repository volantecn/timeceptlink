import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../contract/pre_define.dart';
import '../public/browser_widget.dart';

class MapSpotShotWidget extends StatelessWidget {
  final double? lat;
  final double? lng;
  final String marker;
  const MapSpotShotWidget({Key? key,@required this.lat,@required this.lng,this.marker="You"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
    Set<Marker> _createMarker(double lat,double lng) {
      return {

        Marker(
          markerId: MarkerId(marker),
          position: LatLng(lat, lng),
        ),
      };
    }
    final LatLng _kMapCenter = LatLng(lat??0, lng??180);
    final CameraPosition _kInitialPosition = CameraPosition(target: _kMapCenter, zoom: 17.0, tilt: 1, bearing: 1);

    var keys=ConstantSetting().symbolToIcon.keys.toList();


    return Column(
      children: [

        Expanded(child: GoogleMap(
          //mapType: MapType.terrain,
          initialCameraPosition: _kInitialPosition,
          trafficEnabled: true,
          tiltGesturesEnabled: true,
          myLocationButtonEnabled: true,
          //mapType: MapType.hybrid,
          indoorViewEnabled: true,


          markers:_createMarker(lat??0,lng??0),
          onMapCreated: (GoogleMapController controller) {
            debugPrint("地图创建成功了，，，，，，，，，，地图创建成功");
            _controller.complete(controller);
          },

        ),),
        SizedBox(
          height: kBottomNavigationBarHeight+10,
          width: double.infinity-30,
          child: Container(

            color:  Colors.grey.shade100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,

              itemCount: keys.length,
              itemBuilder: (_,index)=>IconButton(onPressed: (){



                String url="https://www.google.com/maps/search/${keys[index]}/@$lat,$lng";

                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>BrowserWidget(url: url,title: "${keys[index]}",)));

              }, icon: Icon(ConstantSetting().symbolToIcon[keys[index]])),
            ),
          ),
        ),

      ],
    );
  }
}
