import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';

class MySearchWidget extends StatefulWidget {
  const MySearchWidget({super.key});

  @override
  State<MySearchWidget> createState() => _MySearchWidgetState();
}

class _MySearchWidgetState extends State<MySearchWidget> {
  List<String> h = ['d', 'h' , 'ha' , 'hal' , 'hala'];
  late String search ;

  @override
  Widget build(BuildContext context) {
    return EasySearchBar(

      suggestions: h,
      title: const Text('ابحث', style: TextStyle(
        fontSize: 15,
        color: Colors.black54,
      ),) ,
      showClearSearchIcon: true,
      searchBackgroundColor: Colors.grey,
      onSearch: (value) {
      setState(() {
        search = value;
      });
    },
      searchTextDirection: TextDirection.rtl,
    );

  }
}
/*
*
*
*  Expanded(child: TextField(
      onSubmitted: (value) {
        setState(() {
          search = value;
        });
      },
    ));
* */