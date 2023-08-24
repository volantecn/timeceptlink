import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:geocoding/geocoding.dart';

class GetLocationAddressWidget extends StatefulWidget {
  final LatLng? latLng;
  final ScrollController?controller;
  final ValueSetter<String>?addressSelected;
  const GetLocationAddressWidget({Key? key,@required this.latLng,@required this.addressSelected,@required this.controller}) : super(key: key);

  @override
  State<GetLocationAddressWidget> createState() => _GetLocationAddressWidgetState();
}

class _GetLocationAddressWidgetState extends State<GetLocationAddressWidget> {

  late int selectedIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedIndex=-1;

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Placemark>?>(
        future: placemarkFromCoordinates(widget.latLng?.latitude??0,widget.latLng?.longitude??0),
        builder: (context, address){
          if(address.hasData){
            var addresslist=address.data;
            return Container(
              decoration: BoxDecoration(
                  color:  Colors.grey.shade100,
                  boxShadow: [
                    BoxShadow(
                      color:Colors.grey.shade500,
                      offset: const Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    )
                  ]
              ),

              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height*0.25,
                  child: ListView.separated(
                      controller:widget.controller ,
                      separatorBuilder: (_,index)=>const Divider(indent: 20,),
                      itemCount: addresslist?.length??0,
                      itemBuilder:(_,index){
                        var a=addresslist![index];

                        var addressLine="${a.street},${a.subThoroughfare} ${a.thoroughfare} ${a.subLocality} ${a.postalCode} ${a.locality} ${a.administrativeArea} ${a.country}";

                        return ListTile(
                          leading: Radio<int>(
                            value: index,
                            groupValue: selectedIndex,
                            onChanged: (value) {
                              if(value!=null){
                                setState(() {
                                  selectedIndex= value;
                                });
                                widget.addressSelected!(addressLine);
                              }
                            },
                          ),

                          title: Text(addressLine),
                        );
                      }),
                ),
              ),
            );

          }else{
            if(address.hasError){
              return const SizedBox.shrink();
            }else{
              return const Center(child: CircularProgressIndicator(),);
            }
          }
        }
    );
  }
}



