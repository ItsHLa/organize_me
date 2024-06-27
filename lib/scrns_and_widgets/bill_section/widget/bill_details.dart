import 'package:flutter/material.dart';

class BillCategoryDetail extends StatelessWidget {
  const BillCategoryDetail(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon});

  final List title;
  final List subtitle;
  final List icon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_outlined)),
              const Spacer(),
              const Text(
                'تفاصيل فاتورتك',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                width: 10,
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: title.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Card(
                    elevation: 4,
                    shape: const StadiumBorder(),
                    child: ListTile(
                      trailing: Icon(icon[index]),
                      title: Text(
                        " ${title[index]} ",
                        textAlign: TextAlign.right,
                      ),
                      subtitle: Text(
                        subtitle[index],
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
