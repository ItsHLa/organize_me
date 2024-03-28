import 'package:flutter/material.dart';

class TotalPaymentMonth extends StatelessWidget {
  const TotalPaymentMonth({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.all(9),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(width: 80),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 8.0,
                    right: 8,
                    bottom: 5,
                  ),
                  child: Text(
                    'دفعك الكلي لهذا الشهر ',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 8.0,
                    right: 8,
                    bottom: 5,
                  ),
                  child: Text(
                    '1500',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
