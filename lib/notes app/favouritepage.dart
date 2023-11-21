import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:third_project/main.dart';
import 'package:third_project/notes%20app/Note_.dart';

class Fav_Notes extends StatefulWidget {
  const Fav_Notes({super.key});

  @override
  State<Fav_Notes> createState() => _Fav_NotesState();
}

class _Fav_NotesState extends State<Fav_Notes> {
  bool loading = false;
  List<UserData> notes = [];

  final DatabaseReference favRef = FirebaseDatabase.instance.ref("Favourite");

  User? userId = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFavNotes();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color(0xff0d282f),
            appBar: AppBar(
              title: Text("Favourite Notes"),
              backgroundColor: Color(0xff0d282f),
            ),
            body: StreamBuilder(
                stream: getFavNotes(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.data!.isEmpty) {
                    return Center(child: Lottie.asset("assets/lottie/1.json"));
                  } else if (snapshot.hasError) {
                    print('Error ${snapshot.error}');
                    return Text('Something went wrong');
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final data = snapshot.data![index];
                        final convertedTime = DateTime.fromMillisecondsSinceEpoch(data.time);
                        return GestureDetector(
                          onTap: () async {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Notes_Page(note: data.note, title: data.title,),
                            ));
                          },
                          child: Column(
                            children: [
                              ListTile(
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        await favRef
                                            .child(auth.currentUser!.uid)
                                            .child(data.noteID)
                                            .remove();
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Color(0xfff58b54),
                                      ),
                                    ),
                                  ],
                                ),
                                title: Text(
                                  data.title,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  DateFormat("dd/MM/yy").add_jms().format(convertedTime),
                                  style: TextStyle(color: Colors.white54,fontSize: 12),
                                ),
                                leading: Image.asset(
                                  "assets/images/9.png",
                                  width: 35,
                                ),
                                tileColor: Color(0xff0d282f),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                })));
  }

  Stream<List<UserData>> getFavNotes() {
    return favRef
        .child(FirebaseAuth.instance.currentUser!.uid)
        .onValue
        .map<List<UserData>>((event) {
      List<UserData> myNotes = [];
      if (event.snapshot.exists) {
        final data = event.snapshot.value as LinkedHashMap;
        data.forEach((key, value) {
          final note = UserData.fromMap(value);
          myNotes.add(note);
        });
      }
      return myNotes;
    });
  }
}

class UserData {
  final String note;
  final String title;
  final String noteID;
  final int time;

  UserData(
      {required this.note,
      required this.title,
      required this.noteID,
      required this.time});

  factory UserData.fromMap(dynamic json) => UserData(
      note: json['note'],
      title: json['title'],
      noteID: json['noteID'],
      time: json['time']);

// Map <String,dynamic> toJson()=>{
//
//   'note':this.note,
//   'title':this.title,
//   'noteID':this.noteID,
//   'time':this.time,
// };
}
