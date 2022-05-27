import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:vyam_vandor/Screens/home__screen.dart';
import 'package:vyam_vandor/Services/firebase_firestore_api.dart';

class DashboardMap extends StatefulWidget {
  const DashboardMap({
    Key? key,
  }) : super(key: key);

  @override
  State<DashboardMap> createState() => _DashboardMapState();
}

class _DashboardMapState extends State<DashboardMap> {
  Completer<GoogleMapController> _controller = Completer();
  LocationData? _currentPosition;
  LatLng? _latLong;
  bool? _locating = false;
  geocoding.Placemark? _placeMark;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    _getUserLocation();
    super.initState();
  }

  Future<LocationData> _getLocationPermission() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return Future.error("Service na hoi tani");
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return Future.error("Permission nai dihal ba");
      }
    }

    _locationData = await location.getLocation();
    return _locationData;
  }

  _getUserLocation() async {
    _currentPosition = await _getLocationPermission();

    _goToCurrentPosition(
        LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!));
  }

  getUserAddress() async {
    List<geocoding.Placemark> placemarks = await geocoding
        .placemarkFromCoordinates(_latLong!.latitude, _latLong!.longitude);
    setState(() {
      _placeMark = placemarks.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .75,
                  decoration: const BoxDecoration(
                      border:
                          const Border(bottom: BorderSide(color: Colors.grey))),
                  child: Stack(
                    children: [
                      GoogleMap(
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        mapType: MapType.terrain,
                        initialCameraPosition: _kGooglePlex,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                        onCameraMove: (CameraPosition position) {
                          setState(() {
                            _locating = true;
                            _latLong = position.target;
                          });
                        },
                        onCameraIdle: () {
                          setState(() {
                            _locating = false;
                          });
                          getUserAddress();
                        },
                      ),
                      Center(
                          child: Icon(
                        Icons.location_on_rounded,
                        size: 40,
                        color: Colors.black,
                      )),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      _placeMark != null
                          ? Column(
                              children: [
                                Text(_locating!
                                    ? "Khujchi.."
                                    : "${_placeMark!.subLocality!} ${_placeMark!.locality!}${_placeMark!.street!} ${_placeMark!.administrativeArea!}  ${_placeMark!.name!} ${_placeMark!.postalCode!}"),
                                SizedBox(
                                  height: 8,
                                ),
                                //if(_placeMark!.subLocality!=null)
                                // Text('${_placeMark!.subLocality!},'),
                                //if(_placeMark!.subAdministrativeArea!=null)
                                //  Text('${_placeMark!.subAdministrativeArea!},')
                              ],
                            )
                          : Container()
                    ],
                  ),

                  // Text(  _locating! ? 'Khujchi..' : _placeMark==null?'':_placeMark!.country!),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: ElevatedButton(
          onPressed: () async{
          await  FirebaseFirestore.instance.collection("product_details")
                .doc(gymId.toString())
                .update({
              "legit":true,
              "address":"${_placeMark!.subLocality!} ${_placeMark!.locality!}${_placeMark!.street!} ${_placeMark!.administrativeArea!}  ${_placeMark!.name!} ${_placeMark!.postalCode!}",
              "locality":"${_placeMark!.locality!}",
              "location":GeoPoint(_latLong!.latitude,_latLong!.longitude)
            });
            Get.off(()=>HomeScreen());
          },
          child: Text("Get Address"),
          style: ElevatedButton.styleFrom(
            primary: Color(0xff292F3D),
          ),
        ),
      ),
    );
  }

  Future<void> _goToCurrentPosition(LatLng latLng) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(latLng.latitude, latLng.longitude),
        //tilt: 59.440717697143555,
        zoom: 14.4746)));
  }
}
