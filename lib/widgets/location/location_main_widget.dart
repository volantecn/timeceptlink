import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../factory/location_factory.dart';
import '../../services/pop_dialogs.dart';
import 'geo_location_permission_widget.dart';
import 'map_spot_shot_widget.dart';




class LocationMainWidget extends StatelessWidget {
  const LocationMainWidget({super.key});

  @override
  Widget build(BuildContext context) {




    return FutureProvider<Position?>(
        create: (_)async{

          try{

            //第一步确定只能问一次
            if(!LocationFactory.to.askAgain)return null;

            if(LocationFactory.to.allowToGetLocation){

              return await LocationFactory.to.getCurrentPosition();

            }else{

              var re=await SmartDialog.show<bool>(builder: (_)=>Container(color: Colors.white,child: GeoLocationPermissionWidget(),));


              if(re??false){
                return await LocationFactory.to.getCurrentPosition();
              }else{
                await PopDialog.of(context).getLocationFailureTips();
                LocationFactory.to.setaskAgain(false);
                return null;
              }

            }

          }catch(e){


          }finally{

          }

        },
        catchError: (_,e)=>null,
        initialData: null,

        child: Consumer<Position?>(
          builder: (_,location,__){


            if(location!=null){
              return Container(
                  child: MapSpotShotWidget(lat: location.latitude,lng: location.longitude, marker: '',)
              );
            }else{
              return Container(child: Text(""),);
            }





          },
        )

    );
  }
}

