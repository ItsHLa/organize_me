import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({super.key, required this.icon, required this.title, required this.logic, this.color});
  final IconData icon;
  final String title;
  final Color? color;
  final void Function() logic;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon , color: color,),
        title: Text(title),
        onTap: logic ,
      ),
    );
  }
}