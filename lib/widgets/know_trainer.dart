import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';

// class TrainerScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       builder: () => MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: Trainer(),
//       ),
//     );
//   }
// }

class Trainer extends StatefulWidget {
  @override
  _TrainerState createState() => _TrainerState();
}

class _TrainerState extends State<Trainer> {
  final double profileheight = 65;
  var stream = FirebaseFirestore.instance
      .collection("product_details")
      .doc("${Get.arguments["gym_id"]}")
      .collection("trainers")
      .snapshots();

  int _current1 = 1;
  // List trainers = [
  //   "assets/trainer1.png",
  //   "assets/trainer2.png",
  //   "assets/trainer3.png",
  // ];

  final trainername = ['Jake Paul', 'Jim Harry', 'Kim Jhonas'];
  final trainernames = ['Jake', 'Jim', 'Kim'];
  List tinforeview = ["4.7", "4.9", "5.0"];
  List tinfoclient = ["13", "100", "75"];
  List tinfoexp = ["10+", "7+", "13+"];
  final profile_pic = Get.arguments["image"];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(Get.arguments["image"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 24,
          ),
        ),
        title: Transform(
          transform: Matrix4.translationValues(0, 0, 0),
          child: FittedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Know your trainer',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    _current1.toString(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                  const Text("/",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400)),
                  Text(trainername.length.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400))
                ])
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 12),
          // color: Colors.grey,
          height: MediaQuery.of(context).size.height * 0.8,
          child: SafeArea(
            child: StreamBuilder(
                stream: stream,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.amberAccent,
                      ),
                    );
                  }
                  var document = snapshot.data!.docs;
                  return PageView.builder(
                    itemCount: document.length,
                    controller: PageController(viewportFraction: 0.850),
                    onPageChanged: (int index) => setState(() {
                      _current1 = index + 1;
                    }),
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              // color: Colors.grey,
                              width: MediaQuery.of(context).size.width *8,
                              child: Column(
                                children: [
                                  Stack(
                                      clipBehavior: Clip.none,
                                      alignment: Alignment.bottomLeft,
                                      children: [
                                        Container(
                                          width: double.maxFinite,
                                          height: 120,

                                          decoration: BoxDecoration(
                                            // color: Colors.white,
                                              borderRadius:
                                              const BorderRadius.only(
                                                  topLeft:
                                                  Radius.circular(8),
                                                  topRight:
                                                  Radius.circular(8)),
                                              image: DecorationImage(
                                                  image:
                                                  CachedNetworkImageProvider(
                                                    profile_pic,
                                                  ),
                                                  fit: BoxFit.cover)),
                                        ),
                                        Positioned(
                                          top: (120 - profileheight / 1.2),
                                          left: 15,
                                          child:CircleAvatar(
                                            radius: 50,
                                            backgroundColor: Colors.white,
                                            // backgroundImage: AssetImage(document[]),

                                            backgroundImage: CachedNetworkImageProvider(
                                              document[index]['images'],
                                            ),
                                          ),
                                        )
                                      ]
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  // Column(
                                  //   children: [
                                  //
                                  //   ],
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 6.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                // trainername[index]
                                                document[index]['name'],
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16),
                                              ),
                                              const Icon(
                                                Icons.verified,
                                                color: Colors.green,
                                                size: 20,
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Row(
                                          children: [
                                            Column(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 3.0, top: 6.0),
                                                  child: Text(
                                                    ' Transformers Gym',
                                                    style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 4.0),
                                                  child: Text(
                                                    'Branch - Barakar',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),

                                            Padding(
                                              padding: const EdgeInsets.only(right: 25.0),
                                              child: Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.circular(10.0),
                                                    child: Container(
                                                      height: 25,
                                                      width: 30,
                                                      decoration: const BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          //color: Colors.amber,
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  "Assets/Images/insta_icon.png"))),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    child: Text(
                                                      '@${trainernames[index].toLowerCase()}',
                                                      //document[index]['social_media'],
                                                      style: const TextStyle(
                                                          decoration:
                                                          TextDecoration.underline,
                                                          fontFamily: 'Poppins',
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 13),
                                                    ),
                                                    onTap: null,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height:5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              document[index]['review'],
                                              //textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14),
                                            ),
                                            Text(
                                              document[index]['clients'],
                                              //textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14),
                                            ),
                                            Text(
                                              document[index]['experience'],
                                              //textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                          MediaQuery.of(context).size.height * 0.001,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              '  Reviews',
                                              //textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                            ),
                                            Text(
                                              'Clients',
                                              //textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                            ),
                                            Text(
                                              'Experience',
                                              //textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                        const Divider(
                                          height: 9,
                                          indent: 20,
                                          endIndent: 20,
                                          thickness: 0.5,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: const [
                                              Text(
                                                'About',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                        FittedBox(
                                          fit: BoxFit.contain,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 5,bottom: 5),
                                            child: FittedBox(
                                              child: SizedBox(
                                                width: MediaQuery.of(context).size.width *
                                                    0.90,
                                                child: AutoSizeText(
                                                  //'${trainernames[index]} is a professional trainer and nutritionist who has 10 years of experience in this field.'
                                                  document[index]['about'],
                                                  style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                  ),
                                                  maxLines: 3,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: const [
                                              Text(
                                                'Certifications',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          //height: MediaQuery.of(context).size.height * 0.005,
                                          height: 3,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 18.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              FittedBox(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    for (var i in document[index]['certifications'])
                                                      Text(
                                                        // "•  Golds gym certified trainer."
                                                        ". ${i}",
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          fontFamily: 'Poppins',
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      ),

                                                    /* const SizedBox(
                                      height: 8,
                                    ),
                                    const Text("•  Golds gym certified nutritionist.",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                          )),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text("•  All time calisthenics champion.",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                          )),*/
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          //height: MediaQuery.of(context).size.height * 0.022,
                                          height: 12,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: const [
                                              Text(
                                                'Specialization',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        FittedBox(
                                          fit: BoxFit.contain,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  // height: MediaQuery.of(context).size.height * 0.052
                                                  height: 12,
                                                ),
                                                SizedBox(
                                                  width:
                                                  MediaQuery.of(context).size.width *
                                                      0.90,
                                                  child: Row(
                                                    children: [
                                                      for (var i in document[index]['specialization'])
                                                        AutoSizeText(
                                                          // 'Bodybuilding | Workout | Calesthenics | Zumba | HIIT | Cardio | Diet & Nutrition.'
                                                          "${document[index]['specialization'][0]}  | ",
                                                          style: const TextStyle(
                                                            fontFamily: 'Poppins',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: 12,
                                                          ),
                                                          maxLines: 3,
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          //   height: MediaQuery.of(context).size.height * 0.008,
                                          height: 12,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: const [
                                              Text(
                                                'Reviews',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                              size: 18,
                                            ),
                                            Text(
                                              document[index]['review'],
                                              style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 12),
                                            ),
                                            const Text(
                                              '(33 reviews)',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width *
                                                  0.15,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 12.0),
                                              child: Container(
                                                width: MediaQuery.of(context).size.width *
                                                    0.28,
                                                height:
                                                MediaQuery.of(context).size.height *
                                                    0.055,
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      height: 30,
                                                      width: 30,
                                                      decoration: const BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          //border: Border.all(width: 1),
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  "Assets/Images/trainer1.png"),
                                                              fit: BoxFit.cover)),
                                                    ),
                                                    Positioned(
                                                      left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          0.055,
                                                      child: Container(
                                                        height: 30,
                                                        width: 30,
                                                        decoration: const BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            //border: Border.all(width: 1),
                                                            image: DecorationImage(
                                                                image: AssetImage(
                                                                    "Assets/Images/trainer2.png"),
                                                                fit: BoxFit.cover)),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          0.11,
                                                      child: Container(
                                                        height: 30,
                                                        width: 30,
                                                        decoration: const BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            //border: Border.all(width: 1),
                                                            image: DecorationImage(
                                                                image: AssetImage(
                                                                    "Assets/Images/trainer3.png"),
                                                                fit: BoxFit.cover)
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          0.166,
                                                      child: Container(
                                                        height: 30,
                                                        width: 30,
                                                        decoration: const BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            //border: Border.all(width: 1),
                                                            image: DecorationImage(
                                                                image: AssetImage(
                                                                    "Assets/Images/trainer1.png"),
                                                                fit: BoxFit.cover)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width *
                                                  0.001,
                                            ),
                                            // GestureDetector(
                                            //   child: const Icon(
                                            //     Icons.arrow_forward_ios_outlined,
                                            //     size: 20,
                                            //   ),
                                            //   onTap: () {
                                            //     Navigator.push(
                                            //         context,
                                            //         MaterialPageRoute(
                                            //             builder: (context) => Review()));
                                            //   },
                                            // ),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),

                          ],
                        ),
                      );
                    },
                  );
                }),
          ),
        ),
      ),
    );
  }
  // PageView.builder(
  // itemCount: 3,
  // controller: PageController(viewportFraction: 0.845),
  // onPageChanged: (int index) => setState(() {
  // _current1 = index + 1;
  // }),
  // itemBuilder: ((_, i) {
  // return buildtrainer(context, i);
  // })),

  Widget buildtrainer(BuildContext context, int index) => SafeArea(
    child: Card(
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: StreamBuilder(
          stream: stream,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.amberAccent,
                ),
              );
            }
            var document = snapshot.data!.docs;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomLeft,
                      children: [
                        Container(
                          width: double.maxFinite,
                          height: 120,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12)),
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    profile_pic,
                                  ),
                                  fit: BoxFit.cover)),
                        ),
                        Positioned(
                          top: (120 - profileheight / 1.2),
                          left: 15,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            // backgroundImage: AssetImage(document[]),

                            backgroundImage: CachedNetworkImageProvider(
                                document[index]['images'][0]),
                          ),
                        )
                      ]),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        // trainername[index]
                        document[index]['name'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                      const Icon(
                        Icons.verified,
                        color: Colors.green,
                        size: 20,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 6.0, top: 6.0),
                          child: Text(
                            ' Transformers Gym',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 6.0, top: 4.0),
                          child: Text(
                            'Branch - Barakar',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              height: 25,
                              width: 30,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  //color: Colors.amber,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "Assets/Images/insta_icon.png"))),
                            ),
                          ),
                          GestureDetector(
                            child: Text(
                              '@${trainernames[index].toLowerCase()}',
                              //document[index]['social_media'],
                              style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13),
                            ),
                            onTap: null,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      document[index]['review'],
                      //textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 14),
                    ),
                    Text(
                      document[index]['clients'],
                      //textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 14),
                    ),
                    Text(
                      document[index]['experience'],
                      //textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.001,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '  Reviews',
                      //textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.grey),
                    ),
                    Text(
                      '      Clients',
                      //textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.grey),
                    ),
                    Text(
                      'Experience',
                      //textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.grey),
                    ),
                  ],
                ),
                const Divider(
                  height: 30,
                  indent: 20,
                  endIndent: 20,
                  thickness: 0.5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'About',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
                FittedBox(
                  fit: BoxFit.contain,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: AutoSizeText(
                        //'${trainernames[index]} is a professional trainer and nutritionist who has 10 years of experience in this field.'
                        document[index]['about'],
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                        maxLines: 3,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'Certifications',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  //height: MediaQuery.of(context).size.height * 0.005,
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            // "•  Golds gym certified trainer."
                            "•  ${document[index]['certifications'][0]}",
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          /* const SizedBox(
                                height: 8,
                              ),
                              const Text("•  Golds gym certified nutritionist.",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  )),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text("•  All time calisthenics champion.",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  )),*/
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  //height: MediaQuery.of(context).size.height * 0.022,
                  height: 14,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'Specialization',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
                FittedBox(
                  fit: BoxFit.contain,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          // height: MediaQuery.of(context).size.height * 0.052
                          height: 12,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.90,
                          child: AutoSizeText(
                            // 'Bodybuilding | Workout | Calesthenics | Zumba | HIIT | Cardio | Diet & Nutrition.'
                            "${document[index]['specialization'][0]}  | ",
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  //   height: MediaQuery.of(context).size.height * 0.008,
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'Reviews',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 18,
                    ),
                    Text(
                      document[index]['review'],
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 12),
                    ),
                    const Text(
                      '(33 reviews)',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.28,
                        height: MediaQuery.of(context).size.height * 0.055,
                        child: Stack(
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  //border: Border.all(width: 1),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/trainer1.png"),
                                      fit: BoxFit.cover)),
                            ),
                            Positioned(
                              left:
                              MediaQuery.of(context).size.width * 0.055,
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    //border: Border.all(width: 1),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/trainer2.png"),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                            Positioned(
                              left:
                              MediaQuery.of(context).size.width * 0.11,
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    //border: Border.all(width: 1),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/trainer3.png"),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                            Positioned(
                              left:
                              MediaQuery.of(context).size.width * 0.166,
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    //border: Border.all(width: 1),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/trainer1.png"),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.001,
                    ),
                    // GestureDetector(
                    //   child: const Icon(
                    //     Icons.arrow_forward_ios_outlined,
                    //     size: 20,
                    //   ),
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => Review()));
                    //   },
                    // ),
                  ],
                ),
              ],
            );
          }),
    ),
  );
}
