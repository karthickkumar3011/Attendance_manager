// import 'package:attendance_manger/model/user.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:month_year_picker/month_year_picker.dart';

// class CalendarScreen extends StatefulWidget {
//   const CalendarScreen({Key? key}) : super(key: key);

//   @override
//   _CalendarScreenState createState() => _CalendarScreenState();
// }

// class _CalendarScreenState extends State<CalendarScreen> {
//   double screenHeight = 0;
//   double screenWidth = 0;

//   Color primary = const Color.fromARGB(255, 103, 58, 183);

//   String _month = DateFormat('MMMM').format(DateTime.now());

//   @override
//   Widget build(BuildContext context) {
//     screenHeight = MediaQuery.of(context).size.height;
//     screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             Container(
//               alignment: Alignment.centerLeft,
//               margin: const EdgeInsets.only(top: 32),
//               child: Text(
//                 "My Attendance",
//                 style: TextStyle(
//                   fontFamily: "NexaBold",
//                   fontSize: screenWidth / 18,
//                 ),
//               ),
//             ),
//             Stack(
//               children: [
//                 Container(
//                   alignment: Alignment.centerLeft,
//                   margin: const EdgeInsets.only(top: 32),
//                   child: Text(
//                     _month,
//                     style: TextStyle(
//                       fontFamily: "NexaBold",
//                       fontSize: screenWidth / 18,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   alignment: Alignment.centerRight,
//                   margin: const EdgeInsets.only(top: 32),
//                   child: GestureDetector(
//                     onTap: () async {
//                       final month = await showMonthYearPicker(
//                           context: context,
//                           initialDate: DateTime.now(),
//                           firstDate: DateTime(2022),
//                           lastDate: DateTime(2099),
//                           builder: (context, child) {
//                             return Theme(
//                               data: Theme.of(context).copyWith(
//                                 colorScheme: ColorScheme.light(
//                                   primary: primary,
//                                   secondary: primary,
//                                   onSecondary: Colors.white,
//                                 ),
//                                 textButtonTheme: TextButtonThemeData(
//                                   style: TextButton.styleFrom(
//                                     primary: primary,
//                                   ),
//                                 ),
//                                 textTheme: const TextTheme(
//                                   headline4: TextStyle(
//                                     fontFamily: "NexaBold",
//                                   ),
//                                   overline: TextStyle(
//                                     fontFamily: "NexaBold",
//                                   ),
//                                   button: TextStyle(
//                                     fontFamily: "NexaBold",
//                                   ),
//                                 ),
//                               ),
//                               child: child!,
//                             );
//                           });

//                       if (month != null) {
//                         setState(() {
//                           _month = DateFormat('MMMM').format(month);
//                         });
//                       }
//                     },
//                     child: Text(
//                       "Pick a Month",
//                       style: TextStyle(
//                         fontFamily: "NexaBold",
//                         fontSize: screenWidth / 18,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: screenHeight / 1.45,
//               child: StreamBuilder<QuerySnapshot>(
//                 stream: FirebaseFirestore.instance
//                     .collection("Employee")
//                     .doc(User.id)
//                     .collection("Record")
//                     .snapshots(),
//                 builder: (BuildContext context,
//                     AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if (snapshot.hasData) {
//                     final snap = snapshot.data!.docs;
//                     return ListView.builder(
//                       itemCount: snap.length,
//                       itemBuilder: (context, index) {
//                         return DateFormat('MMMM')
//                                     .format(snap[index]['date'].toDate()) ==
//                                 _month
//                             ? Container(
//                                 margin: EdgeInsets.only(
//                                     top: index > 0 ? 12 : 0, left: 6, right: 6),
//                                 height: 150,
//                                 decoration: const BoxDecoration(
//                                   color: Colors.white,
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.black26,
//                                       blurRadius: 10,
//                                       offset: Offset(2, 2),
//                                     ),
//                                   ],
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(20)),
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Expanded(
//                                       child: Container(
//                                         margin: const EdgeInsets.only(),
//                                         decoration: BoxDecoration(
//                                           color: primary,
//                                           borderRadius: const BorderRadius.all(
//                                               Radius.circular(20)),
//                                         ),
//                                         child: Center(
//                                           child: Text(
//                                             DateFormat('EE\ndd').format(
//                                                 snap[index]['date'].toDate()),
//                                             style: TextStyle(
//                                               fontFamily: "NexaBold",
//                                               fontSize: screenWidth / 18,
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                             "In-Time",
//                                             style: TextStyle(
//                                               fontFamily: "NexaRegular",
//                                               fontSize: screenWidth / 20,
//                                               color: Colors.black54,
//                                             ),
//                                           ),
//                                           Text(
//                                             snap[index]['InTime'],
//                                             style: TextStyle(
//                                               fontFamily: "NexaBold",
//                                               fontSize: screenWidth / 18,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                             "Out-Time",
//                                             style: TextStyle(
//                                               fontFamily: "NexaRegular",
//                                               fontSize: screenWidth / 20,
//                                               color: Colors.black54,
//                                             ),
//                                           ),
//                                           Text(
//                                             snap[index]['OutTime'],
//                                             style: TextStyle(
//                                               fontFamily: "NexaBold",
//                                               fontSize: screenWidth / 18,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             : const SizedBox();
//                       },
//                     );
//                   } else {
//                     return const SizedBox();
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'model/user.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  String _month = DateFormat('MMMM').format(DateTime.now());
  Color primary = const Color.fromARGB(255, 103, 58, 183);

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Attendance",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36,
                color: primary,
                fontFamily: 'Montserrat', // Use a modern font
              ),
            ),
            const Divider(
              height: 20,
              thickness: 2,
              color: Colors.grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _month,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final month = await showMonthYearPicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2099),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(primary: primary),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (month != null) {
                      setState(() {
                        _month = DateFormat('MMMM').format(month);
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      "Select a Month",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              height: 20,
              thickness: 2,
              color: Colors.grey,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Employee")
                    .doc(User.id)
                    .collection("Record")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    final snap = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: snap.length,
                      itemBuilder: (context, index) {
                        return DateFormat('MMMM')
                                    .format(snap[index]['date'].toDate()) ==
                                _month
                            ? Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: primary.withOpacity(0.5),
                                        blurRadius: 10,
                                        offset: Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 70,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          color: primary,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Center(
                                          child: Text(
                                            DateFormat('EE\ndd').format(
                                              snap[index]['date'].toDate(),
                                            ),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "In-Time:",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            snap[index]['InTime'],
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            "Out-Time:",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            snap[index]['OutTime'],
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox();
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
