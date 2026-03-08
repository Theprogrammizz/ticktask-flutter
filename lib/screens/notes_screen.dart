import 'package:flutter/material.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          height: 200,
          width: double.infinity,
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.primary),
          child: Column(
            children: [],
          ),
        ),
        Column()
      ],
    );
  }
}
