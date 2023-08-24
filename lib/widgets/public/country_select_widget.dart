import 'package:app_ios/factory/country_selection_factory.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';


class Country{
  final String?digitalCode;
  final String?countryName;

  Country({this.countryName,this.digitalCode});
}


class CountrySelect extends StatelessWidget {
  final String? initCountry;
  const CountrySelect({super.key,@required this.initCountry});

  @override
  Widget build(BuildContext context) {

    double _itemWidth=MediaQuery.of(context).size.width-200;


    final countrys=<Country>[Country(countryName: "中国",digitalCode: "+86"),

      Country(countryName: "HongKong",digitalCode: "+852"),
      Country(countryName: "Malaysia",digitalCode: "+60"),
      Country(countryName: "Australia",digitalCode: "+61"),
      Country(countryName: "UK",digitalCode: "+44"),
      Country(countryName: "United States",digitalCode: "+1")

    ];


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
      child: SizedBox(
        height: 50,

        child: Material(
          elevation: 8,
          shadowColor: Colors.black87,
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          child: DropdownButtonFormField<String>(

            decoration: const InputDecoration(
              border: InputBorder.none,

              prefixIcon: Icon(Icons.flag),
            ),

            hint: const Icon(Icons.flag),

            borderRadius: BorderRadius.circular(30),
            dropdownColor: Colors.white,

            value: initCountry,
            onChanged: (value){

              if(value!=null){
                CountrySelectionFactory.to.countryCode(value);
              }
            },
            items: countrys.map<DropdownMenuItem<String>>(

                    (one)=>DropdownMenuItem<String>(
                  value: one.digitalCode??"",
                  child:SizedBox(
                    width: _itemWidth,
                    child: AutoSizeText("${one.digitalCode} ${one.countryName}",maxLines: 1,),
                  ) ,
                )
            ).toList(),
          ),
        ),
      ),
    );
  }
}





