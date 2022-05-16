import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final double coverheight = 150;
  final double profileheight = 80;
  List trainers = [
    "Assets/Images/trainer1.png",
    "Assets/Images/trainer2.png",
    "Assets/Images/trainer3.png",
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
  late Future<List<FirebaseFile>> futurefiles;

  @override
  void initState() {
    super.initState();
    futurefiles = StorageDatabase.listAll('TransformerGymImage/');
  }

  @override
  Widget build(BuildContext context) {
    final top = coverheight - profileheight / 2;
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          color: Colors.grey[100],
          child: Padding(
            padding: const EdgeInsets.only(top: 35.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomLeft,
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: coverheight,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "Assets/Images/rectangle_14.png"),
                                fit: BoxFit.cover)),
                      ),
                      Positioned(
                        top: top,
                        left: 15,
                        child: CircleAvatar(
                          radius: profileheight / 2,
                          backgroundColor: Colors.white,
                          // backgroundImage: AssetImage("assets/rectangle_14.png"),
                        ),
                      )
                    ]),
                const Padding(
                  padding: EdgeInsets.only(left: 12.0, top: 50),
                  child: Text(
                    'Transformers Gym',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 12.0, top: 8.0),
                  child: Text(
                    'Branch - Barakar',
                    style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                InkWell(
                  child: const Padding(
                    padding: EdgeInsets.only(left: 12.0, top: 8.0),
                    child: Text(
                      'Switch Branch',
                      style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  onTap: () {},
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    child: const ListTile(
                      title: Text(
                        'Total booking',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: Text(
                        '06',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12.0, top: 8.0, right: 14),
                  child: Row(
                    children: [
                      const Text(
                        'Photos',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.file_upload_outlined,
                        size: 20,
                      ),
                      InkWell(
                        child: const Text("Add photos",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w600)),
                        onTap: () async {
                          List<XFile>? _images = await multiimagepicker();
                          //  multiimages = await multiimagepicker();
                          if (_images.isNotEmpty) {
                            multiimages = await multiimageuploader(_images);
                            setState(() {});
                          }
                        },
                      )
                    ],
                  ),
                ),
                FutureBuilder<List<FirebaseFile>>(
                    future: futurefiles,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const Center(
                              child: CircularProgressIndicator());
                        default:
                          if (snapshot.hasError) {
                            return const Center(
                                child: Text(" Some error occured!!"));
                          } else {
                            final files = snapshot.data!;

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: SizedBox(
                                height: 200,
                                child: GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 0,
                                            mainAxisSpacing: 12.0),
                                    itemCount: files.length,
                                    itemBuilder: (context, index) {
                                      final file = files[index];
                                      return buildFile(context, file);
                                    }),
                              ),
                            );
                          }
                      }
                    }),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
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
                              padding: EdgeInsets.only(left: 8.0, top: 8.0),
                              child: Text('Rules',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  )),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 12.0, top: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "•  Bring your towel and use it.",
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text("•  Bring seperate shoes.",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      )),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text("•  Re-rack equipments",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      )),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text("•  No heavy lifting without spotter",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      )),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
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
                              padding: EdgeInsets.only(left: 8.0, top: 8.0),
                              child: Text('Trainers',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  )),
                            ),
                            SizedBox(
                              height: 90,
                              child: ListView.builder(
                                  itemCount: trainers.length,
                                  physics: const PageScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        Container(
                                          height: 65,
                                          width: 65,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              //border: Border.all(width: 1),
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      trainers[index]),
                                                  fit: BoxFit.cover)),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                        ),
                                      ],
                                    );
                                  }),
                            ),
                            SizedBox(
                              height: 15,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 6.0),
                                child: ListView.builder(
                                    itemCount: trainername.length,
                                    physics: const PageScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          Text(
                                            trainername[index],
                                            style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.09,
                                          ),
                                        ],
                                      );
                                    }),
                              ),
                            )
                          ],
                        )),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) {
                        return amenities(index);
                      }),
                      separatorBuilder: (context, _) => SizedBox(
                            width: MediaQuery.of(context).size.width * 0.08,
                          ),
                      itemCount: amenities_name.length),
                ),
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
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8.0, top: 10.0, bottom: 14),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(left: 8.0, top: 14.0),
                              child: Text(
                                'Bus stand, Barakar, near pratham lodge',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Poppins",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFile(BuildContext context, FirebaseFile file) => Image.network(
        file.url,
        height: 128,
        width: 127,
      );

  Widget amenities(int index) => Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 6.0),
        child: Container(
          child: FittedBox(
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: 40,
                  child: Icon(
                    icons[index],
                    size: 16,
                  ),
                  //color: Colors.amber,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.amber.shade400,
                  ),
                ),
                Text(
                  amenities_name[index],
                  //textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      );
}

Future<List<XFile>> multiimagepicker() async {
  List<XFile>? _images = await ImagePicker().pickMultiImage();
  if (_images != null && _images.isNotEmpty) {
    return _images;
  }
  return [];
}

Future<String> uploadimage(XFile image) async {
  Reference db = FirebaseStorage.instance
      .ref("TransformerGymImage/${getImageName(image)}");
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
