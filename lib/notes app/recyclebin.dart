import 'package:flutter/material.dart';

class RecycleBin extends StatefulWidget {
  const RecycleBin({super.key});

  @override
  State<RecycleBin> createState() => _RecycleBinState();
}

class _RecycleBinState extends State<RecycleBin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0d282f),
      appBar: AppBar(
        backgroundColor: Color(0xff0d282f),
        title: Text("Recycle Bin"),
        actions: [
          PopupMenuButton(icon: Image.asset("assets/images/1.png",color: Colors.white,),
            color: Color(0xff0d282f),
            itemBuilder: (context) => [
              PopupMenuItem(child:
              TextButton(onPressed: (){}, child:
              Text("Select",
                style: TextStyle(
                    color: Colors.white
                ),),)),
              PopupMenuItem(child:
              TextButton(onPressed: (){}, child:
              Text("Select all",
                style: TextStyle(
                    color: Colors.white
                ),),))
            ],),
        ],
      ),
    );
  }
}
