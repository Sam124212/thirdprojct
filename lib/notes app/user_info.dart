import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:third_project/Image/1.dart';
import 'package:third_project/Image/2.dart';
import 'package:third_project/main.dart';
import 'package:third_project/notes%20app/page1.dart';
import 'package:third_project/notes%20app/sighn%20up.dart';
import 'package:flutter/material.dart';

GlobalKey<FormState> key3 = GlobalKey<FormState>();

class UserForm extends StatefulWidget {

  UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {

  TextEditingController name_controller = TextEditingController();
  TextEditingController lastName_Controller = TextEditingController();
  TextEditingController userName_Controller = TextEditingController();
  TextEditingController gender_Controller = TextEditingController();
  TextEditingController mobileNum_Controller = TextEditingController();

  final ImagePicker = MyImagePicker();
  File? pickImage;
  final uploaderService = UploaderService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: key3,
        child: Scaffold(
          backgroundColor:Color(0xff0d282f),
          appBar: AppBar(
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Page1(),));
                  }, child: Text("Skip",style: TextStyle(color: Color(0xfff58b54)),))
            ],
           leading: GestureDetector(
             onTap: (){
               Navigator.of(context).push(MaterialPageRoute(builder: (context) => Sighnup(),));
             },
               child: Icon(Icons.arrow_back)),
            title: Text("Basic info"),
            backgroundColor: Color(0xff0d282f),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                        children: [
                      GestureDetector(
                        onTap: ()async{
                          final file = await ImagePicker.pickImage();
                          if(file != null){
                            setState(() {
                              pickImage = file;
                            });
                          }
                        },
                        child: Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            child: pickImage!=null? Image.file(pickImage!):
                            Column(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              Icon(Icons.upload,),
                              Text("Upload Image",style: TextStyle(fontSize: 14),)
                            ],),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 2,
                        right: 5,
                        child: Container(
                          width: 25,
                          height: 25,
                          child: Icon(Icons.person,color: Colors.white,),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                            shape: BoxShape.circle
                          ),
                        ),
                      )
                    ]),
                  ),

          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
            child: TextFormField(
              validator: RequiredValidator(errorText: "First name Required"),
              style: TextStyle(
                  color: Colors.white
              ),
              cursorColor: Colors.white,
              controller: name_controller,
              decoration: InputDecoration(
                hintText: "First name",
                filled: true,
                fillColor: Colors.white12,
                hintStyle: GoogleFonts.inter(
                    color: Colors.white38,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
          ),Padding(
            padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
            child: TextFormField(
              validator: RequiredValidator(errorText: "Last name Required"),
              style: TextStyle(
                  color: Colors.white
              ),
              cursorColor: Colors.white,
              controller: lastName_Controller,
              decoration: InputDecoration(
                hintText: "Last name",
                filled: true,
                fillColor: Colors.white12,
                hintStyle: GoogleFonts.inter(
                    color: Colors.white38,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
          ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
                    child:
                    TextFormField(
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Username required"),
                      ]),
                      controller: userName_Controller,
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white12,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none),
                          hintText: "Username",
                          hintStyle: TextStyle(color: Colors.white38)
                      ),),
                  ),
                  Padding(
            padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
            child: TextFormField(
              validator: RequiredValidator(errorText: "Gender Required"),
              style: TextStyle(
                  color: Colors.white
              ),
              cursorColor: Colors.white,
              controller: gender_Controller,
              decoration: InputDecoration(
                hintText: "Your gender",
                filled: true,
                fillColor: Colors.white12,
                hintStyle: GoogleFonts.inter(
                    color: Colors.white38,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
          ),

                  Padding(
                    padding: const EdgeInsets.only(left: 10,top: 5),
                    child: Text("Optional",style: TextStyle(color: Colors.white),),
                  ),
        Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
          child: TextFormField(
            keyboardType: TextInputType.phone,
            style: TextStyle(
                color: Colors.white
            ),
            cursorColor: Colors.white,
            controller: mobileNum_Controller,
            decoration: InputDecoration(
              hintText: "Mobile Number",
              filled: true,
              fillColor: Colors.white12,
              hintStyle: GoogleFonts.inter(
                  color: Colors.white38,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
        ),


                  Center(
                    child: GestureDetector(
                      onTap: (){
                        UpdateData();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          child: Center(child: Text("Submit",
                            style: TextStyle(color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),),),
                          decoration: BoxDecoration(
                              color: Color(0xfff58b54),
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future UpdateData()async{
    if(key3.currentState!.validate()){
      try {
        final result = await uploaderService.uploadFile(pickImage!, "pic");
        showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator(color: Colors.blue,)),);

        await FirebaseDatabase.instance.ref("Users").child(auth.currentUser!.uid).update({
          "Firstname":name_controller.text,
          "Lastname":lastName_Controller.text,
          "Username":userName_Controller.text,
          "Gender":gender_Controller.text,
          "Mobilenumber":mobileNum_Controller.text,
          "imageLink": result.downloadLink,

        });
        Navigator.of(context).pop();
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Page1(),), (route) => false);
      }
      catch(error,stackTrace){
        print("$error,$stackTrace");
      }
    }
  }
}