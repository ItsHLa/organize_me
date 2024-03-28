import 'package:flutter/material.dart';

import '../../input_text.dart';

class InputEvent extends StatelessWidget {
  const InputEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child:const  Column(
          children: [
            InputText(
              hint: 'Task',

            )
          ],
        ),
      ),

    );
  }
}
