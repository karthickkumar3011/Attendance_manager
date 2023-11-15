// import 'dart:async';
// import 'package:attendance_manger/model/user.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:intl/intl.dart';
// import 'package:slide_to_act/slide_to_act.dart';

// class TodayScreen extends StatefulWidget {
//   const TodayScreen({Key? key}) : super(key: key);

//   @override
//   _TodayScreenState createState() => _TodayScreenState();
// }

// class _TodayScreenState extends State<TodayScreen> {
//   double screenHeight = 0;
//   double screenWidth = 0;

//   String checkIn = "--/--";
//   String checkOut = "--/--";
//   String location = " ";
//   String scanResult = " ";
//   String officeCode = " ";

//   Color primary = Color.fromARGB(251, 49, 133, 196);

//   @override
//   void initState() {
//     super.initState();
//     _getRecord();
//   }

//   Future<void> scanQRandCheck() async {
//     String result = " ";

//     try {
//       result = await FlutterBarcodeScanner.scanBarcode(
//         "#ffffff",
//         "Cancel",
//         false,
//         ScanMode.QR,
//       );
//     } catch (e) {
//       print("error");
//     }

//     setState(() {
//       scanResult = result;
//     });

//     if (scanResult == officeCode) {
//       if (User.lat != 0) {
//         _getLocation();

//         QuerySnapshot snap = await FirebaseFirestore.instance
//             .collection("Employee")
//             .where('id', isEqualTo: User.employeeId)
//             .get();

//         DocumentSnapshot snap2 = await FirebaseFirestore.instance
//             .collection("Employee")
//             .doc(snap.docs[0].id)
//             .collection("Record")
//             .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
//             .get();

//         try {
//           String checkIn = snap2['checkIn'];

//           setState(() {
//             checkOut = DateFormat('hh:mm').format(DateTime.now());
//           });

//           await FirebaseFirestore.instance
//               .collection("Employee")
//               .doc(snap.docs[0].id)
//               .collection("Record")
//               .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
//               .update({
//             'date': Timestamp.now(),
//             'checkIn': checkIn,
//             'checkOut': DateFormat('hh:mm').format(DateTime.now()),
//             'checkInLocation': location,
//           });
//         } catch (e) {
//           setState(() {
//             checkIn = DateFormat('hh:mm').format(DateTime.now());
//           });

//           await FirebaseFirestore.instance
//               .collection("Employee")
//               .doc(snap.docs[0].id)
//               .collection("Record")
//               .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
//               .set({
//             'date': Timestamp.now(),
//             'checkIn': DateFormat('hh:mm').format(DateTime.now()),
//             'checkOut': "--/--",
//             'checkOutLocation': location,
//           });
//         }
//       } else {
//         Timer(const Duration(seconds: 3), () async {
//           _getLocation();

//           QuerySnapshot snap = await FirebaseFirestore.instance
//               .collection("Employee")
//               .where('id', isEqualTo: User.employeeId)
//               .get();

//           DocumentSnapshot snap2 = await FirebaseFirestore.instance
//               .collection("Employee")
//               .doc(snap.docs[0].id)
//               .collection("Record")
//               .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
//               .get();

//           try {
//             String checkIn = snap2['checkIn'];

//             setState(() {
//               checkOut = DateFormat('hh:mm').format(DateTime.now());
//             });

//             await FirebaseFirestore.instance
//                 .collection("Employee")
//                 .doc(snap.docs[0].id)
//                 .collection("Record")
//                 .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
//                 .update({
//               'date': Timestamp.now(),
//               'checkIn': checkIn,
//               'checkOut': DateFormat('hh:mm').format(DateTime.now()),
//               'checkInLocation': location,
//             });
//           } catch (e) {
//             setState(() {
//               checkIn = DateFormat('hh:mm').format(DateTime.now());
//             });

