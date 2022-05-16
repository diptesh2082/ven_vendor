import 'package:flutter/material.dart';
import 'package:vyam_vandor/Screens/home__screen.dart';
import 'package:vyam_vandor/Services/check_permission.dart';
import 'package:vyam_vandor/Services/firebase_firestore_api.dart';
import 'package:vyam_vandor/Services/location_service.dart';
import 'package:vyam_vandor/app_colors.dart';

class GetLocationScreen extends StatefulWidget {
  const GetLocationScreen({Key? key}) : super(key: key);

  @override
  _GetLocationScreenState createState() => _GetLocationScreenState();
}

class _GetLocationScreenState extends State<GetLocationScreen> {
  startLocationExtraction() async {
    bool isGranted = await PermissionHandlerApi.getLocationPermissionStatus();
    if (isGranted) {
      //Start GeoLocation and GeoCoding

      await LocationApi().getLocation().then(
            (value) => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) =>  HomeScreen()),
                (route) => false),
          );
      setState(() {
        showLoader = false;
      });
    } else {
      setState(() {
        showLoader = false;
      });
      print("Enable Locaiton ");
    }
  }

  bool showLoader = true;

  @override
  void initState() {
    startLocationExtraction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Location',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: (){
          startLocationExtraction();
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.green,
                size: 80,
              ),
              const Text(
                'Our app needs to access your Current location.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              showLoader
                  ? const CircularProgressIndicator(
                      color: Colors.green,
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
