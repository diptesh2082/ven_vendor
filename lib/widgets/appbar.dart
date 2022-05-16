import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Services/firebase_firestore_api.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String gymname;
  final bool isGymOpened;
  final String gymLocation;
  final Function? leadingCallback;
  CustomAppBar({
     required this.gymname, required this.isGymOpened, required this.gymLocation, this.leadingCallback,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Size get preferredSize => const Size.fromHeight(60);
  bool showBranches = false;
  var status = true;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: kToolbarHeight +10,
      backgroundColor: Colors.transparent,
      primary: true,
      iconTheme: const IconThemeData(color: Colors.black),
      titleSpacing: 0,
      elevation: 0,
      leading: IconButton(
          onPressed: () {
            widget.leadingCallback!();
          },
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          )),
      title: InkWell(
        onTap: () {
          print("Open that Alert dialogue Box");
          setState(() {
            showBranches = !showBranches;
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              widget.gymname,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16,
                letterSpacing: 1,
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:0),
                  child: Text(
                    widget.gymLocation,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffBDBDBD),
                    ),
                  ),
                ),
                Icon(
                  !showBranches
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_up,
                  color: const Color(0xff130F26),
                  size: 20,
                )
              ],
            ),
          ],
        ),
      ),
      // bottom: PreferredSize(
      //   child: Align(alignment: Alignment.center, child: SearchIt()),
      //   preferredSize: const Size.fromHeight(0),
      // ),
      actions: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          height: 30, //set desired REAL HEIGHT
          width: 60, //set desired REAL WIDTH
          child: Transform.scale(
            transformHitTests: false,
            scale: 0.8,
            child: CupertinoSwitch(
              value: widget.isGymOpened,
              onChanged: (value) {
                FirebaseFirestoreAPi()
                    .updateGymStatusToFirestore(isGymOpened: value);
                print(value);
                setState(() {
                  status = value;
                });
                FirebaseFirestoreAPi()
                    .updateGymStatusToFirestore(isGymOpened: value);
              },
              activeColor: Colors.green,
            ),
          ),
        ),
      ],
    );
  }
}