//             await FirebaseFirestore.instance
//                 .collection("Employee")
//                 .doc(snap.docs[0].id)
//                 .collection("Record")
//                 .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
//                 .set({
//               'date': Timestamp.now(),
//               'checkIn': DateFormat('hh:mm').format(DateTime.now()),
//               'checkOut': "--/--",
//               'checkOutLocation': location,
//             });
//           }
//         });
//       }
//     }
//   }

//   void _getLocation() async {
//     List<Placemark> placemark =
//         await placemarkFromCoordinates(User.lat, User.long);

//     setState(() {
//       location =
//           "${placemark[0].street}, ${placemark[0].administrativeArea}, ${placemark[0].postalCode}, ${placemark[0].country}";
//     });
//   }

//   void _getRecord() async {
//     try {
//       QuerySnapshot snap = await FirebaseFirestore.instance
//           .collection("Employee")
//           .where('id', isEqualTo: User.employeeId)
//           .get();

//       DocumentSnapshot snap2 = await FirebaseFirestore.instance
//           .collection("Employee")
//           .doc(snap.docs[0].id)
//           .collection("Record")
//           .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
//           .get();

//       setState(() {
//         checkIn = snap2['checkIn'];
//         checkOut = snap2['checkOut'];
//       });
//     } catch (e) {
//       setState(() {
//         checkIn = "--/--";
//         checkOut = "--/--";
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     screenHeight = MediaQuery.of(context).size.height;
//     screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//         body: SingleChildScrollView(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         children: [
//           Container(
//             alignment: Alignment.centerLeft,
//             margin: const EdgeInsets.only(top: 32),
//             child: Text(
//               "Welcome,",
//               style: TextStyle(
//                 color: Colors.black54,
//                 fontFamily: "NexaRegular",
//                 fontSize: screenWidth / 20,
//               ),
//             ),
//           ),
//           Container(
//             alignment: Alignment.centerLeft,
//             child: Text(
//               "Employee " + User.employeeId,
//               style: TextStyle(
//                 fontFamily: "NexaBold",
//                 fontSize: screenWidth / 18,
//               ),
//             ),
//           ),
//           Container(
//             alignment: Alignment.centerLeft,
//             margin: const EdgeInsets.only(top: 32),
//             child: Text(
//               "Today's Status",
//               style: TextStyle(
//                 fontFamily: "NexaBold",
//                 fontSize: screenWidth / 18,
//               ),
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(top: 12, bottom: 32),
//             height: 150,
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black26,
//                   blurRadius: 10,
//                   offset: Offset(2, 2),
//                 ),
//               ],
//               borderRadius: BorderRadius.all(Radius.circular(20)),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Check In",
//                         style: TextStyle(
//                           fontFamily: "NexaRegular",
//                           fontSize: screenWidth / 20,
//                           color: Colors.black54,
//                         ),
//                       ),
//                       Text(
//                         checkIn,
//                         style: TextStyle(
//                           fontFamily: "NexaBold",
//                           fontSize: screenWidth / 18,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Check Out",
//                         style: TextStyle(
//                           fontFamily: "NexaRegular",
//                           fontSize: screenWidth / 20,
//                           color: Colors.black54,
//                         ),
//                       ),
//                       Text(
//                         checkOut,
//                         style: TextStyle(
//                           fontFamily: "NexaBold",
//                           fontSize: screenWidth / 18,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//               alignment: Alignment.centerLeft,
//               child: RichText(
//                 text: TextSpan(
//                   text: DateTime.now().day.toString(),
//                   style: TextStyle(
//                     color: primary,
//                     fontSize: screenWidth / 18,
//                     fontFamily: "NexaBold",
//                   ),
//                   children: [
//                     TextSpan(
//                       text: DateFormat(' MMMM yyyy').format(DateTime.now()),
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: screenWidth / 20,
//                         fontFamily: "NexaBold",
//                       ),
//                     ),
//                   ],
//                 ),
//               )),
//           StreamBuilder(
//             stream: Stream.periodic(const Duration(seconds: 1)),
//             builder: (context, snapshot) {
//               return Container(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   DateFormat('hh:mm:ss a').format(DateTime.now()),
//                   style: TextStyle(
//                     fontFamily: "NexaRegular",
//                     fontSize: screenWidth / 20,
//                     color: Colors.black54,
//                   ),
//                 ),
//               );
//             },
//           ),
//           checkOut == "--/--"
//               ? Container(
//                   margin: const EdgeInsets.only(top: 24, bottom: 12),
//                   child: Builder(
//                     builder: (context) {
//                       final GlobalKey<SlideActionState> key = GlobalKey();

