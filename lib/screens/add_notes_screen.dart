import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticktask_flutter/models/notes_model.dart';
import 'package:ticktask_flutter/providers/database_provider.dart';

class AddNoteScreen extends ConsumerStatefulWidget {
  final Notes? note;
  const AddNoteScreen({super.key, this.note});

  @override
  ConsumerState<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends ConsumerState<AddNoteScreen> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  int selectedColor = 0xFFFFFFFF;

  @override
  void initState() {
    super.initState();

    if (widget.note != null) {
      titleController.text = widget.note!.title;
      bodyController.text = widget.note!.body ?? "";
      selectedColor = widget.note!.colorValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? "New Note" : "Edit Note"),
        backgroundColor: Color(selectedColor),
        actions: [
          IconButton(
            onPressed: () async {
              final db = ref.read(databaseProvider);

              if (titleController.text.isEmpty || bodyController.text.isEmpty) {
                return;
              }

              if (widget.note == null) {
                final note = Notes()
                  ..title = titleController.text
                  ..body = bodyController.text
                  ..createdAt = DateTime.now()
                  ..colorValue = selectedColor;

                await db.addNote(note);
              } else {
                final note = widget.note!
                  ..title = titleController.text
                  ..body = bodyController.text
                  ..colorValue = selectedColor;

                await db.updateNote(note);
              }

              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
            icon: Icon(Icons.check),
          )
        ],
      ),
      body: ColoredBox(
        color: Color(selectedColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: "Title",
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // const SizedBox(height: 10),
              Divider(
                color: Colors.black,
                thickness: 1.0,
              ),
              Expanded(
                child: TextField(
                  controller: bodyController,
                  expands: true,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: "Start writing...",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 70,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _colorItem(0xFFFFFFFF),
                    _colorItem(0xFFFFF59D),
                    _colorItem(0xFFFFAB91),
                    _colorItem(0xFFA5D6A7),
                    _colorItem(0xFF81D4FA),
                    _colorItem(0xFFCE93D8),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _colorItem(int color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Color(color),
          shape: BoxShape.circle,
          border: selectedColor == color
              ? Border.all(color: Colors.black, width: 3)
              : Border.all(color: Colors.grey, width: 3),
        ),
      ),
    );
  }
}
