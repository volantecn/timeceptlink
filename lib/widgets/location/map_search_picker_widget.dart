import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:provider/provider.dart';

import '../../factory/location_factory.dart';
import 'map_search_picker_content_widget.dart';

class MapSearchPickerWidget extends StatelessWidget {
  const MapSearchPickerWidget({super.key});

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: const Text('location picker'),
      ),
      body:FutureProvider<Position?>(
        create: (_)async=>LocationFactory.to.firstGetCurrentPosition(),
        initialData: null,

        child: Consumer<Position?>(
          builder: (_,locationData,__){

            if(locationData!=null){
              return MapSearchPickerContentWidget(locationData: locationData,);

            }else{
              return const Center(child: CircularProgressIndicator(),);
            }

          },
        ),
      ),
    );
  }
}




