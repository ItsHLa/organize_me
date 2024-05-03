import 'package:flutter/material.dart';

import 'widget/input.dart';

class AddNoteScrn extends StatelessWidget {
  const AddNoteScrn({super.key});

  @override
  Widget build(BuildContext context) {
    return const Input(
      title: 'عنوان الملاحظة ',
      content: 'الوصف',
      action: 'اضافة الملاحظة',
      icon: Icons.add_circle_outline,
    );
  }
}
