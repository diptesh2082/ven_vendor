import 'package:badges/badges.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:vyam_vandor/Screens/Tabs/support_page.dart';
import 'package:vyam_vandor/Screens/home__screen.dart';
import 'package:vyam_vandor/Screens/login_screen.dart';
import 'package:vyam_vandor/Screens/order_details_screen.dart';
import 'package:vyam_vandor/Services/firebase_firestore_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vyam_vandor/app_colors.dart';
import 'package:get/get.dart';
import 'package:vyam_vandor/controllers/gym_controller.dart';
import 'package:vyam_vandor/widgets/search_function.dart';
import '../../Services/profileicon_icons.dart';
import '../../widgets/active_booking.dart';
import '../../widgets/booking_card.dart';
import '../../widgets/drawer_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/past_booking.dart';
import '../reset_password.dart';
import 'Insights/insights.dart';
import 'notifications.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final String _playStoreUrl =
      "https://play.google.com/store/apps/details?id=com.findnearestfitness.vyamserviceprovider";
  var status = true;
  final GlobalKey<ScaffoldState> _drawerkey = GlobalKey();
  bool showBranches = false;
  bool dot=false;
  final _auth = FirebaseAuth.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  Future getDevicetoken() async {
    try {
      setState(() async {
        device_token = await _firebaseMessaging.getToken();
      });

      print("this is the token $device_token");
      return device_token;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    print("device gym id ${gymId}");
    getDevicetoken();
    super.initState();
  }

  bool isHeightTobeIncreased = false;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SearchCon());
    print("hi this is my gym  $gymId");
    return SafeArea(
      child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("product_details")

              .doc(gymId.toString())
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData==false) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            print("${snapshot.data!.get("gym_status")} ${snapshot.data!.get("landmark")} ${snapshot.data!.get("name")}",);

            return Stack(
              children: [
                Scaffold(
                  key: _drawerkey,
                  backgroundColor: AppColors.backgroundColor,
                  // floatingActionButton: FloatingActionButton(
                  //   onPressed: () {
                  //     // // FirebaseFirestoreAPi().updateTokenToFirebase();
                  //     // FirebaseFirestoreAPi().checkTokenChange();
                  //   },
                  // ),
                  appBar: buildAppBar(
                    context,
                    isGymOpened: snapshot.data!.get("gym_status"),
                    gymLocation: snapshot.data!.get("branch"),
                    gymname: snapshot.data!.get("name"),
                    leadingCallback: () {
                      if (showBranches == false) {
                        _drawerkey.currentState!.openDrawer();
                      }
                    },
                  ),
                  drawer: buildDrawer(context),
                  body: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ListView(
                      children: [
                        Stack(
                          children: [
                            Obx(
                        ()=> Column(
                                //mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  SearchIt(),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  //Upcoming Bookings Cards
                                  if(Get.find<SearchCon>().search.value.isEmpty)
                                  ExpansionTile(
                                    textColor: Colors.purple,
                                    iconColor:Colors.purple,
                                    initiallyExpanded: true,
                                    title: const Text('Upcoming Bookings'),
                                    children: [
                                      StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection('bookings')
                                            .where("vendorId", isEqualTo: gymId)
                                            .where('booking_status',
                                                isEqualTo: 'upcoming')
                                            .orderBy("id", descending: true)
                                            .snapshots(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot snap) {
                                          if (snap.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                              child: CircularProgressIndicator(),
                                            );
                                          }
                                          //
                                          if (snap.data == null) {
                                            return Center(
                                              child: Image.asset(
                                                "Assets/Images/BOOKING_EMPTY .png",
                                              ),
                                            );
                                          }
                                          if (snap.data.docs.isEmpty){
                                            return Center(
                                              child: Image.asset(
                                                "Assets/Images/BOOKING_EMPTY .png",
                                                height: MediaQuery.of(context).size.height*.45,

                                              ),
                                            );
                                          }

                                          var doc = snap.data.docs;
                                          // print(gymId.toString());
                                          // doc = doc.where((element) {
                                          //   return element
                                          //       .get('vendorId')
                                          //       .toString()
                                          //       // .toLowerCase()
                                          //       .contains(gymId.toString());
                                          // }).toList();
                                          // doc = doc.where((element) {
                                          //   return element
                                          //       .get('vendorId')
                                          //       .toString()
                                          //       .toLowerCase()
                                          //       .contains(_auth.currentUser!.email.toString().toLowerCase());
                                          // }).toList();
                                          // print(doc);
                                          return ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: doc.length,
                                            itemBuilder: (context, index) {
                                              // print("device token ${device_token}");
                                              // print(
                                              //     "gfhfhgjfdkdyuuyuyuyuyuyuyuyuyuyuyuyuyuyuyuyuyuyuyuyuyuy ${gymId}");
                                              // print(
                                              //     "gfhfhgjfdkdyuuyuyuyuyuyuyuyuyuyuyuyuyuyuyuyuyuyuyuyuyuy ${gymId}");
                                              // print(
                                              //     "gfhfhgjfdkdyuuyuyuyuyuyuyuyuyuyuyuyuyuyuyuyuyuyuyuyuyuy ${gymId}");
                                              /// UPCOMING BOOKING CARD
                                              if (doc.length == 0) {
                                                return Center(
                                                  child: Image.asset(
                                                      "Assets/Images/BOOKING_EMPTY .png",
                                                  ),
                                                );
                                              }
                                              if (doc[index]['booking_status'] ==
                                                      'upcoming'
                                                  // && doc[index]["vendorId"]==gymId.toString()
                                                  )
                                              // if(doc[index][])
                                              {
                                                return BookingCard(
                                                  userID: doc[index]['userId'] ?? "",
                                                  userName:
                                                      doc[index]['user_name'] ?? "",
                                                  bookingID:
                                                      doc[index]['booking_id'] ?? "",
                                                  bookingPlan: doc[index]
                                                          ['booking_plan'] ??
                                                      "",
                                                  bookingPrice: doc[index]
                                                          ['grand_total'] ??
                                                      "",
                                                  // docs: doc[index],
                                                  bookingdate: DateFormat(
                                                          DateFormat.YEAR_MONTH_DAY)
                                                      .format(doc[index]
                                                              ['booking_date']
                                                          .toDate()),
                                                  otp: int.parse(
                                                      doc[index]['otp_pass']),
                                                  id: doc[index]['id'].toString() ,
                                                );
                                              }
                                              if (doc.length == 0) {
                                                return Center(
                                                  child: Image.asset(
                                                    "assets/Illustrations/vill.jpeg",
                                                  ),
                                                );
                                              }
                                              return Container();
                                            },
                                          );
                                        },
                                      )
                                    ],
                                  ),

                                  ///Active Booking Cards
                                  if(Get.find<SearchCon>().search.value.isEmpty)
                                  ExpansionTile(
                                    textColor: Colors.purple,
                                    iconColor:Colors.purple,
                                    title: const Text('Active Bookings'),
                                    children: [
                                      StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection('bookings')
                                            .where("vendorId", isEqualTo: gymId)
                                            .where('booking_status',
                                                isEqualTo: 'active')
                                            .orderBy("booking_date", descending: true)
                                            .snapshots(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot snap) {
                                          if (snap.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                              child: CircularProgressIndicator(),
                                            );
                                          }
                                          if (snap.data == null) {
                                            return  Center(
                                              child: Image.asset(
                                                "Assets/Images/BOOKING_EMPTY .png",
                                                height: MediaQuery.of(context).size.height*.45,

                                              ),
                                            );

                                          }
                                          if (snap.data.docs.isEmpty){
                                            return Center(
                                              child: Image.asset(
                                                "Assets/Images/BOOKING_EMPTY .png",
                                                height: MediaQuery.of(context).size.height*.45,

                                              ),
                                            );
                                          }
                                          var doc = snap.data.docs;

                                          return ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: doc.length,
                                            itemBuilder: (context, index) {
                                              if (doc[index]['booking_status'] ==
                                                      'active'
                                                  // &&
                                                  // doc[index]['booking_accepted'] ==
                                                  //     true

                                                  ) {
                                                return GestureDetector(
                                                  onTap: () async {
                                                    // print("wewe");
                                                    await OrderDetails(
                                                      userID: doc[index]['userId'],
                                                      bookingID: doc[index]
                                                          ['booking_id'],
                                                      imageUrl: doc[index]
                                                          ["gym_details"]["images"],
                                                    );
                                                  },
                                                  child: ActiveBookingCard(
                                                    userID:
                                                        doc[index]['userId'] ?? "",
                                                    userName:
                                                        doc[index]['user_name'] ?? "",
                                                    bookingID: doc[index]
                                                            ['booking_id'] ??
                                                        "",
                                                    bookingPlan: doc[index]
                                                            ['booking_plan'] ??
                                                        "",
                                                    bookingPrice: double.parse(
                                                        doc[index]['grand_total']
                                                            .toString()),
                                                    bookingdate: doc[index]['booking_date']
                                                        .toDate(),
                                                      //   .format(
                                                      // doc[index]['booking_date']
                                                      //     .toDate(),
                                                    // ),
                                                    end_date: doc[index]['plan_end_duration'].toDate(),

                                                    id: doc[index]['id'].toString(),
                                                  ),
                                                );
                                              }
                                              return Container();
                                            },
                                          );
                                        },
                                      )
                                    ],
                                  ),

                                ],
                              ),
                            ),
                            // Positioned(
                            //     top: 16,
                            //     child: SearchIt())
                          ],
                          alignment: Alignment.center,

                        ),
                      ],
                    ),
                  ),
                ),
                showBranches == false
                    ? Container()
                    : Positioned(
                        top: 80,
                        left: 51,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          width: 280,
                          height: isHeightTobeIncreased ? 400 : 250,
                          child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('product_details')
                                  // .where("gym_id",
                                  //     isEqualTo: FirebaseAuth
                                  //         .instance.currentUser!.email)
                                  .where(
                                    'token',
                                    arrayContains: device_token,
                                  )
                                  .snapshots(),
                              builder: (context, AsyncSnapshot snapshot) {
                                print(device_token);
                                if (snapshot.data == null) {
                                  return Container();
                                }
                                if (snapshot.data.docs.length + 2 > 3) {
                                  isHeightTobeIncreased = true;
                                }
                                if (snapshot.data.docs.length + 2 <= 3) {
                                  isHeightTobeIncreased = false;
                                }
                                if (snapshot.data == ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                print(FirebaseAuth.instance.currentUser!.email);
                                List temp = snapshot.data.docs.toList();
                                if (temp.isEmpty) {
                                  return ListTile(
                                    trailing: const Icon(
                                      Icons.add,
                                      color: Colors.black54,
                                    ),
                                    title: const Text(
                                      'Add another Account',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onTap: () {
                                      print("Add another Login Session");
                                      Get.to(
                                        const LoginScreen(),
                                      );
                                    },
                                  );
                                } else {
                                  return ListView.separated(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: ((context, index) {
                                      if (index == snapshot.data.docs.length) {
                                        print(device_token);
                                        return ListTile(
                                          trailing: const Icon(
                                            Icons.add,
                                            color: Colors.black54,
                                          ),
                                          title: const Text(
                                            'Add another Account',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          onTap: () {
                                            print("Add another Login Session");
                                            Get.to(
                                              const LoginScreen(),
                                            );
                                          },
                                        );
                                      }
                                      return StreamBuilder<Object>(
                                        stream:  FirebaseFirestore.instance
                                            .collection('bookings')
                                            .where("vendorId", isEqualTo:snapshot.data.docs[index]
                                        ["gym_id"])
                                            .where("booking_status", isEqualTo: "upcoming")
                                            .snapshots(),
                                        builder: (context,AsyncSnapshot snapshot1) {
                                          if(snapshot1.connectionState==ConnectionState.waiting){
                                            return Center(child: CircularProgressIndicator());
                                          }
                                          if(snapshot1.data!.docs.isNotEmpty){

                                            dot=true;
                                          }

                                          return Badge(
                                            elevation: snapshot1.data!.docs.isNotEmpty?2:0,
                                            badgeColor: snapshot1.data!.docs.isNotEmpty?Colors.red:Colors.white,
                                            position: BadgePosition.topEnd(
                                              top: 10,
                                              end: 20
                                            ),
                                            child: ListTile(
                                              onTap: () async {
                                                print(snapshot.data.docs[index]
                                                    ["gym_id"]);
                                                var id = await snapshot
                                                    .data.docs[index]["gym_id"];
                                                print(id);
                                                if (mounted)
                                                  setState(() {
                                                    gymId = id;
                                                  });
                                                 InsightsTab().createState();

                                                 await Get.offAll(() => HomeScreen());

                                                // Navigator.pushReplacement(
                                                //     (context),
                                                //     MaterialPageRoute(
                                                //         builder: (context) =>
                                                //             HomeScreen()));
                                                // Navigator.pop(context);
                                              },
                                              title: Text(
                                                snapshot.data.docs[index]['name'],
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                              subtitle: Text(
                                                snapshot.data.docs[index]['branch'],
                                                style: const TextStyle(
                                                  color: Color(0xffBDBDBD),
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      );
                                    }),
                                    separatorBuilder: (context, index) =>
                                        const Divider(
                                      color: Color(0xffD6D6D6),
                                    ),
                                    itemCount: snapshot.data.docs.length + 1,
                                  );
                                }
                              }),
                        ),
                      ),

              ],
              alignment: Alignment.center,
            );
          }),
    );
  }

  AppBar buildAppBar(BuildContext context,
      {required String? gymname,
      required bool? isGymOpened,
      required String? gymLocation,
      Function? leadingCallback}) {
    return AppBar(
      toolbarHeight: kToolbarHeight +10,
      backgroundColor: Colors.transparent,
      primary: true,
      iconTheme: const IconThemeData(color: Colors.black),
      titleSpacing: 0,
      elevation: 0,
      leading: IconButton(
          onPressed: () {
            leadingCallback!();
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
              gymname!,
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
                    gymLocation!,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffBDBDBD),
                    ),
                  ),
                ),
                Badge(
                  position: BadgePosition.topEnd(top: .5),
                  badgeColor: showBranches==false && dot ==true ?Colors.red:Colors.white38,
                  elevation: (showBranches==false && dot ==true) ?2:0,
                  child: Icon(
                    !showBranches
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up,
                    color: const Color(0xff130F26),
                    size: 20,
                  ),
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
              value: isGymOpened!,
              onChanged: (value) {
                FirebaseFirestoreAPi()
                    .updateGymStatusToFirestore(isGymOpened: value);
                print(value);
                // setState(() {
                  status = value;
                // });
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

  Drawer buildDrawer(
    BuildContext context,
  ) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Stack(
        // shrinkWrap: true,
        children: [
          Column(
            children: [
              DrawerTitleWidget(

                callback: () {
                  Navigator.pop(context);
                },
              ),

              InkWell(
                  child: buildDrawerListItem(
                    title: 'Notifications',
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationDetails(),
                        ));
                  }),
              InkWell(
                child: buildDrawerListItem(
                  title: 'Rate us',
                  iconData: 'star',
                ),
                onTap: () async {
                  launchUrlString(_playStoreUrl);
                  //launch(_playStoreUrl);
                },
              ),
              InkWell(
                  child: buildDrawerListItem(
                    title: 'Support',
                    iconData: 'message-question',
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContactUs(),
                        ));
                  }),
            ],
          ),
          Positioned(
            bottom: 150,
            left: 120,
            child: ElevatedButton(
              onPressed: () {
                Get.offAll(() => LoginScreen());
                _auth.signOut();
              },
              child: const Text(
                'Logout',
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  const Color(0xff292F3D),
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(
                    horizontal: 35,
                    vertical: 10,
                  ),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container Search(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .92,
      height: 51,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextField(
          autofocus: false,
          textAlignVertical: TextAlignVertical.bottom,
          onSubmitted: (value) async {
            FocusScope.of(context).unfocus();
          },

          // onChanged: (value) {
          //   if (value.length==0){
          //     FocusScope.of(context).unfocus();
          //   }
          //   if(mounted) {
          //     setState(() {
          //       searchGymName = value.toString();
          //
          //     });
          //   }
          // },

          decoration: const InputDecoration(
            prefixIcon: Icon(Profileicon.search),
            hintText: 'Search',
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }
  //

  ListTile buildDrawerListItem(
      {
        required String? title, String? iconData = 'lock'}) {
    return ListTile(
      minLeadingWidth: 0,
      leading: Image.asset("Assets/Images/$iconData.png"),
      title: Text(
        title!,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),
    );
  }
}
