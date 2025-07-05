import 'package:flutter/material.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(24),
      child: Center(
        child: Text(
          'Categories Management\n(Mock Content)',
          style: TextStyle(fontSize: 24, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
