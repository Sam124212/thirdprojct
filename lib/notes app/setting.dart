import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff0d282f),
        appBar: AppBar(
          backgroundColor:Color(0xff0d282f),
          title: Text("Settings"),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  height: 50,width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("Themes",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xff0d282f)
                ),),
                Divider(color: Colors.black26,height: 1,thickness: 1,),
                Container(
                  height: 50,width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text("Privacy",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Color(0xff0d282f)
                  ),),
                Divider(color: Colors.black26,height: 1,thickness: 1,),
              ],
            ),
            Container(
              decoration:BoxDecoration(
                border: Border.all(width: 1,color: Colors.black26),
              color: Color(0xff0d282f),
              ),
              child: AboutListTile(dense: true,
                  applicationName: "My Notes",
                  applicationVersion: "version 1.2.1",
                  applicationLegalese: "Legal",
                  icon: Icon(Icons.info_outline,color: Colors.white,size: 30,),
                  applicationIcon: Icon(Icons.shop,color: Colors.white,),
                  child: Text("About Notes app",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
