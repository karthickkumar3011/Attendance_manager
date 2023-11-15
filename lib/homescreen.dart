import 'package:attendance_manger/calendarscreen.dart';
import 'package:attendance_manger/profilescreen.dart';
import 'package:attendance_manger/services/location_service.dart';
import 'package:attendance_manger/todayscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'model/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  Color primaryColor = const Color.fromARGB(255, 103, 58, 183);

  int selectedIndex = 0; // Set the initial selected index

  @override
  void initState() {
    super.initState();
    _startLocationService();
    getId();
  }

  void getId() async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("Employee")
        .where('id', isEqualTo: User.employeeId)
        .get();

    setState(() {
      User.id = snap.docs[0].id;
    });
  }

  void _startLocationService() async {
    LocationService().initialize();
    LocationService().getLongitude().then(
      (value) {
        setState(() {
          User.long = value!;
        });
        LocationService().getLatitude().then(
          (value) {
            setState(() {
              User.lat = value!;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          "Attendance Manager",
          style: TextStyle(
            fontSize: screenWidth / 18,
            fontFamily: "NexaBold",
            color: Colors.white,
          ),
        ),
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: const [
          CalendarScreen(),
          TodayScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.7),
            blurRadius: 10,
            offset: Offset(2, 2),
          )
        ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GNav(
            backgroundColor: Colors.white,
            color: Colors.black,
            activeColor: Colors.white,
            tabBackgroundColor: primaryColor,
            gap: 10,
            padding: EdgeInsets.all(16),
            tabs: [
              GButton(
                icon: FontAwesomeIcons.calendarAlt,
                text: 'Calendar',
              ),
              GButton(
                icon: FontAwesomeIcons.calendarCheck,
                text: 'Today',
              ),
              GButton(
                icon: FontAwesomeIcons.user,
                text: 'Profile',
              )
            ],
            selectedIndex: selectedIndex, // Set the initial selected index
            onTabChange: (index) {
              // Handle tab changes
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}


// import 'package:attendance_manger/calendarscreen.dart';
// import 'package:attendance_manger/model/user.dart';
// import 'package:attendance_manger/profilescreen.dart';
// import 'package:attendance_manger/services/location_service.dart';
// import 'package:attendance_manger/todayscreen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   double screenHeight = 0;
//   double screenWidth = 0;

//   Color primary = Color.fromARGB(251, 49, 133, 196);

//   int currentIndex = 1;

//   List<IconData> navigationIcons = [
//     FontAwesomeIcons.calendarAlt,
//     FontAwesomeIcons.check,
//     FontAwesomeIcons.user,
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _startLocationService();
//     getId().then((value) {
//       _getCredentials();
//       _getProfilePic();
//     });
//   }

//   void _getCredentials() async {
//     try {
//       DocumentSnapshot doc = await FirebaseFirestore.instance
//           .collection("Employee")
//           .doc(User.id)
//           .get();
//       setState(() {
//         User.canEdit = doc['canEdit'];
//         User.firstName = doc['firstName'];
//         User.lastName = doc['lastName'];
//         User.birthDate = doc['birthDate'];
//         User.address = doc['address'];
//       });
//     } catch (e) {
//       return;
//     }
//   }

//   void _getProfilePic() async {
//     DocumentSnapshot doc = await FirebaseFirestore.instance
//         .collection("Employee")
//         .doc(User.id)
//         .get();
//     setState(() {
//       User.profilePicLink = doc['profilePic'];
//     });
//   }

//   void _startLocationService() async {
//     LocationService().initialize();

//     LocationService().getLongitude().then((value) {
//       setState(() {
//         User.long = value!;
//       });

//       LocationService().getLatitude().then((value) {
//         setState(() {
//           User.lat = value!;
//         });
//       });
//     });
//   }

//   Future<void> getId() async {
//     QuerySnapshot snap = await FirebaseFirestore.instance
//         .collection("Employee")
//         .where('id', isEqualTo: User.employeeId)
//         .get();

//     setState(() {
//       User.id = snap.docs[0].id;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     screenHeight = MediaQuery.of(context).size.height;
//     screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Attendance Manager",
//           style: TextStyle(fontFamily: "NexaBold"),
//         ),
//       ),
//       body: IndexedStack(
//         index: currentIndex,
//         children: [
//           new CalendarScreen(),
//           new TodayScreen(),
//           new ProfileScreen(),
//         ],
//       ),
//       bottomNavigationBar: Container(
//         height: 70,
//         margin: const EdgeInsets.only(
//           left: 12,
//           right: 12,
//           bottom: 24,
//         ),
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.all(Radius.circular(40)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 10,
//               offset: Offset(2, 2),
//             ),
//           ],
//         ),
//         child: ClipRRect(
//           borderRadius: const BorderRadius.all(Radius.circular(40)),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               for (int i = 0; i < navigationIcons.length; i++) ...<Expanded>{
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         currentIndex = i;
//                       });
//                     },
//                     child: Container(
//                       height: screenHeight,
//                       width: screenWidth,
//                       color: Colors.white,
//                       child: Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               navigationIcons[i],
//                               color:
//                                   i == currentIndex ? primary : Colors.black54,
//                               size: i == currentIndex ? 30 : 26,
//                             ),
//                             i == currentIndex
//                                 ? Container(
//                                     margin: const EdgeInsets.only(top: 6),
//                                     height: 3,
//                                     width: 22,
//                                     decoration: BoxDecoration(
//                                       borderRadius: const BorderRadius.all(
//                                           Radius.circular(40)),
//                                       color: primary,
//                                     ),
//                                   )
//                                 : const SizedBox(),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               }
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
