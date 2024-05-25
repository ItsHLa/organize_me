import 'package:flutter/material.dart';

class NoContent extends StatelessWidget {
  const NoContent({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Spacer(),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.transparent),
              height: 100,
              child: Image.asset('images/no_content.png')),
          Text(
            text,
            style: const TextStyle(fontSize: 18),
          ),
          Spacer()
        ],
      ),
    );
  }
}
