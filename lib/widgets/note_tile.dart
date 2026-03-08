import 'package:flutter/material.dart';

class NoteTile extends StatelessWidget {
  final int boxColor;
  const NoteTile({super.key, required this.boxColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(boxColor),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TITLE
          const Text(
            "Screenless Design",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          // BODY
          const Text(
            "The beginning of screenless design. UI jobs to be taken over by Solution Architect. Voice interfaces and AI assistants will change the future of UI design.",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
            ),
          ),

          const Spacer(),

          // BOTTOM ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "May 21, 2020",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
              Container(
                height: 30,
                width: 30,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.edit,
                  size: 16,
                  color: Colors.white,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
