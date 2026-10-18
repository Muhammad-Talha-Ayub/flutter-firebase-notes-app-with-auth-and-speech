import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/note_card.dart';
import '../widgets/note_dialog.dart';
import '../services/firestore_service.dart';
import '../main.dart'; // to access themeNotifier

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final service = FirestoreService();
  String searchQuery = '';
  String selectedCategory = 'All';

  final List<String> categoryOptions = [
    'All',
    'General',
    'Work',
    'Study',
    'Personal',
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final columns = width > 1200
        ? 4
        : width > 800
            ? 3
            : 2;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Notes"),
        actions: [
          IconButton(
            icon: Icon(themeNotifier.value == ThemeMode.light
                ? Icons.dark_mode
                : Icons.light_mode),
            onPressed: () {
              themeNotifier.value = themeNotifier.value == ThemeMode.light
                  ? ThemeMode.dark
                  : ThemeMode.light;
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async => await FirebaseAuth.instance.signOut(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showNoteDialog(context),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search notes...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) => setState(() => searchQuery = value.toLowerCase()),
            ),
          ),

          // Category filter - centered
          SizedBox(
            height: 40,
            child: Center(
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: categoryOptions.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, i) {
                  final cat = categoryOptions[i];
                  final selected = cat == selectedCategory;
                  return ChoiceChip(
                    label: Text(cat),
                    selected: selected,
                    onSelected: (_) => setState(() => selectedCategory = cat),
                    selectedColor: Colors.indigo.shade300,
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Notes Grid
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: service.notesStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No notes found"));
                }

                final filteredNotes = snapshot.data!.where((note) {
                  final matchesSearch = note['title']
                          .toString()
                          .toLowerCase()
                          .contains(searchQuery) ||
                      note['content'].toString().toLowerCase().contains(searchQuery);

                  final matchesCategory = selectedCategory == 'All' ||
                      (note['category'] ?? 'General') == selectedCategory;

                  return matchesSearch && matchesCategory;
                }).toList();

                if (filteredNotes.isEmpty) {
                  return const Center(child: Text("No notes found"));
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: filteredNotes.length,
                  itemBuilder: (_, i) => NoteCard(
                    note: filteredNotes[i],
                    onDeleted: () async {
                      await service.deleteNote(filteredNotes[i]['id']);
                      setState(() {});
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
