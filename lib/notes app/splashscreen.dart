import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:third_project/notes%20app/loginpage.dart';
import 'package:third_project/notes%20app/page1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds:4400 ),(){
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FirebaseAuth.instance.currentUser != null ? Page1(): LogIn(),));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xff0d282f),
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              width: double.infinity,
              height: 550,
              child: Align(alignment: Alignment.bottomCenter,
                  child: Lottie.asset('assets/lottie/2.json'))),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Column(
              children: [
                Text("from",style:
                TextStyle(
                    color: Colors.white38,
                    fontSize: 15
                ),),

            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: Tab(icon: Image.asset(
                    "assets/images/6.png",width: 22,)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 1),
                  child: Text(
                    "SAiM",style:
                  TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold, fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}