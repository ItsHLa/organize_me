import 'package:flutter/material.dart';

class MyBills extends StatelessWidget {
  const MyBills({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 10,),
            RowWidget(title: 'الباركود', value: "123"),
            Divider(),
            RowWidget(title: 'العداد', value: "123"),
            Divider(),
            RowWidget(title: 'المبلغ', value: "123"),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('رقم العملية'),
                Spacer(),
                Text("التاريخ")
              ],
            )
          ],
        ),
      ),
    );
  }
}

class RowWidget extends StatelessWidget {
  const RowWidget({super.key, required this.title, required this.value});
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title),
        const Text('  :  '),
        const SizedBox(width: 20,),
        Text(value),
      ],
    );
  }
}
