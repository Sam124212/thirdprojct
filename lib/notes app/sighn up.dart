import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:third_project/notes%20app/loginpage.dart';
import 'package:third_project/notes%20app/user_info.dart';

GlobalKey<FormState> key2 = GlobalKey<FormState>();
GlobalKey<FlutterPwValidatorState> validatorKey = GlobalKey<FlutterPwValidatorState>();
class Sighnup extends StatefulWidget {
  const Sighnup({super.key});

  @override
  State<Sighnup> createState() => _SighnupState();
}

class _SighnupState extends State<Sighnup> {

  final  TextEditingController emailController = TextEditingController();
  final  TextEditingController passController = TextEditingController();
  final  TextEditingController repeatPassController = TextEditingController();

  bool _secureText = true;
  bool _change = false;
  bool _obsText = true;
  bool _chnge = false;
  @override
  Widget build(BuildContext context) {

    return Form(
      key: key2,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xff0d282f),
          appBar: AppBar(
            title: Center(child: Text("Sighn Up")),
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xff0d282f),
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 35),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Sign up with",style: TextStyle(color: Colors.white),
                              )],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Tab(icon: Image.asset("assets/images/4.png"),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Tab(icon: Image.asset("assets/images/5.png"),),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15,bottom: 15),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("OR",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                            ],),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10),
                          child:
                          TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Email required"),
                              EmailValidator(errorText: "Not Valid Email"),
                            ]),
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white12,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                                hintText: "Mobile Number or Email",
                                hintStyle: TextStyle(color: Colors.white38)
                            ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                          child:
                          Column(
                            children: [
                              TextFormField(
                                obscureText: _secureText,
                                controller: passController,
                                style: TextStyle(color: Colors.white),
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      onPressed: (){
                                        setState(() {
                                          _change =! _change;
                                          _secureText =! _secureText;
                                        });
                                      },
                                      icon: _change?Icon(Icons.visibility):Icon(Icons.visibility_off),
                                      color: _change? Colors.blue : Colors.white38),
                                    filled: true,
                                    fillColor: Colors.white12,
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.white38),
                                    border:OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(10),
                                    )
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
                                child: FlutterPwValidator(
                                  key: validatorKey,
                                  controller: passController,
                                  minLength: 6,
                                  uppercaseCharCount: 1,
                                  lowercaseCharCount: 1,
                                  numericCharCount: 1,
                                  normalCharCount: 1,
                                  width: 400,
                                  height: 150,
                                  onSuccess: () {
                                    print("MATCHED");
                                    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                                        content: new Text("Password is matched")));
                                  },
                                  onFail: () {
                                    print("NOT MATCHED");
                                  },),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10,bottom: 5),
                          child: TextFormField(
                            validator: (value) {
                              if (value != passController.text) {
                                return "Password does not match";
                              } else if (value == null || value.isEmpty) {
                                return "Required repeat password";
                              }
                              return null;
                            },
                            obscureText: _obsText,
                            controller: repeatPassController,
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: (){
                                    setState(() {
                                      _chnge =! _chnge;
                                      _obsText =! _obsText;
                                    });
                                  },icon: _chnge?Icon(Icons.visibility):Icon(Icons.visibility_off),
                                  color: _chnge? Colors.blue : Colors.white38),
                                filled: true,
                                fillColor: Colors.white12,
                                hintText: "Repeat Password",
                                hintStyle: TextStyle(color: Colors.white38),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none
                                )
                            ),),
                        ),
                        GestureDetector(
                          onTap: (){
                            SignUp();
                          },
                          child: Container(
                            width: 340,
                            height: 50,
                            child: Center(child: Text("Next",
                              style: TextStyle(color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),),),
                            decoration: BoxDecoration(
                                color: Color(0xfff58b54),
                                borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Have an account?",
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 12
                          ),),
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => LogIn(),));
                            },
                            child: Text(" Login",
                            style: TextStyle(
                                color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),),
                          )
                        ],
                      ),
                    ),
                  ]
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future SignUp()async{
    if(key2.currentState!.validate()){
      try {
        showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator(color: Colors.blue,)),);
        final user =await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passController.text);

        await FirebaseDatabase.instance.ref("Users").child(user.user!.uid).set({
          "email":emailController.text,
          "password":passController.text,
        });
        Navigator.of(context).pop();
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => UserForm(),), (route) => false);
      }
      catch(error,stackTrace){
        print("$error,$stackTrace");
      }
    }
  }
}