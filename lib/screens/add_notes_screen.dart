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

  int selectedColor = 0;

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
    final theme = Theme.of(context);

    final noteColor =
        selectedColor == 0 ? theme.colorScheme.surface : Color(selectedColor);

    final textColor =
        noteColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: textColor, // Changes the back button or drawer icon color
        ),
        title: Text(
          widget.note == null ? "New Note" : "Edit Note",
          style: TextStyle(color: textColor),
        ),
        backgroundColor: noteColor,
        actions: [
          IconButton(
            onPressed: () async {
              final db = ref.read(databaseProvider);

              if (titleController.text.isEmpty && bodyController.text.isEmpty) {
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
            icon: Icon(
              Icons.check,
              color: textColor,
            ),
          )
        ],
      ),
      body: ColoredBox(
        color: noteColor,
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
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: textColor),
              ),
              // const SizedBox(height: 10),
              Divider(
                color: textColor,
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
                  style: TextStyle(color: textColor),
                ),
              ),
              SizedBox(
                height: 70,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _colorItem(0xFFFFFFFF),
                    _colorItem(0xFF2C2C2E),
                    _colorItem(0xFF3A3A3C),
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
    final theme = Theme.of(context);
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
              ? Border.all(color: theme.colorScheme.primary, width: 3)
              : Border.all(color: theme.colorScheme.outline, width: 2),
        ),
      ),
    );
  }
}
