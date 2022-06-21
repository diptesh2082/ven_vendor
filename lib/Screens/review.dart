
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';



import '../Services/firebase_firestore_api.dart';
import '../controllers/gym_controller.dart';

class Review extends StatefulWidget {
  // final gymid;

  const Review({Key? key,}) : super(key: key);
  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  double ratingvalue = 0;

  TextEditingController title = TextEditingController();
  TextEditingController exp = TextEditingController();
  var _ratingController = TextEditingController();
  bool isLoad=true;

  var review;
  var star=0.0;
  // final _id=  Get.arguments["gym_id"];

  // getRatingCount(x)async{
  //   DocumentReference db= await FirebaseFirestore.instance.collection("product_details").doc(_id);
  //   try{
  //     db.get().then((DocumentSnapshot documentSnapshot) {
  //       if(documentSnapshot.exists){
  //         try{
  //           db.update({
  //             "rating":x
  //           });
  //         }catch(e){
  //           db.update({
  //             "rating":1
  //           });
  //         }
  //
  //       }
  //     }
  //
  //     );
  //   }catch(e){
  //     // db.get().then((DocumentSnapshot documentSnapshot) {
  //     //   if(documentSnapshot.exists){
  //     //     db.update({
  //     //       "view_count":1
  //     //     });
  //     //   }
  //     // }
  //
  //     // );
  //   }
  //
  //
  //   //     .update(
  //   // {
  //   // "view_count": +1;
  //   // }
  //   // );
  // }
  getRating()async{
    await FirebaseFirestore.instance.collection("Reviews")
        .where("gym_id",isEqualTo: gymId)
        .snapshots()
        .listen((snap) async {
      if (snap.docs.isNotEmpty){
        print("documentexist");

        var d=snap.docs;
        var b=0.0;
        var star1=0.0;
        var star2=0.0;
        var star3=0.0;
        var star4=0.0;
        var star5=0.0;
        // var c=0.0;
        d.forEach((element) {
          b = b + double.parse(element["rating"]);
          if (double.parse(element["rating"])>4){
            star1=star1+1.0;
          }
          else if (double.parse(element["rating"])>3 && double.parse(element["rating"])<=4){
            star2=star2+1.0;
          }
          else if (double.parse(element["rating"])>2 && double.parse(element["rating"])<=3){
            star3=star3+1.0;
          }
          else if (double.parse(element["rating"])>1 && double.parse(element["rating"])<=2){
            star4=star4+1.0;
          }else{
            star5=star5+1.0;
          }


        });
        Get.find<BookingController>().star1.value= double.parse((star1/d.length).toStringAsFixed(1));
        Get.find<BookingController>().star2.value= double.parse((star2/d.length).toStringAsFixed(1));
        Get.find<BookingController>().star3.value= double.parse((star3/d.length).toStringAsFixed(1));
        Get.find<BookingController>().star4.value= double.parse((star4/d.length).toStringAsFixed(1));
        Get.find<BookingController>().star5.value= double.parse((star5/d.length).toStringAsFixed(1));
        Get.find<BookingController>().review.value =double.parse((b/d.length).toStringAsFixed(1));
        print(Get.find<BookingController>().review.value);
        // getRatingCount(await Get.find<BookingController>().review.value);
      }


    });

    setState(() {
      isLoad=false;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    // print(doc["name"]);
    // print(_id);
  getRating();

    // print(star);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return isLoad?
        Center(child: CircularProgressIndicator())
        :Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Reviews',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black,
            ),
          )),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: SizedBox(
      //     // color: buttonColor,
      //     width: MediaQuery.of(context).size.width*.9,
      //     child: FloatingActionButton.extended(
      //         shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(12)),
      //         label: const Text(
      //           'Write a review',
      //           style: TextStyle(
      //               fontFamily: 'Poppins',
      //               fontWeight: FontWeight.w700,
      //               fontSize: 14,
      //               color: Colors.white),
      //         ),
      //         backgroundColor: Color(0xff292F3D),
      //       onPressed: () {
      //
      //     },
      //         // onPressed: (){
      //         //   Get.to(()=>AddReview(),
      //         //       arguments: {
      //         //         "gym_id":_id,
      //         //       }
      //         //   );
      //         // }
      //         ),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white10,
            child: Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child:  Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Customer reviews',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance.collection("product_details").doc(gymId).snapshots(),
                              builder: (context,AsyncSnapshot snapshot) {
                                if(snapshot.connectionState==ConnectionState.waiting){
                                  return Center(child: CircularProgressIndicator());
                                }
                              return Row(
                                children: [
                                  RatingBarIndicator(
                                    itemBuilder: ((context, index) {
                                      return const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      );
                                    }),
                                    rating: double.parse(snapshot.data.get("rating").toString()),
                                    itemCount: 5,
                                    itemSize: 20.0,
                                    direction: Axis.horizontal,
                                  ),
                                  Text('${snapshot.data.get("rating")} out of 5 ',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14))
                                ],
                              );
                            }
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.012,
                          ),
                           Obx(
                             ()=> Text(
                              '(${Get.find<BookingController>().review_number.value} reviews)',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.grey),
                          ),
                           ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Obx(
                            ()=> Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                     Text(
                                      '5 stars',
                                      style: GoogleFonts.poppins(

                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Colors.black),
                                    ),
                                    Spacer(),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width*.7,
                                      child: LinearProgressIndicator(
                                        value: Get.find<BookingController>().star1.value,
                                        color: Colors.amber,
                                        backgroundColor: Colors.white,
                                        minHeight: 8,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      '${Get.find<BookingController>().star1.value*100}%',
                                      style: GoogleFonts.poppins(

                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                     Text(
                                      '4 stars',
                                      style: GoogleFonts.poppins(

                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Colors.black),
                                    ),
                                    Spacer(),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width*.7,
                                      child: LinearProgressIndicator(
                                        value: Get.find<BookingController>().star2.value,
                                        color: Colors.amber,
                                        backgroundColor: Colors.white,
                                        minHeight: 8,
                                      ),
                                    ),Spacer(),
                                    Text(
                                      '${Get.find<BookingController>().star2.value*100}%',
                                      style: GoogleFonts.poppins(

                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    )
                                  ],
                                ),  SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                     Text(
                                      '3 stars',
                                      style: GoogleFonts.poppins(

                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Colors.black),
                                    ),
                                    Spacer(),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width*.7,
                                      child: LinearProgressIndicator(
                                        value: Get.find<BookingController>().star3.value,
                                        color: Colors.amber,
                                        backgroundColor: Colors.white,
                                        minHeight: 8,
                                      ),
                                    ),Spacer(),
                                    Text(
                                      '${Get.find<BookingController>().star3.value*100}%',
                                      style: GoogleFonts.poppins(

                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Colors.black),
                                    ),SizedBox(
                                      width: 10,
                                    )
                                  ],
                                )
                                ,  SizedBox(
                                  height: 8,
                                ),Row(

                                  // cr
                                  children: [
                                     Text(
                                      '2 stars',
                                      style: GoogleFonts.poppins(

                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Colors.black),
                                    ),
                                    Spacer(),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width*.7,
                                      child: LinearProgressIndicator(
                                        value: Get.find<BookingController>().star4.value,
                                        color: Colors.amber,
                                        backgroundColor: Colors.white,
                                        minHeight: 8,
                                      ),
                                    ),Spacer(),
                                    Text(
                                      '${Get.find<BookingController>().star4.value*100}%',
                                      style: GoogleFonts.poppins(

                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Colors.black),
                                    ),SizedBox(
                                      width: 10,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                     Text(
                                      '1 stars',
                                      style: GoogleFonts.poppins(

                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Colors.black),
                                    ),
                                    Spacer(),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width*.7,
                                      child: LinearProgressIndicator(
                                        value: Get.find<BookingController>().star5.value,
                                        color: Colors.amber,
                                        backgroundColor: Colors.white,
                                        minHeight: 8,
                                      ),
                                    ),Spacer(),
                                    Text(
                                      '${Get.find<BookingController>().star5.value*100}%',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Colors.black),
                                    ),SizedBox(
                                      width: 10,
                                    )

                                  ],
                                )
                              ],
                            ),
                          ),
                          // Column(
                          //   children: [
                          //     Row(
                          //       children: [
                          //         const Text(
                          //           '5 star',
                          //           style: TextStyle(
                          //               fontFamily: 'Poppins',
                          //               fontWeight: FontWeight.w400,
                          //               fontSize: 12,
                          //               color: Colors.black),
                          //         ),
                          //         SizedBox(
                          //           width: MediaQuery.of(context).size.width * 0.02,
                          //         ),
                          //         LinearPercentIndicator(
                          //           lineHeight: 9,
                          //           backgroundColor: Colors.white,
                          //           width: MediaQuery.of(context).size.width * 0.72,
                          //           percent: Get.find<BookingController>().star1.value,
                          //           trailing:  Text(
                          //             '${Get.find<BookingController>().star1.value*100}%',
                          //             style: TextStyle(
                          //                 fontFamily: 'Poppins',
                          //                 fontWeight: FontWeight.w400,
                          //                 fontSize: 12,
                          //                 color: Colors.black),
                          //           ),
                          //           progressColor: Colors.amber,
                          //         ),
                          //       ],
                          //     ),
                          //     SizedBox(
                          //       height: MediaQuery.of(context).size.height * 0.01,
                          //     ),
                          //     Row(
                          //       children: [
                          //         const Text(
                          //           '4 star',
                          //           style: TextStyle(
                          //               fontFamily: 'Poppins',
                          //               fontWeight: FontWeight.w400,
                          //               fontSize: 12,
                          //               color: Colors.black),
                          //         ),
                          //         SizedBox(
                          //           width: MediaQuery.of(context).size.width * 0.02,
                          //         ),
                          //         LinearPercentIndicator(
                          //           lineHeight: 9,
                          //           backgroundColor: Colors.white,
                          //           width: MediaQuery.of(context).size.width * 0.72,
                          //           percent: Get.find<BookingController>().star2.value,
                          //           trailing:  Text(
                          //             '${Get.find<BookingController>().star2.value*100}%',
                          //             style: TextStyle(
                          //                 fontFamily: 'Poppins',
                          //                 fontWeight: FontWeight.w400,
                          //                 fontSize: 12,
                          //                 color: Colors.black),
                          //           ),
                          //           progressColor: Colors.amber,
                          //         ),
                          //       ],
                          //     ),
                          //     SizedBox(
                          //       height: MediaQuery.of(context).size.height * 0.01,
                          //     ),
                          //     Row(
                          //       children: [
                          //         const Text(
                          //           '3 star',
                          //           style: TextStyle(
                          //               fontFamily: 'Poppins',
                          //               fontWeight: FontWeight.w400,
                          //               fontSize: 12,
                          //               color: Colors.black),
                          //         ),
                          //         SizedBox(
                          //           width: MediaQuery.of(context).size.width * 0.02,
                          //         ),
                          //         LinearPercentIndicator(
                          //           lineHeight: 9,
                          //           backgroundColor: Colors.white,
                          //           width: MediaQuery.of(context).size.width * 0.72,
                          //           percent: Get.find<BookingController>().star3.value,
                          //           trailing:  Text(
                          //             '${Get.find<BookingController>().star3.value*100}%',
                          //             style: TextStyle(
                          //                 fontFamily: 'Poppins',
                          //                 fontWeight: FontWeight.w400,
                          //                 fontSize: 12,
                          //                 color: Colors.black),
                          //           ),
                          //           progressColor: Colors.amber,
                          //         ),
                          //       ],
                          //     ),
                          //     SizedBox(
                          //       height: MediaQuery.of(context).size.height * 0.01,
                          //     ),
                          //     Row(
                          //       children: [
                          //         const Text(
                          //           '2 star',
                          //           style: TextStyle(
                          //               fontFamily: 'Poppins',
                          //               fontWeight: FontWeight.w400,
                          //               fontSize: 12,
                          //               color: Colors.black),
                          //         ),
                          //         SizedBox(
                          //           width: MediaQuery.of(context).size.width * 0.02,
                          //         ),
                          //         LinearPercentIndicator(
                          //           lineHeight: 9,
                          //           backgroundColor: Colors.white,
                          //           width: MediaQuery.of(context).size.width * 0.72,
                          //           percent:Get.find<BookingController>().star4.value,
                          //           trailing:  Text(
                          //             '${Get.find<BookingController>().star4.value*100}%',
                          //             style: TextStyle(
                          //                 fontFamily: 'Poppins',
                          //                 fontWeight: FontWeight.w400,
                          //                 fontSize: 12,
                          //                 color: Colors.black),
                          //           ),
                          //           progressColor: Colors.amber,
                          //         ),
                          //       ],
                          //     ),
                          //     SizedBox(
                          //       height: MediaQuery.of(context).size.height * 0.01,
                          //     ),
                          //     Row(
                          //       children: [
                          //         const Text(
                          //           '1 star',
                          //           style: TextStyle(
                          //               fontFamily: 'Poppins',
                          //               fontWeight: FontWeight.w400,
                          //               fontSize: 12,
                          //               color: Colors.black),
                          //         ),
                          //         SizedBox(
                          //           width: MediaQuery.of(context).size.width * 0.02,
                          //         ),
                          //         LinearPercentIndicator(
                          //           lineHeight: 9,
                          //           backgroundColor: Colors.white,
                          //           width: MediaQuery.of(context).size.width * 0.72,
                          //           percent: Get.find<BookingController>().star5.value,
                          //           trailing:  Text(
                          //             '${Get.find<BookingController>().star5.value*100}%',
                          //             style: TextStyle(
                          //                 fontFamily: 'Poppins',
                          //                 fontWeight: FontWeight.w400,
                          //                 fontSize: 12,
                          //                 color: Colors.black),
                          //           ),
                          //           progressColor: Colors.amber,
                          //         ),
                          //       ],
                          //     ),
                          //   ],
                          // ),
                          const Divider(
                            height: 30,
                            indent: 8,
                            endIndent: 20,
                            thickness: 1.2,
                          ),
                        ],
                      ),

                  ),
                  Align(
                    alignment: Alignment.center,
                    child: StreamBuilder<QuerySnapshot>(

                        stream: FirebaseFirestore.instance.collection("Reviews").where("gym_id",isEqualTo: "${gymId}"   ).snapshots(),
                        builder: ((context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.amberAccent,
                              ),
                            );
                          }
                          var document = snapshot.data.docs;
                          print(document);
                          // document = document.where((element) {
                          //   return  element
                          //       .get('gym_id')
                          //       .toString()
                          //   // .toLowerCase()
                          //       .contains(doc["gym_id"].toString());
                          // }).toList();
                          // print(document.length);
                          return document.isNotEmpty
                              ? Column(
                            children: [
                              ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: document.length,
                                itemBuilder: (context, int index) {

                                  return Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        leading: Container(
                                          height: 50,
                                          width: 50,
                                          decoration:  BoxDecoration(
                                              shape: BoxShape.circle,
//border: Border.all(width: 1),
                                              image: DecorationImage(
                                                  image: CachedNetworkImageProvider(document[index]["user"]["user_pic"],maxHeight: 70,maxWidth: 70),
                                                  fit: BoxFit.cover)),
                                        ),
                                        title: Text(
                                          // "",
                                          document[index]["user"]["user_name"]??"",
// snapshot.data.docs[index]['name'],
                                          style: GoogleFonts.poppins(

                                              fontWeight: FontWeight.w600,
                                              fontSize: 12),
                                        ),
                                        subtitle: Column(
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            RatingBarIndicator(
                                              itemBuilder: ((context, index) {
                                                return const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                );
                                              }),
                                              rating: double.parse(document[index]['rating']),
                                              itemCount: 5,
                                              itemSize: 18.0,
                                              direction: Axis.horizontal,
                                            ),
                                            Text(
                                              // "",
                                              document!=null?document[index]["title"] ?? "":"",
// snapshot.data.docs[index]['experience'],
                                              style: GoogleFonts.poppins(

                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 12),
                                            ),
                                            Text(
                                              // "",
                                              document!=null?document[index]["experience"] ?? "":"",
// snapshot.data.docs[index]['experience'],
                                              style: GoogleFonts.poppins(

                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),


                                    ],
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return Divider();
                                },
                              ),
                            ],
                          )
                              : const Center(
                            child: Text(
                              "No Review",
                              style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontFamily: "Poppins",
                                fontSize: 20,
                              ),
                            ),
                          );
                        })),
                  ),
                  SizedBox(
                    height: 80,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future openreviewcard() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))),
        actions: [
          Center(
            // child: ElevatedButton(
            //   style: ButtonStyle(
            //       backgroundColor:
            //       MaterialStateProperty.all<Color>(Color(0xff292F3D)),
            //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //           RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(10),
            //           ))),
            //   child: const Text(
            //     'Submit',
            //     style: TextStyle(
            //         color: Colors.white,
            //         fontFamily: 'Poppins',
            //         fontWeight: FontWeight.w700,
            //         fontSize: 14),
            //   ),
            //   onPressed: () async {
            //     Navigator.of(context).pop();
            //     final CollectionReference review =
            //     FirebaseFirestore.instance.collection('Reviews');
            //     FirebaseFirestore.instance
            //         .runTransaction((transaction) async {
            //       CollectionReference reference =
            //       FirebaseFirestore.instance.collection('Reviews');
            //       Map<String, dynamic> review_data = {
            //         "rating": ratingvalue.toString(),
            //         "title": title.text,
            //         "experience": exp.text
            //       };
            //       await reference
            //           .doc("GYM")
            //           .collection(number)
            //           .add(review_data);
            //
            //       title.clear();
            //       exp.clear();
            //
            //       /* FirebaseFirestore.instance
            //               .collection("user_details")
            //               .add(review_data);*/
            //     });
            //   },
            // ),
          ),
        ],
        content: SizedBox(
          height: MediaQuery.of(context).size.height / 2.22,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Positioned(
                  top: 0.0,
                  right: 0.0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Align(
                      alignment: Alignment.topRight,
                      child: CircleAvatar(
                        radius: 14.0,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )),
              RatingBar(
                  initialRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  ratingWidget: RatingWidget(
                    full: const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    half: const Icon(
                      Icons.star_half,
                      color: Colors.amber,
                    ),
                    empty: const Icon(
                      Icons.star_outline,
                      color: Colors.amber,
                    ),
                  ),
                  onRatingUpdate: (value) {
                    setState(() {
                      ratingvalue = value;
                    });
                  }),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.022,
              ),
              // Text(
              //   ratingvalue != null ? ratingvalue.toString() : 'Rate it'),
              const Text(
                'Add a title',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 12,
                child: Card(
                    child: TextField(
                      autofocus: true,
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      controller: title,
                      maxLines: 3,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontSize: 10,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          hintMaxLines: 2,
                          hintText: 'Sum up your experience in one line.'),
                    )),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.022,
              ),
              const Text(
                'Add a written review',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 8,
                child: Card(
                  child: TextField(
                    autofocus: true,
                    style: const TextStyle(
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                    controller: exp,
                    maxLines: 10,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        hintMaxLines: 4,
                        hintStyle: TextStyle(
                          fontSize: 10,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        hintText:
                        'What did you like or dislike? What was your overall experience.'),
                  ),
                ),
              )
            ],
          ),
        ),
      ));
}