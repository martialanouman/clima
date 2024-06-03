import 'package:geolocator/geolocator.dart';

class Location {
  Future<Position> getCurrentPosition() async {
    await _checkPermission();
    return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
  }

  _checkPermission() async {
    LocationPermission permission;

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return Future.error("Location service are disabled");

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission are denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permission are permanently denied!");
    }
  }
}
