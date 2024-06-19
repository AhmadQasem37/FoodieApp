import 'package:flutter/material.dart';

class ProductDetailsProperty extends StatelessWidget {
  final String title;
  final String value;
  const ProductDetailsProperty({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}
