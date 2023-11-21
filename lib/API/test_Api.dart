// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:third_project/API/RandomUser.dart';
// import 'package:http/http.dart' as http;
//
// class Random_User extends StatefulWidget {
//   const Random_User({super.key});
//
//   @override
//   State<Random_User> createState() => _Random_UserState();
// }
//
// class _Random_UserState extends State<Random_User> {
//   Future<RandomUser>? randomData;
//
//   @override
//   void initState() {
//     randomData = getData();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Testing API"),
//       ),
//       body: FutureBuilder(
//           future: randomData,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             }else if (snapshot.hasError){
//               return Text("Something went Wrong");
//             } else if (snapshot.hasData) {
//               final data = snapshot.data!;
//               return ListView.builder(
//                 itemCount: data.results.length,
//                 itemBuilder: (context, index) {
//                   final value = data.results[index];
//                   return Container(
//                     height: 400,
//                     width: 400,
//                     color: Colors.yellow,
//                     child: Column(
//                       children: [
//                         Text(value.name.title),
//                         Text(value.name.first),
//                         Text(value.name.last),
//                         Text(value.gender),
//                         Text(value.email),
//                         Text(value.cell),
//                         Text(value.phone),
//                         Text(value.location.timezone.toJson().toString()),
//                         Text(value.location.country),
//                         Text(value.id.value),
//                         Text(value.dob.age.toString()),
//                         Text(value.dob.date.toString()),
//                       ],
//                     ),
//                   );
//                 },
//               );
//             } else {
//               return Center(child: Text("No data available"));
//             }
//           }),
//     );
//   }
//
//   Future<RandomUser> getData() async {
//     final url = "https://randomuser.me/api/";
//     final response = await http.get(Uri.parse(url));
//     final jsonData = response.body;
//     final data = jsonDecode(jsonData);
//     final user = RandomUser.fromJson(data);
//     return user;
//   }
// }