import 'package:flutter/material.dart';

class ItemTypeWidget extends StatelessWidget {
  final Map<String, dynamic> data;

  const ItemTypeWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: .min,
        children: [
          Image.asset(
            "assets/icons/${data["image"]}.webp",
            width: 40,
            height: 40,
          ),
          SizedBox(width: 8),
          Text(data["name"]),
        ],
      ),
    );
  }
}
