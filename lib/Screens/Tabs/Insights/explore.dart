import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:vyam_vandor/controllers/gym_controller.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(23.7217038, 86.7921423),
    zoom: 11.5,
  );

  final Completer<GoogleMapController> _controller = Completer();
  final GymController controller = Get.put(GymController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Barakar, West Bengal',
            hintStyle: const TextStyle(fontWeight: FontWeight.bold),
            prefixIcon: SvgPicture.asset(
              'assets/Icons/Search.svg',
              fit: BoxFit.none,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.terrain,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: {barakar, asanol1, asanol2},
          ),
          Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  height: 150.0,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.gymLists.length,
                      itemBuilder: (context, index) {
                        final gym = controller.gymLists[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            children: [
                              _boxes(gym.image, gym.lat, gym.lon, gym.name,
                                  gym.location, gym.address, gym.review)
                            ],
                          ),
                        );
                      }))),
        ],
      ),
    );
  }

  Widget _boxes(String _image, double lat, double long, String name,
      String location, String address, String review) {
    return GestureDetector(
      onTap: () {
        _gotoLocation(lat, long);
      },
      child: FittedBox(
        child: Material(
            color: Colors.white,
            elevation: 14.0,
            borderRadius: BorderRadius.circular(24.0),
            shadowColor: Colors.black87,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: 180,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24.0),
                    child: Image(
                      fit: BoxFit.cover,
                      image: AssetImage(_image),
                    ),
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: myDetailsContainer1(name, location, address, review),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget myDetailsContainer1(
      String name, String location, String address, String review) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            name,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 22.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 5.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Icon(
              CupertinoIcons.location_solid,
              color: Colors.black,
            ),
            Text(
              location,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5.0),
        Text(
          address,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 20.0,
          ),
        ),
        const SizedBox(height: 5.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              CupertinoIcons.star_fill,
              color: Colors.amber,
            ),
            Text(
              review,
              style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        )
      ],
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 12,
    )));
  }
}

Marker barakar = Marker(
    markerId: const MarkerId('barakar'),
    position: const LatLng(23.7264376, 86.8434882),
    infoWindow: const InfoWindow(title: 'Bus Stand, Barakar'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow));

Marker asanol1 = Marker(
    markerId: const MarkerId('asanol1'),
    position: const LatLng(23.6828365, 86.9816039),
    infoWindow: const InfoWindow(title: 'Ashram More, Asanol'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow));

Marker asanol2 = Marker(
    markerId: const MarkerId('asanol2'),
    position: const LatLng(23.6823747, 86.9817005),
    infoWindow: const InfoWindow(title: 'Ashram More, Asanol'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow));
