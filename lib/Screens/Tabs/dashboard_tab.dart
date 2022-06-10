import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vyam_vandor/Services/firebase_firestore_api.dart';
import 'package:vyam_vandor/controllers/gym_controller.dart';
import 'package:vyam_vandor/widgets/amenites.dart';
import 'package:vyam_vandor/widgets/dashboard_map.dart';
import 'package:vyam_vandor/widgets/know_trainer.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final double coverheight = 150;
  final double profileheight = 80;
  List trainers = [
    // "Assets/Images/trainer1.png",
    // "Assets/Images/trainer2.png",
    // "Assets/Images/trainer3.png",
  ];

  List<IconData> icons = [
    Icons.ac_unit,
    Icons.lock_rounded,
    Icons.car_repair,
    Icons.person_outline,
    Icons.access_alarm,
  ];

  final amenities_name = [
    "A/C",
    "Locker",
    "Parking",
    "P/T",
    "Alarm",
  ];

  final trainername = ['Jake Paul', 'Jim Harry', 'Kim Jhonas'];
  List<String> multiimages = [];
  // late Future<List<FirebaseFile>> futurefiles;
  var gym_images=[];
  // getGymImages()async{
  //   try{
  //     await FirebaseFirestore.instance.collection("product_details").doc(gymId).snapshots().listen((snapshot) {
  //       if (snapshot.exists){
  //         setState(() {
  //           gym_images=snapshot.data!["images"];
  //         });
  //         print("//////////!!!!!!!!!!!!!!!!!!!!!!!!");
  //        print(gym_images);
  //       }
  //     });
  //   }catch(e){
  //     print(e);
  //   }
  // }

  final _auth = FirebaseAuth.instance;
  // var futurefiles;
  @override
  void initState() {
    // getGymImages();
    // print("//////////!!!!!!!!!!!!!!!!!!!!!!!!");
    // print(gym_images);
    super.initState();
     // futurefiles = StorageDatabase.listAll('TransformerGymImage/');
  }
  var gym_details;
  List<dynamic>   amenites=[""];

  @override
  Widget build(BuildContext context) {
    final top = coverheight - profileheight / 1.5;
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('product_details')
              .doc(gymId.toString())
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container();
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            gym_images=snapshot.data["images"];
            gym_details=snapshot.data;
            amenites=snapshot.data["amenities"];
            if (amenites.isEmpty){
              amenites=[""];
            }
            // print(gym_images);
            return SingleChildScrollView(
              child: Container(
                color: Colors.grey[100],
                child: Padding(
                  padding: const EdgeInsets.only(top: 35.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileTile(
                        coverheight: coverheight,
                        top: top,
                        profileheight: profileheight,
                        imageUrl: snapshot.data.get('display_picture'),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, top: 50),
                        child: Text(
                          snapshot.data.get('name'),
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, top: 8.0),
                        child: Text(
                          snapshot.data.get('branch'),
                          style: const TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      // InkWell(
                      //   child: const Padding(
                      //     padding: EdgeInsets.only(left: 12.0, top: 8.0),
                      //     child: Text(
                      //       'Switch Branch',
                      //       style: TextStyle(
                      //           color: Colors.black,
                      //           decoration: TextDecoration.underline,
                      //           fontFamily: 'Poppins',
                      //           fontSize: 12,
                      //           fontWeight: FontWeight.w600),
                      //     ),
                      //   ),
                      //   onTap: () {},
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //       top: 8.0, left: 8.0, right: 8.0),
                      //   child: Card(
                      //     elevation: 3,
                      //     shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(12.0)),
                      //     child: Obx(
                      //           ()=> ListTile(
                      //         title: const Text(
                      //           'Total Visit by customer',
                      //           style: TextStyle(
                      //               color: Colors.black,
                      //               fontFamily: 'PoppinsSemiBold',
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.w600),
                      //         ),
                      //         trailing: Text(
                      //           "${Get.find<BookingController>().booking.value}",
                      //           style: const TextStyle(
                      //               color: Colors.black,
                      //               fontFamily: 'PoppinsSemiBold',
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.w600),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      Padding(
                        padding: const EdgeInsets.only(
                            top: 6.0, left: 8.0, right: 8.0),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          child: Obx(
                            ()=> ListTile(
                              title: const Text(
                                'Total booking',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'PoppinsSemiBold',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              trailing: Text(
                                "${Get.find<BookingController>().booking.value}",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'PoppinsSemiBold',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 12.0, top: 8.0, right: 14),
                        child: Row(
                          children: const [
                            Text(
                              'Photos',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            Spacer(),
                            // Icon(
                            //   Icons.file_upload_outlined,
                            //   size: 20,
                            // ),
                            // InkWell(
                            //   child: const Text("Add photos",
                            //       style: TextStyle(
                            //           color: Colors.black,
                            //           fontFamily: 'Poppins',
                            //           fontSize: 14,
                            //           fontWeight: FontWeight.w600)),
                            //   onTap: () async {
                            //     List<XFile>? _images = await multiimagepicker();
                            //     //  multiimages = await multiimagepicker();
                            //     if (_images.isNotEmpty) {
                            //       multiimages =
                            //           await multiimageuploader(_images);
                            //       setState(() {});
                            //     }
                            //   },
                            // )
                          ],
                        ),
                      ),
                    Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: SizedBox(
                                      height: 200,
                                      child: GridView.builder(
                                          shrinkWrap: true,
                                          gridDelegate:

                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 5,
                                              mainAxisSpacing: 12.0),
                                          itemCount: gym_images.length,
                                          itemBuilder: (context, index) {
                                            final file = gym_images[index];
                                            return buildFile(context, file);
                                          }),
                                    ),
                                  ),

                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 8.0),
                        child: SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 8.0, top: 8.0),
                                    child: Text('Rules',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, top: 12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          "•  Bring your towel and use it.",
                                          style: TextStyle(
                                              fontFamily: 'PoppinsRegular',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text("•  Bring seperate shoes.",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'PoppinsRegular',
                                              fontWeight: FontWeight.w400,
                                            )),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text("•  Re-rack equipments",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'PoppinsRegular',
                                              fontWeight: FontWeight.w400,
                                            )
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                            "•  No heavy lifting without spotter",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'PoppinsRegular',
                                              fontWeight: FontWeight.w400,
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child:  StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("product_details")
                                .doc("$gymId}")
                                .collection("trainers")
                                .snapshots(),
                            builder: (context,AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child:
                                  CircularProgressIndicator(
                                    color: Colors.amberAccent,
                                  ),
                                );
                              }
                              if (snapshot.hasError) {
                                return const Center(
                                  child:
                                  Text("Theres no trainers"),
                                );
                              }
                              if (snapshot.hasData==false) {
                                return  Container();

                              }
                              var trainerdoc =
                                  snapshot.data!.docs;
                              return trainerdoc.length==0?
                              SizedBox()
                                  :SizedBox(
                                  height: 145, //MediaQuery.of(context).size.height / 4.7,
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(() => Trainer(), arguments: {
                                        "gym_id": gym_details["gym_id"],
                                        "image": gym_details["display_picture"]
                                      });
                                    },
                                    child: Card(
                                        elevation: .3,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12.0)),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children:  [
                                                    Text('Trainers',
                                                        style: GoogleFonts.poppins(

                                                          fontSize: 13,
                                                          fontWeight: FontWeight.w700,
                                                        )),
                                                    Spacer(),
                                                    Icon(
                                                      Icons.arrow_forward_ios_outlined,
                                                      size: 18,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 8.0),
                                                child: SizedBox(
                                                    height: 100,
                                                    //MediaQuery.of(context).size.height /
                                                    //  9,
                                                    child:  ListView.builder(
                                                        shrinkWrap: true,
                                                        itemCount: trainerdoc.length,
                                                        physics:
                                                        const PageScrollPhysics(),
                                                        scrollDirection:
                                                        Axis.horizontal,
                                                        itemBuilder: (context, index) {
                                                          return Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: [
                                                                  Column(
                                                                    children: [
                                                                      Container(
                                                                        height: 65,
                                                                        width: 65,
                                                                        decoration:
                                                                        BoxDecoration(
                                                                            shape: BoxShape
                                                                                .circle,
                                                                            //border: Border.all(width: 1),
                                                                            image: DecorationImage(
                                                                                filterQuality: FilterQuality.medium,
                                                                                image:
                                                                                CachedNetworkImageProvider(trainerdoc[index]['images']),
                                                                                fit: BoxFit.cover)),
                                                                      ),
                                                                      SizedBox(
                                                                        height: 2,
                                                                      ),
                                                                      Text(
                                                                          trainerdoc[
                                                                          index]
                                                                          ['name'],
                                                                          style:
                                                                          GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 12, )
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 15),
                                                                ],
                                                              ),
                                                            ],
                                                          );
                                                        }
                                                    )

                                                ),
                                              ),
                                            ])),
                                  ));
                            }
                        ),
                      ),
                      // Amenities//
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Amenites",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*.98,
                          child: Amenites(amenites: amenites,)
                      ),
                      //Address//
                      const Padding(
                        padding: EdgeInsets.only(left: 12.0, top: 10.0),
                        child: Text(
                          'Address',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                            onTap: (){
                              if(gym_details["legit"]==false)
                                Get.to(()=>DashboardMap());
                            },
                          child: FittedBox(
                            child: SizedBox(
                              height: 60,
                              width: MediaQuery.of(context).size.width*.98,
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0)),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width*.75,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          '${gym_details["address"]}',
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,

                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }


  Widget buildFile(BuildContext context, String file) => ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: CachedNetworkImage(

      height: 128,
      width: 127,
      imageUrl: file,
      fit: BoxFit.cover,
      filterQuality: FilterQuality.low,
    ),
  );


  Widget amenities(int index,DocumentSnapshot doc) => Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 6.0),
        child: FittedBox(
          child: Column(
            children: [
              CircleAvatar(
                child: Icon(
                  icons[index], // Icon list
                  size: 60,
                  color: Colors.black,
                ),
                backgroundColor: Colors.amber.shade400,
                radius: 80,
              ),
              Text(
                amenities_name[index], // icon name list
                style: const TextStyle(
                    fontFamily: 'PoppinsRegular',
                    fontWeight: FontWeight.w400,
                    fontSize: 40),
              ),
            ],
          ),
        ),
      );
}

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    Key? key,
    required this.coverheight,
    required this.top,
    required this.profileheight,
    this.imageUrl,
  }) : super(key: key);

  final double coverheight;
  final double top;
  final double profileheight;
  final imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomLeft,
        children: [
          Container(
            width: double.maxFinite,
            height: coverheight,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("Assets/Images/rectangle_14.png"),
                    fit: BoxFit.cover)),
          ),
          Positioned(
            top: top,
            left: 16,
            child: CircleAvatar(
              radius: 55,
              backgroundColor: Colors.white,
              backgroundImage: CachedNetworkImageProvider(imageUrl),
            ),
          )
        ]);
  }
}

