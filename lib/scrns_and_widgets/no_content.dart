import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoContent extends StatelessWidget {
  const NoContent({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 150,
            child: Image.asset(
              'images/no_content.png',
              semanticLabel: 'no content',
            ),
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