//                       return SlideAction(
//                         text: checkIn == "--/--"
//                             ? "Slide to Check In"
//                             : "Slide to Check Out",
//                         textStyle: TextStyle(
//                           color: Colors.black54,
//                           fontSize: screenWidth / 20,
//                           fontFamily: "NexaRegular",
//                         ),
//                         outerColor: Colors.white,
//                         innerColor: primary,
//                         key: key,
//                         onSubmit: () async {
//                           if (User.lat != 0) {
//                             _getLocation();

//                             QuerySnapshot snap = await FirebaseFirestore
//                                 .instance
//                                 .collection("Employee")
//                                 .where('id', isEqualTo: User.employeeId)
//                                 .get();

//                             DocumentSnapshot snap2 = await FirebaseFirestore
//                                 .instance
//                                 .collection("Employee")
//                                 .doc(snap.docs[0].id)
//                                 .collection("Record")
//                                 .doc(DateFormat('dd MMMM yyyy')
//                                     .format(DateTime.now()))
//                                 .get();

//                             try {
//                               String checkIn = snap2['checkIn'];

//                               setState(() {
//                                 checkOut =
//                                     DateFormat('hh:mm').format(DateTime.now());
//                               });

//                               await FirebaseFirestore.instance
//                                   .collection("Employee")
//                                   .doc(snap.docs[0].id)
//                                   .collection("Record")
//                                   .doc(DateFormat('dd MMMM yyyy')
//                                       .format(DateTime.now()))
//                                   .update({
//                                 'date': Timestamp.now(),
//                                 'checkIn': checkIn,
//                                 'checkOut':
//                                     DateFormat('hh:mm').format(DateTime.now()),
//                                 'checkInLocation': location,
//                               });
//                             } catch (e) {
//                               setState(() {
//                                 checkIn =
//                                     DateFormat('hh:mm').format(DateTime.now());
//                               });

//                               await FirebaseFirestore.instance
//                                   .collection("Employee")
//                                   .doc(snap.docs[0].id)
//                                   .collection("Record")
//                                   .doc(DateFormat('dd MMMM yyyy')
//                                       .format(DateTime.now()))
//                                   .set({
//                                 'date': Timestamp.now(),
//                                 'checkIn':
//                                     DateFormat('hh:mm').format(DateTime.now()),
//                                 'checkOut': "--/--",
//                                 'checkOutLocation': location,
//                               });
//                             }

//                             key.currentState!.reset();
//                           } else {
//                             Timer(const Duration(seconds: 3), () async {
//                               _getLocation();

//                               QuerySnapshot snap = await FirebaseFirestore
//                                   .instance
//                                   .collection("Employee")
//                                   .where('id', isEqualTo: User.employeeId)
//                                   .get();

//                               DocumentSnapshot snap2 = await FirebaseFirestore
//                                   .instance
//                                   .collection("Employee")
//                                   .doc(snap.docs[0].id)
//                                   .collection("Record")
//                                   .doc(DateFormat('dd MMMM yyyy')
//                                       .format(DateTime.now()))
//                                   .get();

//                               try {
//                                 String checkIn = snap2['checkIn'];

//                                 setState(() {
//                                   checkOut = DateFormat('hh:mm')
//                                       .format(DateTime.now());
//                                 });

