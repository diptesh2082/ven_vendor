import 'package:geolocator/geolocator.dart';
import 'package:vyam_vandor/Services/firebase_firestore_api.dart';
import 'package:geocoding/geocoding.dart' as g;

class LocationApi {
  Future getLocation() async {
    try {
      print("Getting Location from Geolocator");
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      final lat = position.latitude;
      final long = position.longitude;
      print(position.latitude);
      print(position.longitude);

      MyAddress myAddress = await GeoCoderApi.doGeoencoding(lat, long);
      if (myAddress.address.isNotEmpty || myAddress.pinCode.isNotEmpty) {
        await FirebaseFirestoreAPi().updateLocationtoDatabase(
          lat,
          long,
          myAddress.pinCode,
          myAddress.address,
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class GeoCoderApi {
  static Future doGeoencoding(double lat, double long) async {
    try {
      print("Geo Encoding the given Coordinates");
      List<g.Placemark> list = await g.placemarkFromCoordinates(lat, long);

      return MyAddress(
        "${list[0].subLocality}, ${list[0].locality}",
        list[0].postalCode!,
      );
      //
    } catch (e) {
      print(e.toString());
    }
  }
}

class MyAddress {
  String pinCode;
  String address;

  MyAddress(this.address, this.pinCode);
}
