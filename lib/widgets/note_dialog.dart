
import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

void showNoteDialog(BuildContext context, {Map<String, dynamic>? note}) {
  final titleController = TextEditingController(text: note?['title']);
  final contentController = TextEditingController(text: note?['content']);
  List<String> categoryOptions = ['General', 'Work', 'Study', 'Personal'];
  String selectedCategory = note?['category'] ?? 'General';

  final service = FirestoreService();

  showDialog(
    context: context,
    builder: (_) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: Text(note == null ? "New Note" : "Edit Note"),
        content: SizedBox(
          width: 420,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Title"),
              ),
              const SizedBox(height: 12),

              // Category Dropdown
              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: const InputDecoration(labelText: "Category"),
                items: categoryOptions
                    .map(
                      (c) => DropdownMenuItem(
                        value: c,
                        child: Text(c),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() => selectedCategory = value!);
                },
              ),

              // Add custom category
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () async {
                    final controller = TextEditingController();
                    await showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("New Category"),
                        content: TextField(
                          controller: controller,
                          decoration: const InputDecoration(labelText: "Category Name"),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel"),
                          ),
                          FilledButton(
                            onPressed: () {
                              if (controller.text.trim().isEmpty) return;
                              categoryOptions.add(controller.text.trim());
                              selectedCategory = controller.text.trim();
                              Navigator.pop(context);
                              setState(() {}); // refresh dropdown
                            },
                            child: const Text("Add"),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text("Add Custom Category"),
                ),
              ),

              const SizedBox(height: 12),

              // Content
              TextField(
                controller: contentController,
                maxLines: 5,
                decoration: const InputDecoration(labelText: "Content"),
              ),
            ],
          ),
        ),
        actions: [
          // Cancel
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),

          // Delete (only for edit)
          if (note != null)
            TextButton(
              onPressed: () async {
                await service.deleteNote(note['id']);
                Navigator.pop(context);
              },
              child: const Text(
                "Delete",
                style: TextStyle(color: Colors.red),
              ),
            ),

          // Save
          FilledButton(
            onPressed: () async {
              if (titleController.text.trim().isEmpty) return;

              await service.saveNote(
                titleController.text.trim(),
                contentController.text.trim(),
                selectedCategory,
                note?['id'],
              );

              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    ),
  );
}