//                                 await FirebaseFirestore.instance
//                                     .collection("Employee")
//                                     .doc(snap.docs[0].id)
//                                     .collection("Record")
//                                     .doc(DateFormat('dd MMMM yyyy')
//                                         .format(DateTime.now()))
//                                     .update({
//                                   'date': Timestamp.now(),
//                                   'checkIn': checkIn,
//                                   'checkOut': DateFormat('hh:mm')
//                                       .format(DateTime.now()),
//                                   'checkInLocation': location,
//                                 });
//                               } catch (e) {
//                                 setState(() {
//                                   checkIn = DateFormat('hh:mm')
//                                       .format(DateTime.now());
//                                 });

//                                 await FirebaseFirestore.instance
//                                     .collection("Employee")
//                                     .doc(snap.docs[0].id)
//                                     .collection("Record")
//                                     .doc(DateFormat('dd MMMM yyyy')
//                                         .format(DateTime.now()))
//                                     .set({
//                                   'date': Timestamp.now(),
//                                   'checkIn': DateFormat('hh:mm')
//                                       .format(DateTime.now()),
//                                   'checkOut': "--/--",
//                                   'checkOutLocation': location,
//                                 });
//                               }

//                               key.currentState!.reset();
//                             });
//                           }
//                         },
//                       );
//                     },
//                   ),
//                 )
//               : Container(
//                   margin: const EdgeInsets.only(top: 32, bottom: 32),
//                   child: Text(
//                     "You have completed this day!",
//                     style: TextStyle(
//                       fontFamily: "NexaRegular",
//                       fontSize: screenWidth / 20,
//                       color: Colors.black54,
//                     ),
//                   ),
//                 ),
//           location != " "
//               ? Text(
//                   "Location: " + location,
//                 )
//               : const SizedBox(),
//         ],
//       ),
//     ));
//   }
// }

import 'dart:async';

