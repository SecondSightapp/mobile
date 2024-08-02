import 'package:flutter/material.dart';

class JournalScreen extends StatefulWidget {
  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
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
          ),
          Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
  child: Row(
    children: [
      ElevatedButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
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
),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: 8, 
              itemBuilder: (context, index) {
                return EntryCard(index: index);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class EntryCard extends StatelessWidget {
  final int index;

  const EntryCard({Key? key, required this.index}) : super(key: key);

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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 15,
                  height: 15,
                  decoration: const BoxDecoration(
                    color: Colors.blue, 
                    shape: BoxShape.circle,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.bookmark_border, color: Color(0xFF4C4C4C)),
                  onPressed: () {
                    // todo: handle bookmark press
                  },
                ),
              ],
            ),
            const SizedBox(height: 4), 
            Text(
              'Entry $index',
              style: const TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.bold,
                color: Color(0xFF4C4C4C),
              ),
            ),
            const SizedBox(height: 2), 
            const Align(
              alignment: Alignment.bottomRight,
              child: Text(
                '1/13/2024',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF9E9E9E),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

