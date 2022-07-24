import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:vyam_vandor/Screens/Tabs/Insights/insights.dart';
import 'package:vyam_vandor/Screens/Tabs/dashboard_tab.dart';
import 'package:vyam_vandor/Screens/Tabs/home_tab.dart';
import 'package:vyam_vandor/Services/firebase_firestore_api.dart';
import 'package:vyam_vandor/app_colors.dart';
import 'package:vyam_vandor/controllers/gym_controller.dart';

import '../Services/firebase_messaging_api.dart';

class HomeS extends StatelessWidget {
  const HomeS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1));
    print("sd");
    Future<FirebaseRemoteConfig> setupRemoteConfig() async {
      final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.fetch();
      await remoteConfig.activate();
      return remoteConfig;
    }

    return FutureBuilder<FirebaseRemoteConfig>(
      future: setupRemoteConfig(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Container());
        }
        return HomeScreen(remoteConfig: snapshot.requireData);
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  final remoteConfig;
  HomeScreen({Key? key, required this.remoteConfig}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// Future<FirebaseRemoteConfig> setupRemoteConfig() async {
//   final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
//   await remoteConfig.fetch();
//   await remoteConfig.activate();
//   return remoteConfig;
// }

class _HomeScreenState extends State<HomeScreen> {
  final String url =
      "https://play.google.com/store/apps/details?id=com.findnearestfitness.vyamserviceprovider";
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Image.asset(
          "Assets/Images/home_icon.png",
          height: 20,
          width: 20,
          color: AppColors.bottomNaVBarTextColor,
        ),
        title: ('Home'),
        contentPadding: 0,
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          "Assets/Images/insight.png",
          height: 20,
          width: 20,
          color: AppColors.bottomNaVBarTextColor,
        ),
        title: ('Insights'),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          "Assets/Images/dashboard.png",
          // height: 30,
          // width: 30,
          color: AppColors.bottomNaVBarTextColor,
        ),
        iconSize: 40,
        title: ('Dashboard'),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  List<Widget> _buildScreens() {
    return [
      // FutureBuilder<FirebaseRemoteConfig>(
      //   future: setupRemoteConfig(),
      //   builder: (BuildContext context,
      //       AsyncSnapshot<FirebaseRemoteConfig> snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Center(child: CircularProgressIndicator());
      //     }
      //     if (snapshot.hasError) {
      //       return Center(child: Container());
      //     }
      //     return
      //   },
      // ),
      HomeTab(),
      const InsightsTab(),
      const DashBoardScreen(),
    ];
  }

  PersistentTabController? _persistentTabController;

  var status = false;

  @override
  void initState() {
    var update = widget.remoteConfig.getBool("vendorupdate");
    print("+++++++cvsdas+++++++$update");
    super.initState();
    // gymId=widget.email;

    setState(() {
      InsightsTab();
    });
    InsightsTab().createState();
    FirebaseMessagingApi().getDevicetoken();
    FirebaseMessagingApi().initialize(context);
    FirebaseMessagingApi().onbackgroundMessageClick(context);
    FirebaseMessagingApi().getforegroundMessages();
  }

  AlertDialog showAlertDialog(
      BuildContext context, FirebaseRemoteConfig remoteConfig) {
    Widget cancel = TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text("Cancel"));
    Widget update = SizedBox(
        width: 140,
        height: 45,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color.fromRGBO(247, 188, 40, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // <-- Radius
            ),
          ),
          onPressed: () async {
            var urllaunchable = await canLaunchUrlString(url);
            if (urllaunchable) {
              await launchUrlString(url);
            } else {
              print("Try Again");
            }
          },
          child: Text(
            "Update Now",
            style: GoogleFonts.poppins(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ));

    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0))),
      contentPadding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      // title: ,
      content: Container(
        height: 550,
        width: 600,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 300, child: Image.asset('Assets/Images/roc.png')),
            SizedBox(
              height: 20,
            ),
            Text(
              remoteConfig.getString("Title"),
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(remoteConfig.getString("Message"),
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500)),
            SizedBox(
              height: 70,
            ),
            update,
          ],
        ),
      ),
      // actions: <Widget>[update],
    );
  }

  @override
  Widget build(BuildContext context) {
    var update = widget.remoteConfig.getBool("vendorupdate");
    print("%%%%%%%%%%%%%%$update");
    Get.lazyPut(() => BookingController(), fenix: true);
    return update
        ? Container(
            color: Colors.white,
            child: showAlertDialog(context, widget.remoteConfig))
        : SafeArea(
            child: Scaffold(
              backgroundColor: const Color(0xffF4F4F4),
              bottomNavigationBar: PersistentTabView(
                context,
                controller: _persistentTabController,
                navBarHeight: 65,
                screens: _buildScreens(),
                items: _navBarsItems(),
                confineInSafeArea: true,
                backgroundColor: Colors.white,
                handleAndroidBackButtonPress: true,
                resizeToAvoidBottomInset: true,
                stateManagement: true,
                hideNavigationBarWhenKeyboardShows: true,
                popAllScreensOnTapOfSelectedTab: true,
                popActionScreens: PopActionScreensType.all,
                itemAnimationProperties: const ItemAnimationProperties(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.ease,
                ),
                screenTransitionAnimation: const ScreenTransitionAnimation(
                  animateTabTransition: true,
                  curve: Curves.ease,
                  duration: Duration(milliseconds: 200),
                ),
                navBarStyle: NavBarStyle.style3,
              ),
            ),
          );
  }
}
