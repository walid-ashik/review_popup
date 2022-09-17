import 'package:flutter/material.dart';

class ReviewPopupEmojiAndText extends StatelessWidget {
  const ReviewPopupEmojiAndText({
    Key? key,
    required this.text,
    required this.color,
    required this.icon,
    this.onTap,
  }) : super(key: key);
  final String text;
  final Color color;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            size: 48,
            color: color,
          ),
          const SizedBox(height: 10),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}