import 'package:attendance_manger/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({Key? key}) : super(key: key);

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  String inTime = "--/--";
  String outTime = "--/--";
  String location = " ";
  Color primaryColor = const Color.fromARGB(255, 103, 58, 183);

  @override
  void initState() {
    super.initState();
    _getRecord();
  }

  void _getLocation() async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(User.lat, User.long);
    setState(() {
      location =
          "${placemark[0].street},${placemark[0].administrativeArea},${placemark[0].postalCode},${placemark[0].country}";
    });
  }

  void _getRecord() async {
    try {
      QuerySnapshot employeeSnapshot = await FirebaseFirestore.instance
          .collection("Employee")
          .where('id', isEqualTo: User.employeeId)
          .get();

      DocumentSnapshot recordSnapshot = await FirebaseFirestore.instance
          .collection("Employee")
          .doc(employeeSnapshot.docs[0].id)
          .collection("Record")
          .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
          .get();

      setState(() {
        inTime = recordSnapshot['InTime'];
        outTime = recordSnapshot['OutTime'];
      });
    } catch (e) {
      setState(() {
        inTime = "--/--";
        outTime = "--/--";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDateSection(),
            _buildClockSection(),
            _buildEmployeeTitle(),
            _buildStatusHeader(),
            _buildStatusText(),
            _buildStatusContainer(),
            _buildActionButton(),
            _buildLocationInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          DateFormat('dd').format(DateTime.now()),
          style: TextStyle(
            color: primaryColor,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              DateFormat('MMMM yyyy').format(DateTime.now()),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            Text(
              DateFormat('EEEE').format(DateTime.now()),
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildClockSection() {
    String currentTime = DateFormat('hh:mm:ss a').format(DateTime.now());

    // Update the time every second using a Timer
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        currentTime = DateFormat('hh:mm:ss a').format(DateTime.now());
      });
    });

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        currentTime,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget _buildEmployeeTitle() {
    return Text(
      "Employee " + User.employeeId,
      style: TextStyle(
        color: Colors.black87,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildStatusHeader() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Text(
        "Today's Status",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildStatusText() {
    return Padding(
      padding: EdgeInsets.only(top: 12),
      child: inTime != "--/--"
          ? Text(
              "Present",
              style: TextStyle(
                fontSize: 20,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            )
          : Text(
              "Absent",
              style: TextStyle(
                fontSize: 20,
                color: const Color.fromARGB(255, 175, 76, 76),
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }

  Widget _buildStatusContainer() {
    return Container(
      margin: EdgeInsets.only(top: 12, bottom: 28),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.5),
            blurRadius: 10,
            offset: Offset(2, 2),
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTimeColumn("In-Time:", inTime),
          _buildTimeColumn("Out-Time:", outTime),
        ],
      ),
    );
  }

  Widget _buildTimeColumn(String label, String time) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: 8),
        Text(
          time,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton() {
    return outTime == "--/--"
        ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.5),
                  blurRadius: 10,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () async {
                _handleActionButtonClick();
              },
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  inTime == "--/--"
                      ? "Tap to set In-Time"
                      : "Tap to set Out-Time",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          )
        : Container(
            child: Text(
              "You have registered today!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          );
  }

  void _handleActionButtonClick() async {
    if (User.lat != 0) {
      _getLocation();

      QuerySnapshot employeeSnapshot = await FirebaseFirestore.instance
          .collection("Employee")
          .where('id', isEqualTo: User.employeeId)
          .get();

      DocumentSnapshot recordSnapshot = await FirebaseFirestore.instance
          .collection("Employee")
          .doc(employeeSnapshot.docs[0].id)
          .collection("Record")
          .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
          .get();

      try {
        String inTime = recordSnapshot['InTime'];
        setState(() {
          outTime = DateFormat('hh:mm a').format(DateTime.now());
        });

        await FirebaseFirestore.instance
            .collection("Employee")
            .doc(employeeSnapshot.docs[0].id)
            .collection("Record")
            .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
            .update({
          'date': Timestamp.now(),
          'InTime': inTime,
          'OutTime': DateFormat('hh:mm a').format(DateTime.now()),
          'OutTimeLocation': location,
        });
      } catch (e) {
        setState(() {
          inTime = DateFormat('hh:mm a').format(DateTime.now());
        });
        await FirebaseFirestore.instance
            .collection("Employee")
            .doc(employeeSnapshot.docs[0].id)
            .collection("Record")
            .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
            .set({
          'date': Timestamp.now(),
          'InTime': DateFormat('hh:mm a').format(DateTime.now()),
          'OutTime': "--/--",
          'InTimeLocation': location,
        });
      }
    } else {
      Timer(Duration(seconds: 3), () async {
        _getLocation();

        QuerySnapshot employeeSnapshot = await FirebaseFirestore.instance
            .collection("Employee")
            .where('id', isEqualTo: User.employeeId)
            .get();

        DocumentSnapshot recordSnapshot = await FirebaseFirestore.instance
            .collection("Employee")
            .doc(employeeSnapshot.docs[0].id)
            .collection("Record")
            .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
            .get();

        try {
          String inTime = recordSnapshot['InTime'];
          setState(() {
            outTime = DateFormat('hh:mm a').format(DateTime.now());
          });

          await FirebaseFirestore.instance
              .collection("Employee")
              .doc(employeeSnapshot.docs[0].id)
              .collection("Record")
              .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
              .update({
            'date': Timestamp.now(),
            'InTime': inTime,
            'OutTime': DateFormat('hh:mm a').format(DateTime.now()),
            'OutTimeLocation': location,
          });
        } catch (e) {
          setState(() {
            inTime = DateFormat('hh:mm a').format(DateTime.now());
          });
          await FirebaseFirestore.instance
              .collection("Employee")
              .doc(employeeSnapshot.docs[0].id)
              .collection("Record")
              .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
              .set({
            'date': Timestamp.now(),
            'InTime': DateFormat('hh:mm a').format(DateTime.now()),
            'OutTime': "--/--",
            'InTimeLocation': location,
          });
        }
      });
    }
  }

  Widget _buildLocationInfo() {
    return location != " "
        ? Padding(
            padding: EdgeInsets.only(top: 15),
            child: Text(
              "Location: $location",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          )
        : const SizedBox();
  }
}
