import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String text;

  const ProfileButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  State<ProfileButton> createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<ProfileButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          const SizedBox(width: 10,),
          Icon(widget.icon),
          SizedBox(width: 8), // Adjust spacing between icon and text as needed
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: widget.onPressed,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9 - 10,
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    widget.text,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      color: Colors.black
                    ),

                  ),
                ),
              ),
              Container(
                height: 1,
                color: Colors.grey[400], // Change color as per your design
                width: MediaQuery.of(context).size.width * 0.9 - 10 , // Adjust width of line as needed
              ),
            ],
          )
        ],
      ),
    );
  }
}
