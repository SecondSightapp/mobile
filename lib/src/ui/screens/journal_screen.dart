import 'package:flutter/material.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final List<Map<String, dynamic>> _entries = [];

  void _addEntry(Map<String, dynamic> entry) {
    setState(() {
      _entries.add(entry);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
            ),
            builder: (context) {
              return CreateEntryModal(onCreate: _addEntry);
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const HeaderSection(),
          const SortButton(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _entries.length,
              itemBuilder: (context, index) {
                return EntryCard(entry: _entries[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Column(
        children: [
          Image.asset(
            'assets/images/starHeader.png',
            width: 60,
            height: 57,
          ),
          const SizedBox(height: 10),
          const Text(
            'time to reflect',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF383073),
            ),
          ),
        ],
      ),
    );
  }
}

class SortButton extends StatelessWidget {
  const SortButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                ),
                builder: (context) {
                  return const SortOptions();
                },
              );
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              backgroundColor: Colors.white,
              shadowColor: Colors.transparent,
              side: const BorderSide(color: Color(0xFFE0E0E0), width: 1.0),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Sort by',
                  style: TextStyle(
                    color: Color(0xFF383073),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 5.0),
                Icon(Icons.keyboard_arrow_down_rounded),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SortOptions extends StatelessWidget {
  const SortOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.sort_by_alpha),
            title: const Text('Sort by Mood type'),
            onTap: () {
              // TODO: handle sort by mood
            },
          ),
          ListTile(
            leading: const Icon(Icons.bookmark),
            title: const Text('Sort by Bookmarks'),
            onTap: () {
              // TODO: handle sort by bookmarks
            },
          ),
        ],
      ),
    );
  }
}

class EntryCard extends StatefulWidget {
  final Map<String, dynamic> entry;

  const EntryCard({super.key, required this.entry});

  @override
  _EntryCardState createState() => _EntryCardState();
}

class _EntryCardState extends State<EntryCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Circle and title
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          color: widget.entry['color'],
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        widget.entry['title'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4C4C4C),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Date and save button
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.bookmark_border, color: Color(0xFF4C4C4C)),
                        onPressed: () {
                          // TODO: handle bookmark press
                        },
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        widget.entry['date'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF9E9E9E),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Show or hide description based on _isExpanded
              if (_isExpanded) 
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    widget.entry['description'],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF4C4C4C),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateEntryModal extends StatefulWidget {
  final void Function(Map<String, dynamic>) onCreate;

  const CreateEntryModal({super.key, required this.onCreate});

  @override
  State<CreateEntryModal> createState() => _CreateEntryModalState();
}

class _CreateEntryModalState extends State<CreateEntryModal> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final Color _fixedColor = Colors.blue; // Single fixed color

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty) {
                  widget.onCreate({
                    'title': _titleController.text,
                    'description': _descriptionController.text,
                    'color': _fixedColor,
                    'date': DateTime.now().toIso8601String().split('T').first,
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}

