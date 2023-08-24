import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:weekday_selector/weekday_selector.dart';

import '../../factory/no_disturbing_factory.dart';
import '../../models/distribute_scheduled_item_model.dart';

class OneNoDisturbingItemThumbnailWidget extends StatelessWidget {
  final ScheduledItem?item;
  const OneNoDisturbingItemThumbnailWidget({super.key,@required this.item});

  @override
  Widget build(BuildContext context) {
    int fromHour =int.tryParse(item?.fromTime?.substring(0,2)??"00")??0;
    int fromMin=int.tryParse(item?.fromTime?.substring(2)??"00")??0;

    int toHour=int.tryParse(item?.toTime?.substring(0,2)??"00")??0;
    int toMin=int.tryParse(item?.toTime?.substring(2)??"00")??0;

    final values = List.filled(7, false);

    for(int i=0;i<7;i++){
      if(item?.weekDays?.contains("$i")??false){
        values[i]=true;
      }
    }

    return Padding(padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        color: Colors.grey.shade100,

        child: Padding(
          padding: EdgeInsets.all(20),

          child: Slidable(

            endActionPane:  ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  // An action can be bigger than the others.
                  flex: 1,
                  onPressed: (context){
                    NoDisturbingFactory.to.delOneScheduledItem(item?.id??"");
                  },
                  backgroundColor: Theme.of(context).colorScheme.error,
                  foregroundColor: Theme.of(context).colorScheme.onError,
                  icon: Icons.delete,
                  label: 'Delete',
                ),

              ],
            ),
            child:SizedBox(
              width: double.infinity,
              child:  Column(
                children: [
                  const SizedBox(height:30,),
                  InkWell(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          const TextSpan(text: 'From    ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: '${item?.fromTime?.substring(0,2)}:${item?.fromTime?.substring(2)}',style: const TextStyle(fontSize: 22)),
                          const TextSpan(text: '   To    ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: '${item?.toTime?.substring(0,2)}:${item?.toTime?.substring(2)}',style: const TextStyle(fontSize: 22)),

                        ],
                      ),
                    ),
                      onTap: ()async{
                        TimeRange? result = await showTimeRangePicker(
                            context: context,
                            start: TimeOfDay(hour: fromHour,minute: fromMin),
                            end: TimeOfDay(hour: toHour,minute: toMin),
                            labels: [
                              "00",
                              "03",
                              "06",
                              "09",
                              "12",
                              "15",
                              "18",
                              "21"
                            ].asMap().entries.map((e) {
                              return ClockLabel.fromIndex(
                                  idx: e.key, length: 8, text: e.value);
                            }).toList()
                        );



                        if(result!=null){

                          try{
                            SmartDialog.showLoading();
                            await NoDisturbingFactory.to.putOneScheduledTime(item?.id??"", "${result.startTime.hour.toString().padLeft(2,'0')}${result.startTime.minute.toString().padLeft(2,'0')}", "${result.endTime.hour.toString().padLeft(2,'0')}${result.endTime.minute.toString().padLeft(2,'0')}");

                          }catch(e){
                            SmartDialog.showToast("$e");
                          }finally{
                            SmartDialog.dismiss(status: SmartStatus.loading);
                          }

                        }

                      }
                  ),
                  const SizedBox(height:20,),

                  WeekdaySelector(

                    values: values,
                    onChanged: (int value) async{
                      debugPrint("$value");

                      int _d=value % 7;

                      values[_d]=!values[_d];


                      //debugPrint("$values");

                     // debugPrint("*888888888888888888888888888888888888888888888888888888888***********************");
                      List<String>_s=[];

                      for(int i=0;i<7;i++){
                        if(values[i]){
                          _s.add("$i");
                        }
                      }


                      try{
                        SmartDialog.showLoading();
                        await NoDisturbingFactory.to.putOneScheduledWeekDays(item?.id??"",_s.length==0?_s.toString():_s.join(","));
                      }catch(e){
                        SmartDialog.showToast("$e");
                      }finally{
                        SmartDialog.dismiss(status: SmartStatus.loading);
                      }
                    },
                  ),
                  const SizedBox(height:30,),
                ],
              ),
            ),

          ),
        ),
      ),);
  }
}