Future<List<XFile>> multiimagepicker() async {
  List<XFile>? _images = await ImagePicker().pickMultiImage(imageQuality: 50);
  if (_images != null && _images.isNotEmpty) {
    return _images;
  }
  return [];
}

Future<String> uploadimage(XFile image) async {
  Reference db = FirebaseStorage.instance
      .ref("gyms/TransformerGymImage/${getImageName(image)}");
  await db.putFile(File(image.path));
  return await db.getDownloadURL();
}

String getImageName(XFile image) {
  return image.path.split("/").last;
}

Future<List<String>> multiimageuploader(List<XFile> list) async {
  List<String> _path = [];
  for (XFile _image in list) {
    _path.add(await uploadimage(_image));
  }
  return _path;
}

class StorageDatabase {
  static Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
      Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  static Future<List<FirebaseFile>> listAll(String path) async {
    final ref = FirebaseStorage.instance.ref(path);
    final result = await ref.listAll();
    final urls = await _getDownloadLinks(result.items);
    return urls
        .asMap()
        .map((index, url) {
          final ref = result.items[index];
          final file = FirebaseFile(ref: ref, url: url);
          return MapEntry(index, file);
        })
        .values
        .toList();
  }
}

class FirebaseFile {
  final Reference ref;
  final String url;

  const FirebaseFile({required this.ref, required this.url});
}
