import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:third_project/API/RandomUser.dart';
import 'package:third_project/API/test_Api.dart';
import 'package:flutter/material.dart';
import 'package:third_project/notes%20app/splashscreen.dart';
final auth = FirebaseAuth.instance;

void main ()async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(Myapp());
}
class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),

    );
  }
}

