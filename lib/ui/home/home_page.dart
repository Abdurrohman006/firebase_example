import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_example/data/models/mind_model.dart';
import 'package:firebase_example/ui/home/all_minds_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  TextEditingController authorCont = TextEditingController();
  TextEditingController mindCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Example"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllMindsPage(),
                    ));
              },
              icon: Icon(Icons.clear_all)),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
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
      floatingActionButton: FloatingActionButton(onPressed: () async {
        //instance Firestore
        final db = FirebaseFirestore.instance;
        try {
          MindModel mind = MindModel(mind: mindCont.text.trim(), author: authorCont.text.trim());

          // yangi mind qoshilyapti va myMind ga saqlab qoyilyapti
          var myMind = await db.collection('minds').add(mind.toJson());
          // Firebase ichidagi 'minds' ichidan myMind ni id si orqali olib, docId ga id berilyapti
          db.collection("minds").doc(myMind.id).update({"docId": myMind.id});
          authorCont.clear();
          mindCont.clear();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("SIzning fikringiz qabul qilindi!")));
        } catch (e) {
          print("Sizda Xato bor:");
          print(e);
        }
        print("knopka bosildi!");
      }),
    );
  }
}
