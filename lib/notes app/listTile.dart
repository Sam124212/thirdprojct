import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class List_Tile extends StatefulWidget {
  final String note;
  final String title;
  final String time;
  final VoidCallback onPressed;
  final VoidCallback onSave;

  const List_Tile({
    super.key,
    required this.note,
    required this.title,
    required this.onPressed,
    required this.onSave,
    required this.time,
  });

  @override
  State<List_Tile> createState() => _List_TileState();
}

class _List_TileState extends State<List_Tile> {
  final DatabaseReference reference = FirebaseDatabase.instance.ref("Notes");
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: widget.onSave,
                  // (){
                  //   setState(() {
                  //     isFav = !isFav;
                  //   });
                  // },
                  icon:Icon(isFav ? Icons.favorite : Icons.favorite_border,
                    color: Color(0xfff58b54),)),
              IconButton(
                onPressed: widget.onPressed,
                icon: Icon(
                  Icons.delete,
                  color: Color(0xfff3905d),
                ),
              ),
            ],
          ),
          subtitle: Text(
            widget.time,
            style: TextStyle(color: Colors.white54,
                fontSize: 12
            ),
          ),
          title: Text(
            widget.title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          leading: Image.asset(
            "assets/images/9.png",
            width: 35,
          ),
          tileColor: Color(0xff0d282f),
        ),
        Divider(
          height: 2,
          color: Colors.black,
        ),
      ],
    );
  }
}
