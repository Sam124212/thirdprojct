import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:third_project/notes%20app/Login%20help.dart';
import 'package:third_project/notes%20app/page1.dart';
import 'package:third_project/notes%20app/sighn%20up.dart';
import 'package:form_field_validator/form_field_validator.dart';

GlobalKey<FormState> key1 = GlobalKey<FormState>();
class LogIn extends StatefulWidget {

  const LogIn({super.key,});
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  void wrongEmailMassage(){
    showDialog(context: context, builder: (context) => AlertDialog(title: Text("User not found"),),);
  }
  void wrongPasswordMassage(){
    showDialog(context: context, builder: (context) => AlertDialog(title: Text("Incorrect password"),),);
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool _obscureText = true;
  bool change = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: key1,
        child: Scaffold(
          backgroundColor: Color(0xff0d282f),
          appBar: AppBar(backgroundColor: Color(0xff0d282f),automaticallyImplyLeading: false,
            title: Center(child: Text("English",style:
            TextStyle(color: Colors.white54,fontWeight: FontWeight.w400,fontSize: 15),)),
          ),
          body: SingleChildScrollView(scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(top: 170),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
                  child: TextFormField(
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Required"),
                      EmailValidator(errorText: "Not valid email"),
                    ]),
                    controller: emailController,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration:
                    InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(8)
                        ),
                        filled: true,
                        fillColor: Colors.white12,
                        hintText: "Phone number, email or username",
                        hintStyle:TextStyle(color: Colors.white38,fontSize: 14)
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,top: 15),
                  child: TextFormField(
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Password required"),
                      MinLengthValidator(6, errorText: "password must be at least 6 digits long"),
                    ]),
                    controller: passController,
                    obscureText: _obscureText,
                    style: TextStyle(color: Colors.white),cursorColor: Colors.white,
                    decoration:
                    InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8)
                      ),
                      filled: true,
                      fillColor: Colors.white12,
                      hintText: "Password",
                      hintStyle:TextStyle(color: Colors.white38,fontSize: 14),
                      suffixIcon: IconButton(
                          onPressed: (){
                        setState(() {
                          change =! change;
                          _obscureText =! _obscureText;
                        });
                      },icon: change?Icon(Icons.visibility):Icon(Icons.visibility_off),
                          color: change? Colors.blue : Colors.white38)
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    LogIn();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Container(
                      height: 60,
                      width: 320,
                      child: Center(child: Text("Log in",style:
                      TextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold),)),
                      decoration: BoxDecoration(
                          color: Color(0xfff58b54),
                          borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Forgot your login details?",style:
                      TextStyle(color: Colors.white54,
                          fontSize: 12),),
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginHelp()));
                          },
                          child: Text("Get help logging in.",style:
                          TextStyle(color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),),
                        ),
                      )
                    ],),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text('Or login with',style: TextStyle(
                    color: Colors.white54,),),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15,top: 10),
                      child: Tab(icon: Image.asset("assets/images/4.png"),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15,top: 10),
                      child: Tab(icon: Image.asset("assets/images/5.png"),),
                    ),
                  ],),
                Padding(
                  padding: const EdgeInsets.only(top: 110),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",
                        style:
                        TextStyle(color: Colors.white54,
                            fontSize: 12),),
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child:
                        GestureDetector(
                          onTap:(){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Sighnup()));
                          },
                          child: Text("Sign up.",style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                      )
                    ],
                  ),
                )
              ],),
            ),
          ),
        ),
      ),
    );
  }
  Future LogIn()async{
    if(key1.currentState!.validate()){
      try{
        showDialog(context: context, builder: (context)=>Center(child: CircularProgressIndicator()));
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text, password: passController.text);

        Navigator.of(context).pop();
        Navigator.of(context as BuildContext).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Page1(),), (route) => false);
      }
      on FirebaseAuthException catch (e){

        Navigator.of(context).pop();
        if (e.code == "user-not-found"){
        wrongEmailMassage();
      }
        else if (e.code == "incorrect-password"){
        wrongPasswordMassage();
      }}
          catch(error,stackTrace){
        print("$error,$stackTrace");
          }
    }
  }
}
