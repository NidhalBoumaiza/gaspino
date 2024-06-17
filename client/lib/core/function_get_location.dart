import 'package:geolocator/geolocator.dart';

Future<dynamic> getCurrentLocation() async {
  bool serviceEnable = await Geolocator.isLocationServiceEnabled();
  if (serviceEnable) {
    LocationPermission checkpermission = await Geolocator.checkPermission();

    if (checkpermission == LocationPermission.denied) {
      LocationPermission requestpermission =
      await Geolocator.requestPermission();
      if (requestpermission == LocationPermission.whileInUse) {
        // Handle the case when permission is granted while the app is in use
      }
    } else {
      var cordonne = await Geolocator.getCurrentPosition();

      return cordonne;
    }
  } else {
    bool locationOpened = await Geolocator.openLocationSettings();
  }
  return null;
}

// void liveLocation() {
//   LocationSettings locationSettings = const LocationSettings(
//     accuracy: LocationAccuracy.bestForNavigation,
//     distanceFilter: 100,
//   );
//
//   Geolocator.getPositionStream(locationSettings: locationSettings)
//       .listen((Position position) {
//     controllerSignUpSteps.latitude = position.latitude;
//     controllerSignUpSteps.longitude = position.longitude;
//   });
// }

// Future<String?> GetAddressFromLatLong(lat, long) async {
//   List<Placemark> placemark = await placemarkFromCoordinates(lat, long);
//   return placemark[0].street;
// }
