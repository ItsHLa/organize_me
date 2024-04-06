import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../input_text.dart';

class InputTask extends StatelessWidget {
  const InputTask({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.only(
              right: 9,
              left: 9,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: const Column(
            children: [
              SizedBox(
                height: 10,
              ),
              InputText(
                hint: 'وصف المهمة',
                maxLength: 15,
                save: null,
              ),
              SizedBox(
                height: 5,
              ),
            ],
          )),
    );
  }
}
