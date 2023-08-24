import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class AttachedDialog{
  final BuildContext? context;
  AttachedDialog.of(this.context);

  //final _boarder=const BorderSide(color: Colors.black45,style: BorderStyle.solid,width: 2);
  smallDialog(Widget child,{AlignmentGeometry aligment=Alignment.bottomLeft,Color bgColor=Colors.white,double width=300,double height=300})async{

    var box=const BoxDecoration();

    EdgeInsetsGeometry edge=EdgeInsetsGeometry.infinity;



    if(aligment==Alignment.bottomLeft){
      box=BoxDecoration(
          borderRadius: const BorderRadius.only(bottomRight:  Radius.circular(20),bottomLeft:  Radius.circular(20) ),
          color: bgColor,
          border: Border.all(color: Colors.grey.shade600),
          boxShadow:const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(
                5.0,
                5.0,
              ),
              blurRadius: 20.0,
              spreadRadius: 2.0,
            ), //BoxShadow
            BoxShadow(
              color: Colors.white,
              offset: Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ),
          ]

      );
      edge=const EdgeInsets.fromLTRB(20, 0, 20, 10);
    }else{
      box=BoxDecoration(
          borderRadius: const BorderRadius.only(bottomLeft:  Radius.circular(20),bottomRight:  Radius.circular(20) ),
          color: bgColor,
          border: Border.all(color: Colors.grey.shade400),
          boxShadow:const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(
                3.0,
                3.0,
              ),
              blurRadius: 2.0,
              spreadRadius: 2.0,

            ), //BoxShadow
            BoxShadow(
              color: Colors.white,
              offset: Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ),
          ]

      );
      edge=const EdgeInsets.fromLTRB(20, 0, 20, 10);
    }

    return await  SmartDialog.showAttach(
        targetContext: context,
        usePenetrate: true,
        alignment: aligment,
        clickMaskDismiss: true,
        maskColor: Colors.black12,

        keepSingle: true,
        builder: (_) => Container(

          width: width,
          height: height,
          //padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),

          margin: edge,
          decoration: box,

          child: child,
        )
    );
  }
  dismissAll()async{
    SmartDialog.dismiss(status: SmartStatus.allAttach);
  }


}