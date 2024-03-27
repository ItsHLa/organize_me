import '../../constants.dart';
import 'package:flutter/material.dart';

class MyHeader extends StatelessWidget {
  const MyHeader({super.key, required this.date});
  final DateTime date ;

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.all(8) ,
      padding: const EdgeInsets.all(8),
        decoration:  BoxDecoration(
            color: indigo,
          borderRadius: BorderRadius.circular(5)
        ),
        alignment: Alignment.center,
        child:Text('${whichMonth(date.month)} - ${date.year.toString()}'));
  }

  String whichMonth (int month){
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9 :
        return 'Sep';
      case 10:
        return 'Oct' ;
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }

}