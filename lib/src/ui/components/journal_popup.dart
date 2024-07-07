import "package:flutter/material.dart";

class JournalPopup extends StatefulWidget {
  const JournalPopup({super.key});

  @override
  State<JournalPopup> createState() => _JournalPopupState();
}

class _JournalPopupState extends State<JournalPopup> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void dispose() {
      _titleController.dispose();
      _contentController.dispose();
      super.dispose();
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.7,
      child: Dialog(
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                child: TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintText: 'title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  minLines: 10,
                  maxLines: null,
                  controller: _contentController,
                  decoration: const InputDecoration(
                    hintText: 'start journaling',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop({
                          'title': _titleController.text,
                          'content': _contentController.text,
                        });
                      },
                      child: const Text('add entry'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}