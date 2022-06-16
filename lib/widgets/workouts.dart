import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Workouts extends StatefulWidget {
  const Workouts({Key? key,required this.workouts}) : super(key: key);
  final workouts;
  @override
  State<Workouts> createState() => _WorkoutsState();
}

class _WorkoutsState extends State<Workouts> {
  var documents;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('workouts')
        // .where('id', whereIn:widget.workouts)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          documents = snapshot.data.docs;
          var d=[];
          documents.forEach((element) {
            if(widget.workouts.contains(element["id"])){
              d.add(element["type"]);
            }

          });
          print(d);
          return documents.isNotEmpty
              ?
          workouts(d)
              : SizedBox();
        },
      ),
    );
  }
  Widget workouts(List document) => Column(
    children: [
      Card(
        elevation: .3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)),
        child: SizedBox(
          width:  MediaQuery.of(context).size.height * 0.95,
          height: 72,
          child:  Padding(
              padding: EdgeInsets.only(right: 10,left: 10),
              child:
              Center(
                child: Text(
                  "${document.join(" | ")}",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                  maxLines: 3,
                ),
              )
          ),
        ),
      ),
      //   CircleAvatar(
      //     radius: 30,
      //     backgroundColor: Colors.amber,
      //     // backgroundImage: CachedNetworkImageProvider(
      //     //       documents[index]['image'],
      //     //   // maxHeight: 30,
      //     //   // maxWidth: 30
      //     //     ),
      //     child: Container(
      //       height: 40,
      //       width: 40,
      //
      //     ),
      //   ),
      //
      //   SizedBox(
      //     width: 80,
      //     height: 38,
      //     child: Text(
      //       documents[index]['type'],
      //       textAlign: TextAlign.center,
      //       style: GoogleFonts.poppins(
      //         fontWeight: FontWeight.w400,
      //         fontSize: 12,
      //       ),
      //       maxLines: 2,
      //       overflow: TextOverflow.clip,
      //     ),
      //
      //   ),
    ],
  );
}
