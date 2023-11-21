import 'package:flutter/material.dart';
class LoginHelp extends StatefulWidget {
  const LoginHelp({super.key});

  @override
  State<LoginHelp> createState() => _LoginHelpState();
}

class _LoginHelpState extends State<LoginHelp> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xff0d282f),
      appBar: AppBar(
        backgroundColor: Color(0xff0d282f),
        title:Text("Login help",
          style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold
          ),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Find your account",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text("Enter your user name or the Email",
                style: TextStyle(
                    color: Colors.white38
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text("or phone number linked to your",
                style: TextStyle(
                    color: Colors.white38
                ),
              ),
            ),
            Text("account",
              style: TextStyle(
                  color: Colors.white38
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 50),
              child: TextField(
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                    hintText: "Username,email or phone",
                    hintStyle: TextStyle(color: Colors.white38,
                        fontSize: 14),
                    filled: true,
                    fillColor: Colors.white12,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none
                    )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                child: Center(
                  child: Text("Next",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),),
                ),
                height: 55,
                width: 340,
                decoration: BoxDecoration(
                    color: Color(0xfff58b54),
                    borderRadius: BorderRadius.circular(10)
                ),),
            )
          ],
        ),
      ),
    );
  }
}
