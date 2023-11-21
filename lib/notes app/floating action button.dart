import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:third_project/main.dart';
import 'package:third_project/notes%20app/page1.dart';

class FloatingButton extends StatefulWidget {
  const FloatingButton({super.key});

  @override
  State<FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {

  final TextEditingController titleController = TextEditingController();
  final TextEditingController textController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  bool loading = false;
  final DatabaseReference reference = FirebaseDatabase.instance.ref("Notes");
  User? userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color(0xff0d282f),
            appBar: AppBar(
              actions: [
                TextButton(
                    onPressed: (){
                      var note = noteController.text.trim();
                      if(note.isEmpty){
                        loading ? Center(child: CircularProgressIndicator()):
                        uploadNotes();
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Page1(),));
                      }
                    },
                    child: Text("Save",
                      style: TextStyle(color: Colors.white,
                          fontSize: 16),)),
                TextButton(onPressed: (){},
                    child: Text("Undo",
                      style: TextStyle(color: Colors.white,
                          fontSize: 16
                      ),
                    )
                )
              ],
              title: Text("Create Note"),
              backgroundColor: Color(0xff0d282f),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    decoration:
                    InputDecoration(
                        hintText: "Enter title...",
                        hintStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.white38
                        )
                    ),
                  ),
                  TextFormField(
                    controller: textController,
                    keyboardType: TextInputType.multiline,
                    minLines: null,
                    maxLines: null,
                    decoration: InputDecoration(
                        hintText: "Enter text...",
                        hintStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.white38
                        )
                    ),
                    cursorColor: Colors.white,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            )
        )
    );
  }

  Future uploadNotes()async{
    if (titleController.text.isNotEmpty){
      setState(() {
        loading = true;
      });
      try{

        final key = reference.push().key;
        await reference.child(auth.currentUser!.uid).child(key!).set({
          "title":titleController.text,
          "note": textController.text,
          "time": ServerValue.timestamp,
          "noteID":key,
          "isFav":false,
        });

        setState(() {
          titleController.clear();
          textController.clear();
          loading = false;

        });
      }catch(error,stacktrace){
        setState(() {
          loading = false;
        });
        print("Error $error $stacktrace");
      }
    }
  }
}