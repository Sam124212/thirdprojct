import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final DatabaseReference reference = FirebaseDatabase.instance.ref("Users");
  UserData? profile;
  bool loading = false;
  List<UserData> _data = [];

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0d282f),
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.mode_edit_outline))
        ],
        backgroundColor: Color(0xff0d282f),
        title: Text("Profile"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                Center(
                  child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        // color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                      child: profile != null
                          ? CachedNetworkImage(
                              imageUrl: profile!.imageLink,
                              fit: BoxFit.cover,
                            )
                          : Icon(Icons.person)),
                ),
                Divider(
                  height: 8,
                ),
                Text(
                  profile?.Username ?? "Dummy",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Divider(
                  height: 30,
                ),
                Row(
                  children: [
                    Text(
                      "Basic info",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 20, top: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black26,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "First name :",
                                style: TextStyle(
                                  color: Colors.white54,
                                ),
                              ),
                              Divider(height: 4),
                              Text(
                                profile?.Firstname ?? "Dummy",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  color: Color(0xffFFFFFF),
                                ),
                              ),
                              Divider(height: 15),
                              Text(
                                "Last name :",
                                style: TextStyle(
                                  color: Colors.white54,
                                ),
                              ),
                              Divider(height: 4),
                              Text(
                                profile?.Lastname ?? "Dummy",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  color: Color(0xffFFFFFF),
                                ),
                              ),
                              Divider(height: 15),
                              Text(
                                "Gender :",
                                style: TextStyle(
                                  color: Colors.white54,
                                ),
                              ),
                              Divider(height: 4),
                              Text(
                                profile?.Gender ?? "Dummy",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  color: Color(0xffFFFFFF),
                                ),
                              ),
                              Divider(height: 15),
                              Text(
                                "Email Address :",
                                style: TextStyle(
                                  color: Colors.white54,
                                ),
                              ),
                              Divider(height: 4),
                              Text(
                                profile?.email ?? "Dummy",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  color: Color(0xffFFFFFF),
                                ),
                              ),
                              Divider(height: 15),
                              Text(
                                "Mobile Number :",
                                style: TextStyle(
                                  color: Colors.white54,
                                ),
                              ),
                              Divider(height: 5),
                              Text(
                                profile?.Mobilenumber ?? "Dummy",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  color: Color(0xffFFFFFF),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future getUserData() async {
    try {
      final data = await FirebaseDatabase.instance
          .ref("Users")
          .child(FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (data.exists) {
        print("data :: ${data.value}");
        final userData = data.value as LinkedHashMap;
        final user = UserData.fromJson(userData);
        print("user: ${user}");
        setState(() {
          profile = user;
        });
      }
    } catch (e, stacktrace) {}
  }
}

class UserData {
  final String Firstname;
  final String Lastname;
  final String Username;
  final String Gender;
  final String email;
  final String Mobilenumber;
  final String imageLink;

  UserData(
      {required this.Firstname,
      required this.Lastname,
      required this.Username,
      required this.Gender,
      required this.email,
      required this.Mobilenumber,
      required this.imageLink});

  factory UserData.fromJson(dynamic json) => UserData(
        Firstname: json["Firstname"],
        Lastname: json["Lastname"],
        Username: json["Username"],
        Gender: json["Gender"],
        email: json["email"],
        Mobilenumber: json["Mobilenumber"],
        imageLink: json["imageLink"],
      );
}

//  Map <String,dynamic> toJson()=>{
//    'firstName': this.firstName,
//    'lastName':this.lastName,
//    'gender':this.gender,
//    // 'mobileNumber':this.mobileNumber,
//    'imageLink':this.image,
// };
