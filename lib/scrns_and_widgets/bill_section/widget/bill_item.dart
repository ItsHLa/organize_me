import 'package:flutter/material.dart';

class MyBills extends StatelessWidget {
  const MyBills({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            RowWidget(title: 'الباركود', value: "123"),
            Divider(),
            RowWidget(title: 'العداد', value: "123"),
            Divider(),
            RowWidget(title: 'المبلغ', value: "123"),
            Row(
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
        const SizedBox(width: 60,),
        Text(value),
      ],
    );
  }
}
