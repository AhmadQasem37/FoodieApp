import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const MainButton(this.text, this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 50,
      width: width - 20,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              elevation: 7,
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(30))),
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          )),
    );
  }
}
