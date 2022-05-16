// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../Services/firebase_firestore_api.dart';
//
// class AppBar extends StatefulWidget {
//   const AppBar({Key? key}) : super(key: key);
//
//   @override
//   State<AppBar> createState() => _AppBarState();
// }
//
// class _AppBarState extends State<AppBar> {
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       toolbarHeight: kToolbarHeight +12,
//       backgroundColor: Colors.transparent,
//       primary: true,
//       iconTheme: const IconThemeData(color: Colors.black),
//       titleSpacing: 0,
//       elevation: 0,
//       leading: IconButton(
//           onPressed: () {
//             leadingCallback!();
//           },
//           icon: const Icon(
//             Icons.menu,
//             color: Colors.black,
//           )),
//       title: InkWell(
//         onTap: () {
//           print("Open that Alert dialogue Box");
//           setState(() {
//             showBranches = !showBranches;
//           });
//         },
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             SizedBox(
//               height: 15,
//             ),
//             Text(
//               gymname!,
//               style: const TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.w600,
//                 fontSize: 16,
//                 letterSpacing: 1,
//               ),
//             ),
//             Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left:0),
//                   child: Text(
//                     gymLocation!,
//                     style: GoogleFonts.poppins(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: Color(0xffBDBDBD),
//                     ),
//                   ),
//                 ),
//                 Icon(
//                   !showBranches
//                       ? Icons.keyboard_arrow_down
//                       : Icons.keyboard_arrow_up,
//                   color: const Color(0xff130F26),
//                   size: 20,
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//       // bottom: PreferredSize(
//       //   child: Align(alignment: Alignment.center, child: SearchIt()),
//       //   preferredSize: const Size.fromHeight(0),
//       // ),
//       actions: [
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//           height: 30, //set desired REAL HEIGHT
//           width: 60, //set desired REAL WIDTH
//           child: Transform.scale(
//             transformHitTests: false,
//             scale: 0.8,
//             child: CupertinoSwitch(
//               value: isGymOpened!,
//               onChanged: (value) {
//                 FirebaseFirestoreAPi()
//                     .updateGymStatusToFirestore(isGymOpened: value);
//                 print(value);
//                 setState(() {
//                   status = value;
//                 });
//                 FirebaseFirestoreAPi()
//                     .updateGymStatusToFirestore(isGymOpened: value);
//               },
//               activeColor: Colors.green,
//             ),
//           ),
//         ),
//       ],
//     );;
//   }
// }
