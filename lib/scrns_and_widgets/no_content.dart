import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoContent extends StatelessWidget {
  const NoContent({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
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
      ],
    );
  }
}
