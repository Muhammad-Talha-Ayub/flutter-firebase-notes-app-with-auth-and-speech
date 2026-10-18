import 'package:flutter/material.dart';
import '../widgets/note_dialog.dart';

class NoteCard extends StatelessWidget {
  final Map<String, dynamic> note;
  final VoidCallback onDeleted;

  const NoteCard({super.key, required this.note, required this.onDeleted});

  /// Returns a color based on the note category
  Color categoryColor(String category) {
    switch (category) {
      case 'Work':
        return Colors.blue.shade300;
      case 'Study':
        return Colors.green.shade300;
      case 'Personal':
        return Colors.orange.shade300;
      default:
        return Colors.grey.shade300;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cat = note['category'] ?? 'General';

    return SizedBox(
      height: 180, // Fixed height for all cards
      child: Stack(
        children: [
          InkWell(
            onTap: () => showNoteDialog(context, note: note),
            borderRadius: BorderRadius.circular(16),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Category Chip
                    Chip(
                      backgroundColor: categoryColor(cat),
                      label: Text(
                        cat,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Title
                    Text(
                      note['title'],
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    // Content
                    Expanded(
                      child: Text(
                        note['content'],
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Delete button
          Positioned(
            top: 4,
            right: 4,
            child: IconButton(
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              onPressed: onDeleted,
            ),
          ),
        ],
      ),
    );
  }
}
