import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_example/data/models/mind_model.dart';
import 'package:flutter/material.dart';

class MindItem extends StatefulWidget {
  MindModel mind;
  MindItem({required this.mind, super.key});

  @override
  State<MindItem> createState() => _MindItemState();
}

class _MindItemState extends State<MindItem> {
  TextEditingController authorCont = TextEditingController();
  TextEditingController mindCont = TextEditingController();

  deleteMind(MindModel mind) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Siz Shu mindni o'chirmoqchimisiz: ${widget.mind.mind}"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel")),
          TextButton(
              onPressed: () {
                //Delete selected mind
                final db = FirebaseFirestore.instance;
                db.collection("minds").doc(mind.docId).delete();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Mind delete boldi")));
              },
              child: const Text(
                "Delete",
                style: TextStyle(color: Colors.red),
              )),
        ],
      ),
    );
  }

  @override
  void initState() {
    authorCont.text = widget.mind.author;
    mindCont.text = widget.mind.mind;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.mind.mind),
      subtitle: Text(widget.mind.author),
      leading: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          deleteMind(widget.mind);
        },
      ),
      trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextField(
                        controller: mindCont,
                        decoration: const InputDecoration(border: OutlineInputBorder(), label: Text("Mind")),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: authorCont,
                        decoration: const InputDecoration(border: OutlineInputBorder(), label: Text("Author")),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel")),
                  TextButton(
                      onPressed: () {
                        final db = FirebaseFirestore.instance;
                        widget.mind.mind = mindCont.text.trim();
                        widget.mind.author = authorCont.text.trim();
                        db.collection("minds").doc(widget.mind.docId).update(widget.mind.toJson());

                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Mind update boldi")));
                      },
                      child: const Text("Update")),
                ],
              ),
            );
          }),
    );
  }
}
