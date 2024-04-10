import 'package:flutter/material.dart';

class MyDatePicker extends StatelessWidget {
  const MyDatePicker({
    super.key,
    required this.labelText,
    required this.onTap,
    required this.controller,
  });

  final String labelText;
  final void Function()? onTap;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'هذا الحقل لا يمكن ان يكون فارغ';
          }
        },
        controller: controller,
        readOnly: true,
        onTap: onTap,
        decoration: InputDecoration(
          suffixIcon: const Icon(Icons.date_range_outlined),
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.black12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.black12),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.black12),
          ),
        ),
      ),
    );
  }
}
