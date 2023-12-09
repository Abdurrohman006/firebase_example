import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_example/data/models/mind_model.dart';
import 'package:firebase_example/ui/home/widgets/mind_item.dart';
import 'package:flutter/material.dart';

class AllMindsPage extends StatelessWidget {
  const AllMindsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getAllMinds() => FirebaseFirestore.instance.collection("minds").snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text("All minds Page"),
      ),
      body: Container(
        child: StreamBuilder(
          stream: getAllMinds(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text("no data found"),
              );
            }
            if (snapshot.hasData) {
              List<MindModel> minds = snapshot.data!.docs.map((e) => MindModel.fromJson(e.data())).toList();
              return ListView.builder(
                  itemCount: minds.length, itemBuilder: (context, index) => MindItem(mind: minds[index]));
            }

            if (snapshot.hasError) {
              return Text(snapshot.hasError.toString());
            }

            return Container();
          },
        ),
      ),
    );
  }
}
