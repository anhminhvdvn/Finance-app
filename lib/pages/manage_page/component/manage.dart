// import 'package:baitaplon_mobile/pages/db_services/database.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:random_string/random_string.dart';

// import '../../../shared_widget/float_button.dart';

// class manageMent extends StatefulWidget {
//   const manageMent({super.key});

//   @override
//   State<manageMent> createState() => _HomePageState();
// }

// class _HomePageState extends State<manageMent> {
//   // ignore: non_constant_identifier_names
//   bool Personal = true, College = false, Office = false;
//   bool suggest = false;
//   TextEditingController taskController = TextEditingController();
//   Stream? taskStream;

//   getonTheLoad() async {
//     taskStream = await DatabaseService().getTask(Personal
//         ? "Personal"
//         : College
//             ? "College"
//             : "Office");
//     setState(() {});
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   Widget getWork() {
//     return StreamBuilder(
//         stream: taskStream,
//         builder: (context, AsyncSnapshot snapshot) {
//           return snapshot.hasData
//               ? Expanded(
//                   child: ListView.builder(
//                       itemCount: snapshot.data.docs.length,
//                       itemBuilder: (context, index) {
//                         DocumentSnapshot docSnap = snapshot.data.docs[index];
//                         return CheckboxListTile(
//                           activeColor: Colors.greenAccent.shade400,
//                           title: Text(docSnap["work"]),
//                           value: docSnap["Yes"],
//                           onChanged: (newValue) async {
//                             await DatabaseService().tickMethod(
//                                 docSnap["Id"],
//                                 Personal
//                                     ? "Personal"
//                                     : College
//                                         ? "College"
//                                         : "Office");
//                             setState(() {
//                               Future.delayed(const Duration(seconds: 2), () {
//                                 DatabaseService().removeMethod(
//                                     docSnap["Id"],
//                                     Personal
//                                         ? "Personal"
//                                         : College
//                                             ? "College"
//                                             : "Office");
//                               });
//                             });
//                           },
//                           controlAffinity: ListTileControlAffinity.leading,
//                         );
//                       }),
//                 )
//               : const Center(child: CircularProgressIndicator());
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatButton(),
//       // floatingActionButton: FloatingActionButton(
//       //   backgroundColor: Colors.greenAccent.shade400,
//       //   onPressed: () {
//       //     openBox();
//       //   },
//       //   child: const Icon(
//       //     Icons.add,
//       //     color: Colors.white,
//       //     size: 35,
//       //   ),
//       // ),
//       body: Container(
//         padding: const EdgeInsets.only(top: 70, left: 20),
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Colors.brown,
//               Colors.yellow,
//               Colors.green,

//               // Colors.white,
//               // Colors.white54,
//               // Colors.white,
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 10,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Personal
//                     ? Material(
//                         elevation: 5,
//                         borderRadius: BorderRadius.circular(20),
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20.0, vertical: 5.0),
//                           decoration: BoxDecoration(
//                               color: Colors.greenAccent.shade200,
//                               borderRadius: BorderRadius.circular(20)),
//                           child: const Text(
//                             "Thu nhập",
//                             style: TextStyle(
//                               fontSize: 20,
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       )
//                     : GestureDetector(
//                         onTap: () async {
//                           Personal = true;
//                           College = false;
//                           Office = false;
//                           await getonTheLoad();
//                           setState(() {});
//                         },
//                         child: const Text(
//                           "Thu nhập",
//                           style: TextStyle(
//                             fontSize: 20,
//                           ),
//                         ),
//                       ),
//                 College
//                     ? Material(
//                         elevation: 5,
//                         borderRadius: BorderRadius.circular(20),
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20.0, vertical: 5.0),
//                           decoration: BoxDecoration(
//                               color: Colors.greenAccent.shade200,
//                               borderRadius: BorderRadius.circular(20)),
//                           child: const Text(
//                             "Chi tiêu",
//                             style: TextStyle(
//                               fontSize: 20,
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       )
//                     : GestureDetector(
//                         onTap: () async {
//                           Personal = false;
//                           College = true;
//                           Office = false;
//                           await getonTheLoad();
//                           setState(() {});
//                         },
//                         child: const Text(
//                           "Chi tiêu",
//                           style: TextStyle(
//                             fontSize: 20,
//                           ),
//                         ),
//                       ),
//               ],
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             getWork(),
//           ],
//         ),
//       ),
//     );
//   }

//   // Future openBox() {
//   //   return showDialog(
//   //     context: context,
//   //     builder: (context) => AlertDialog(
//   //       content: SingleChildScrollView(
//   //         child: Column(
//   //           crossAxisAlignment: CrossAxisAlignment.start,
//   //           children: [
//   //             Row(
//   //               children: [
//   //                 GestureDetector(
//   //                   onTap: () {
//   //                     Navigator.pop(context);
//   //                   },
//   //                   child: const Icon(Icons.cancel),
//   //                 ),
//   //                 const SizedBox(
//   //                   width: 60,
//   //                 ),
//   //                 Text(
//   //                   "Add Task",
//   //                   style: TextStyle(
//   //                     color: Colors.greenAccent.shade400,
//   //                   ),
//   //                 ),
//   //               ],
//   //             ),
//   //             const SizedBox(
//   //               height: 20.0,
//   //             ),
//   //             const Text("Add Text"),
//   //             const SizedBox(
//   //               height: 20.0,
//   //             ),
//   //             Container(
//   //               padding: const EdgeInsets.symmetric(horizontal: 10.0),
//   //               decoration: BoxDecoration(
//   //                   border: Border.all(
//   //                 color: Colors.black,
//   //                 width: 2.0,
//   //               )),
//   //               child: TextField(
//   //                 controller: taskController,
//   //                 decoration: const InputDecoration(
//   //                   border: InputBorder.none,
//   //                   hintText: "Enter the task",
//   //                 ),
//   //               ),
//   //             ),
//   //             const SizedBox(
//   //               height: 20,
//   //             ),
//   //             Center(
//   //               child: Container(
//   //                 width: 100,
//   //                 padding: const EdgeInsets.all(5.0),
//   //                 decoration: BoxDecoration(
//   //                   color: Colors.greenAccent,
//   //                   borderRadius: BorderRadius.circular(10),
//   //                 ),
//   //                 child: GestureDetector(
//   //                   onTap: () {
//   //                     String id = randomAlphaNumeric(10);
//   //                     Map<String, dynamic> userTask = {
//   //                       "work": taskController.text,
//   //                       "Id": id,
//   //                       "Yes": false,
//   //                     };
//   //                     Personal
//   //                         ? DatabaseService().addPersonalTask(userTask, id)
//   //                         : College
//   //                             ? DatabaseService().addCollegeTask(userTask, id)
//   //                             : DatabaseService().addOfficeTask(userTask, id);
//   //                     Navigator.pop(context);
//   //                   },
//   //                   child: const Center(
//   //                     child: Text(
//   //                       "Add",
//   //                       style: TextStyle(
//   //                         color: Colors.black,
//   //                       ),
//   //                     ),
//   //                   ),
//   //                 ),
//   //               ),
//   //             )
//   //           ],
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }
// }
