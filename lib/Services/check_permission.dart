import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerApi {
  static Future getLocationPermissionStatus() async {
    var status = await Permission.location.status;

    if (status.isGranted) {
      print("Location Permission is Enabled");
      return true;
    }
    if (status.isDenied) {
      Permission.location.request();
    }

    if (status.isDenied) {
      print("Please Enable Permission ");
      return false;
    }
    if (await Permission.location.isRestricted) {
      return false;
    }
  }
}
