import 'dart:async';
import 'dart:collection';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:third_project/main.dart';
import 'package:third_project/notes%20app/Note_.dart';
import 'package:third_project/notes%20app/favouritepage.dart';
import 'package:third_project/notes%20app/floating%20action%20button.dart';
import 'package:third_project/notes%20app/listTile.dart';
import 'package:third_project/notes%20app/loginpage.dart';
import 'package:third_project/notes%20app/recyclebin.dart';
import 'package:third_project/notes%20app/setting.dart';
import 'package:third_project/notes%20app/user%20profile.dart';
class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  Icon cusIcons = Icon(Icons.search);
  Widget cusSearchBar = Text("My Notes");
  bool loading = true;
  bool change = false;
  List<UserData> notes = [];
  final DatabaseReference reference = FirebaseDatabase.instance.ref("Notes");
  final DatabaseReference _favRef = FirebaseDatabase.instance.ref("Favourite");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotes();
  }

  void _showDialogs() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(
                  color: Colors.cyanAccent,
                  width: 0.4,
                )),
            backgroundColor: Color(0xff0d282f),
            title: Text(
              "Log out",
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              "Are you sure",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              MaterialButton(
                color: Color(0xfff58b54),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              MaterialButton(
                color: Color(0xfff58b54),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => LogIn(),
                      ),
                      (route) => false);
                },
                child: Text(
                  "Yes",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xff0d282f),
          appBar: AppBar(
            backgroundColor: Color(0xff0d282f),
            title: cusSearchBar,
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      if (this.cusIcons.icon == Icons.search) {
                        this.cusIcons = Icon(Icons.cancel);
                        this.cusSearchBar = TextField(
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: "🔎︎ Search",
                              hintStyle: TextStyle(
                                color: Colors.white54,
                              )),
                        );
                      } else {
                        this.cusIcons = Icon(Icons.search);
                        this.cusSearchBar = Text("My Notes");
                      }
                    });
                  },
                  icon: cusIcons),
              PopupMenuButton(
                icon: Image.asset(
                  "assets/images/1.png",
                  color: Colors.white,
                ),
                color: Color(0xff0d282f),
                itemBuilder: (context) => [
                  PopupMenuItem(
                      child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Select",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
                  PopupMenuItem(
                      child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Select all",
                      style: TextStyle(color: Colors.white),
                    ),
                  ))
                ],
              ),
            ],
          ),
          drawer: Drawer(
              backgroundColor: Color(0xff0d282f),
              width: 280,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, bottom: 15),
                              child: Image.asset(
                                "assets/images/2.png",
                                width: 150,
                              ),
                            )
                          ],
                        ),
                        Divider(
                          color: Colors.black26,
                          height: 1,
                          thickness: 1,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Profile(),
                            ));
                          },
                          child: Container(
                            height: 50,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color: Color(0xfff58b54),
                                      size: 25,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 40),
                                      child: Text(
                                        "Profile",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xff0d282f),
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.black26,
                          height: 1,
                          thickness: 1,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RecycleBin(),
                            ));
                          },
                          child: Container(
                            height: 50,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: Color(0xfff58b54),
                                      size: 25,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 40),
                                      child: Text(
                                        "Bin",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xff0d282f),
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.black26,
                          height: 1,
                          thickness: 1,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Fav_Notes(),
                            ));
                          },
                          child: Container(
                            height: 50,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.favorite_border,
                                      color: Color(0xfff58b54),
                                      size: 25,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 40),
                                      child: Text(
                                        "Favourites",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xff0d282f),
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.black26,
                          height: 1,
                          thickness: 1,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Settings(),
                            ));
                          },
                          child: Container(
                            height: 50,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.settings,
                                      color: Color(0xfff58b54),
                                      size: 25,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 40),
                                      child: Text(
                                        "Settings",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xff0d282f),
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.black26,
                          height: 1,
                          thickness: 1,
                        ),
                        Container(
                          height: 50,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.help,
                                    color: Color(0xfff58b54),
                                    size: 25,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 40),
                                    child: Text(
                                      "Help",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xff0d282f),
                          ),
                        ),
                        Divider(
                          color: Colors.black26,
                          height: 1,
                          thickness: 1,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: GestureDetector(
                        onTap: () {
                          _showDialogs();
                        },
                        child: Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Log Out',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: Color(0xfff58b54),
                              borderRadius: BorderRadius.circular(50)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      bottomRight: Radius.circular(40)))),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FloatingButton(),
              ));
            },
            backgroundColor: Color(0xfff58b54),
            child: Icon(
              Icons.add,
              size: 35,
            ),
          ),
          body: StreamBuilder(
              stream: getNotes(),
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
                      final convertedTime =
                          DateTime.fromMillisecondsSinceEpoch(data.time);

                      return GestureDetector(
                        onTap: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                Notes_Page(note: data.note, title: data.title,),
                          ));
                        },
                        child: List_Tile(
                          note: data.note,
                          title: data.title,
                          time: DateFormat('dd/MM/yyyy')
                              .add_jms()
                              .format(convertedTime),
                          onPressed: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    backgroundColor: Color(0xff0d282f),
                                    title: Text(
                                      "Delete",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    content: Text(
                                      "Are you sure",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    actions: [
                                      MaterialButton(
                                        color: Color(0xfff58b54),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ),
                                      MaterialButton(
                                        color: Color(0xfff58b54),
                                        onPressed: () async {
                                          await reference
                                              .child(auth.currentUser!.uid)
                                              .child(data.noteID)
                                              .remove();
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Yes",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ],
                                  );
                                });
                          },
                          onSave: (){
                            if (data.isFav){
                              unSaveNotes(data.noteID);
                            }else {
                              getFavNotes(data.note, data.title, data.noteID,
                                  data.time.toString());}
                            },
                        ),
                      );
                    },
                  );
                }
              })),
    );
  }

  Future unSaveNotes(String noteID) async {
    try {
      await reference.child(noteID).update({
        "isFav":false
      });
      await _favRef.child(noteID).remove();
    } catch (error) {
      print("ERROR $error");
    }
  }

  Future getFavNotes(
      String note, String title, String noteID, String time) async {
    try {
      final key = reference.push().key;
      await _favRef.child(auth.currentUser!.uid).child(key!).set({

        "title": title,
        "note": note,
        "time": ServerValue.timestamp,
        "noteID": key,
        "isFav": false

      });
    } catch (error, stacktrace) {
      setState(() {
        loading = false;
      });
      print("Error $error $stacktrace");
    }
  }

  Stream<List<UserData>> getNotes() {
    return reference
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
  final bool isFav;

  UserData(
      {required this.note,
      required this.title,
      required this.noteID,
      required this.time,
      required this.isFav});

  factory UserData.fromMap(dynamic json) => UserData(
      note: json['note'],
      title: json['title'],
      noteID: json['noteID'],
      time: json['time'],
      isFav: json["isFav"]);
}

// Map <String,dynamic> toJson()=>{
//
//   'note':this.note,
//   'title':this.title,
//   'noteID':this.noteID,
//   'time':this.time,
// };

// Future favNotes(String note,String title,String noteID,int time)async{
//   try{
//     await _favRef.child(noteID).set({
//       "note":note,
//       "title":title,
//       "noteID":noteID,
//       "time":time
//
//
//     });
//   }catch(e){
//     print("error");
//   }
// }
