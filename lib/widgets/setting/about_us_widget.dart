import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import '../../factory/time_zone_factory.dart';


class AboutUsWidget extends StatelessWidget {
  const AboutUsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureProvider<PackageInfo?>(
      create: (_)=>PackageInfo.fromPlatform(),
      initialData: null,
      catchError: (_,e){
        debugPrint(".............................................................................");

        debugPrint("${e}");
        debugPrint(".............................................................................");

        return null;
      },
      child: Consumer<PackageInfo?>(
        builder: (_,info,__){

          double height = MediaQuery.of(context).size.height;



          if(info==null){
            return Material(child: Center(child: CircularProgressIndicator(),),);
          }else{


            return Scaffold(


              appBar: AppBar(

                title: Text("About Us"),
              ),
              body: SafeArea(

                child: Column(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 30,),
                        Center(child: Image.asset("assets/images/launcher.png"),),

                        Center(child: AutoSizeText("Time concept App",style: TextStyle(fontSize: 26),),),
                        SizedBox(height: height*0.05,),
                        Center(child: AutoSizeText("Version ${info.version} + ${info.buildNumber}",style: TextStyle(fontSize: 20),),),
                        SizedBox(height: height*0.05,),
                        Center(child: AutoSizeText("Time zone: ${TimeZoneFactory.to.timeZoneName} GMT+${TimeZoneFactory.to.gmtOffset}" ,),),

                      ],
                    ),


                    Expanded(child: SizedBox.shrink()),

                    Center(
                      child: Column(
                        children: [
                          AutoSizeText("Saudi Pensioners Inc.",style: TextStyle(fontSize: 20),),

                          Text("© Copyright 2022-2023\n"),
                          Text("(852) 25723433"),
                          Text("Visit us :www.timeceptlink.com"),
                          SizedBox(height: height*0.05,)
                        ],
                      ),
                    ),
                    SizedBox(height: 30,)
                  ],

                ),
              ),


            );
          }
        },
      ),
    );
  }
}


