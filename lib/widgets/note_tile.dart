import 'package:flutter/material.dart';

class NoteTile extends StatelessWidget {
  const NoteTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
