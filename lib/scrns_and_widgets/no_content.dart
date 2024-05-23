import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoContent extends StatelessWidget {
  const NoContent({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 150,
        ),
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.transparent),
            height: 100,
            child: Image.asset('images/no_content.png')),
        Text(
          text,
          style: const TextStyle(fontSize: 18),
        )
      ],
    );
  }
}
