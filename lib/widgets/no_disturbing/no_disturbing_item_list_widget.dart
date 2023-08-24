import 'package:flutter/material.dart';

import '../../models/distribute_scheduled_item_model.dart';
import 'one_no_disturbing_item_thumbnail_widget.dart';

class NoDisturbingItemsListWidget extends StatelessWidget {
  final List<ScheduledItem>?items;
  const NoDisturbingItemsListWidget({super.key,@required this.items});

  @override
  Widget build(BuildContext context) {



    return ListView(
      children: [

        ...items?.map((one)=>OneNoDisturbingItemThumbnailWidget(item: one,)).toList()??[]

      ],

    );
  }
}
