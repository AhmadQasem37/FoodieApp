import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationConfiguration {
  static void getCurrentLocation(void Function(String) callback) async {
    bool serviceEnabled = false;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      callback('Location services are disabled.');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        callback('Location permissions are denied.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      callback('Location permissions are permanently denied, we cannot request permissions.');
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    _getAddressFromLatLng(position, callback);
  }

  static void _getAddressFromLatLng(Position position, void Function(String) callback) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      callback("${place.locality}, ${place.country}");
    } catch (e) {
      callback('Error getting address: $e');
    }
  }
}
