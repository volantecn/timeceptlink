import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../models/contact_item_model.dart';
import 'one_contact_thumbnail.dart';

class ContactContentWidget extends StatelessWidget {
  final List<ContactThumbnail>?contacts;
  const ContactContentWidget({super.key,@required this.contacts});

  @override
  Widget build(BuildContext context) {





    return GroupedListView<ContactThumbnail, String>(

      elements: contacts!,
      groupBy: (contact) => contact.groupId??"",

      itemBuilder: (context, ContactThumbnail contact) =>OneContactThumbnailWidget(contact: contact,), //,
      itemComparator: (item1, item2) => item1.desc?.compareTo(item2.desc??"")??0, // optional
      useStickyGroupSeparators: true, // optional
      floatingHeader: true, // optional
      order: GroupedListOrder.ASC, // optional

      groupSeparatorBuilder: (String value) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
