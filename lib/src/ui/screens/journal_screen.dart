import 'package:flutter/material.dart';
import 'package:secondsight/src/ui/themes/source_colors.dart';
import 'entry_screen.dart'; 
import '../components/journal_popup.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/journal_entry.dart';
import '../../data/entries.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final List<JournalEntry> _entries = []; 

  @override
  void initState() {
    super.initState();
    _fetchNotes(); 
  }
  
  Future<void> _fetchNotes() async {
  try {
    final notes = await NoteService.getEntries(); 
    setState(() {
      _entries.addAll(notes); 
    });
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to load notes: $e')),
    );
  }
  }

  void _addEntry(Map<String, dynamic> entry) {
    setState(() {
      _entries.add(JournalEntry(
        id: entry['id'], 
        title: entry['title'], 
        content: entry['description'], 
        createdAt: entry['createdAt'], 
        updatedAt: entry['updatedAt']
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: Column(
        children: [
          const HeaderSection(),
          SortButton(onCreateEntry: _addEntry),
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
          Text(
            'time to reflect',
            style: GoogleFonts.lexend(
                textStyle: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: themePurple,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class SortButton extends StatelessWidget {
  final void Function(Map<String, dynamic>) onCreateEntry;

  const SortButton({super.key, required this.onCreateEntry});

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
                    color: themePurple,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 5.0),
                Icon(Icons.keyboard_arrow_down_rounded),
              ],
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () async {
              final newEntry = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateEntryScreen(),
                ),
              );

              if (newEntry != null) {
                onCreateEntry(newEntry);
              }
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
                  'Create',
                  style: TextStyle(
                    color: themePurple,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 5.0),
                Icon(Icons.add),
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
  final JournalEntry entry;

  const EntryCard({super.key, required this.entry});

  @override
  _EntryCardState createState() => _EntryCardState();
}

class _EntryCardState extends State<EntryCard> {
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
        onTap: () async {
          final updatedEntry = await showDialog<Map<String, String>>(
            context: context,
            builder: (BuildContext context) {
              return JournalPopup(
                initialTitle: widget.entry.title,
                initialContent: widget.entry.content,
              );
            }
          );

          if (updatedEntry != null) {
            setState(() {
              widget.entry.title = updatedEntry['title'] ?? widget.entry.title;
              widget.entry.content = updatedEntry['content'] ?? widget.entry.content;
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        decoration: const BoxDecoration(
                          color: Colors.blue, 
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        widget.entry.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4C4C4C),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
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
                        widget.entry.createdAt.toIso8601String().split('T').first,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF9E9E9E),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
