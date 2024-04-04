import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';

class MyBills extends StatelessWidget {
  const MyBills({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(4),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(20)),
                child: Icon(
                  Icons.monetization_on_outlined,
                  color: green,
                  size: 30,
                ),
              ),
              Spacer(),
              Text(
                'رقم العملية',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 10,
              ),
              RowWidget(title: 'الباركود', value: "123"),
              SizedBox(
                height: 2,
              ),
              RowWidget(title: 'العداد', value: "123"),
              SizedBox(
                height: 2,
              ),
              RowWidget(title: 'المبلغ', value: "123"),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Spacer(),
                  Text(
                    "التاريخ",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    ));
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
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const Text('  :  '),
        const SizedBox(
          width: 20,
        ),
        Text(value),
      ],
    );
  }
}
