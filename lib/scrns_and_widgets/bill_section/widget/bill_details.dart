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
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              padding: EdgeInsets.zero,
              itemCount: title.length,
              itemBuilder: (context, index) {
                return ListTile(
                  trailing: Icon(icon[index]),
                  title: Text(
                    title[index],
                    textAlign: TextAlign.right,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  subtitle: Text(
                    subtitle[index],
                    textAlign: TextAlign.right,
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

/**
 *
 * Positioned(
    right: MediaQuery.of(context).devicePixelRatio,
    child: Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
    border: Border.all(color: Colors.black87),
    borderRadius: BorderRadius.circular(20)
    ),
    child: const Icon(Icons.payments_outlined
    ,color: green,
    size: 30,
    ) , ))
 *
 * */
