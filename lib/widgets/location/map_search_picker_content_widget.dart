import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


import '../../gen/strings.g.dart';
import '../../models/location_model.dart';
import 'get_location_address_widget.dart';


class MapSearchPickerContentWidget extends StatefulWidget {
  final Position? locationData;
  const MapSearchPickerContentWidget({Key? key,@required this.locationData}) : super(key: key);

  @override
  State<MapSearchPickerContentWidget> createState() => _MapSearchPickerContentWidgetState();
}

class _MapSearchPickerContentWidgetState extends State<MapSearchPickerContentWidget> {

  late double _lat;
  late double _lng;

  late String selectedAddressLine;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _lat=widget.locationData?.latitude??0;
    _lng=widget.locationData?.longitude??0;

    selectedAddressLine="";
  }

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();




  Set<Marker> _createMarker(double lat,double lng) {
    return {

      Marker(
        markerId: const MarkerId(""),
        position: LatLng(lat, lng),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final LatLng _kMapCenter = LatLng(_lat,_lng);
    final CameraPosition _kInitialPosition = CameraPosition(target: _kMapCenter, zoom: 17.0, tilt: 1, bearing: 1);
    final t = Translations.of(context);
    return  Stack(
      children: [
        GoogleMap(
          //mapType: MapType.terrain,
          initialCameraPosition: _kInitialPosition,
          trafficEnabled: true,
          tiltGesturesEnabled: true,
          myLocationButtonEnabled: true,

          markers:_createMarker(_lat,_lng),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          onTap: (latlng){

            setState(() {
              _lat=latlng.latitude;
              _lng=latlng.longitude;

            });

          },
        ),
        SizedBox.expand(
          child: DraggableScrollableSheet(
              initialChildSize: 0.2,
              maxChildSize: 0.4,
              minChildSize: 0.1,
              builder: (BuildContext context, ScrollController scrollController){
                return
                  GetLocationAddressWidget(latLng: LatLng(_lat,_lng),controller: scrollController,addressSelected: (addressLine){
                    setState(() {
                      selectedAddressLine=addressLine;
                    });
                  },);
              }
          ),
        ),
        Positioned(
            top: 10,
            right: 10,
            child: ElevatedButton(child: Text(t.message.send),onPressed:selectedAddressLine!=""? (){


              if(selectedAddressLine!=""){

                Navigator.of(context).pop(

                    LocationThumbnail(longitude: _lng,latitude: _lat,accuracy: widget.locationData?.accuracy,
                        altitude: widget.locationData?.altitude,speed: widget.locationData?.speed,address:selectedAddressLine )

                );

              }



            }:null,))
      ],
    );
  }
}