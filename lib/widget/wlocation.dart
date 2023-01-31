// import 'package:geocoder/geocoder.dart';
// import 'package:location/location.dart';
// //import 'package:geolocator/geolocator.dart';

// class UserLocation {
//   fetchLocation() async {
//     Location location = new Location();
//     LocationData _currentPosition;
//     String _address;
//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;
//     var latitude;
//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         return;
//       }
//     }

//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }

//     _currentPosition = await location.getLocation();
//     print(_currentPosition);
//     location.onLocationChanged.listen((LocationData currentLocation) {
//       _currentPosition = currentLocation;
//       getAddress(_currentPosition.latitude, _currentPosition.longitude)
//           .then((value) {
//         _address = "${value.first.addressLine}";
//         print(_address);
//       });
//     });
//   }

//   Future<List> getAddress(double? lat, double? lang) async {
//     final coordinates = Coordinates(lat, lang);
//     List address =
//         await Geocoder.local.findAddressesFromCoordinates(coordinates);
//     return address;
//   }
// }
