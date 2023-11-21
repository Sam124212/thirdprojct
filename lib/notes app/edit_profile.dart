import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ProfilePage extends StatefulWidget {

  final String imageLink;
  final String firstName;
   final String lastName;
   final String gender;

  const ProfilePage({super.key, required this.imageLink, required this.firstName, required this.lastName, required this.gender});

@override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
  children: [
    Align(heightFactor: 1.4,
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Image.network(widget.imageLink,),
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle
        ),
      ),
    ),
    Row(
      children: [
        Text(widget.firstName,
          style:
        TextStyle(
            color: Colors.white,
            fontSize: 20
        ),),
        Text(widget.lastName,
          style:
          TextStyle(
              color: Colors.white,
              fontSize: 20
          ),),
      ],
    ),
    Row(
      children: [
        Text(widget.gender,
          style:
          TextStyle(
              color: Colors.white,
              fontSize: 20
          ),
        ),
      ],
    )
  ],
),
    );
  }
}
