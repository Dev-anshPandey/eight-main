import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationMap extends StatefulWidget {
  Future<String> UsrLocality() async {
    Location location = new Location();
    LocationData _currentPosition;
    var _address;
    bool _serviceEnabled;
    var locality;
    
    PermissionStatus _permissionGranted;
   
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return "";
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return "";
      }
    }

    _currentPosition = await location.getLocation();
    print(_currentPosition);
    Coordinates coordinates = await Coordinates(
        _currentPosition.latitude!, _currentPosition.longitude!);
    print(_currentPosition.latitude);
    print(coordinates);
    _address = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = _address.first;
    locality = first.locality.toString(); 
    return locality.toString();
  }
   Future<String> UsrFn() async {
    Location location = new Location();
    LocationData _currentPosition;
    var _address;
    bool _serviceEnabled;
    var featureName;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return "";
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return "";
      }
    }

    _currentPosition = await location.getLocation();
    print(_currentPosition);
    Coordinates coordinates = await Coordinates(
        _currentPosition.latitude!, _currentPosition.longitude!);
    print(_currentPosition.latitude);
    print(coordinates);
    _address = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = _address.first;
    featureName = first.featureName.toString();
    return featureName.toString();
  }

  @override
  State<LocationMap> createState() => _MapState();
}

String topDisplayAddress = "";
LocationMap usrloc = LocationMap();
Future<String> topAddress() async {
  usrloc.UsrLocality().then((value) async {
    topDisplayAddress = await value[0];
    print(topDisplayAddress);
  });
  return topDisplayAddress;
}

bottomAddress() {
  usrloc.UsrLocality().then((value) {
    print(value.toString());
    String bottomDisplayAddress = value[0];
    return bottomDisplayAddress;
  });
}

class _MapState extends State<LocationMap> {
  // _StatefulWidgetDemoState() {
  //   topAddress().then((val) => setState(() {
  //         topDisplayAddress= val;
  //       }))
  Completer<GoogleMapController> _controller = Completer();
  final CameraPosition _kGooglePlex =
      const CameraPosition(target: LatLng(28.7041, 77.1025), zoom: 14.4746);
  final List<Marker> _marker = [];
  final List<Marker> _markerList = [
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(28.7041, 77.1025),
        infoWindow: InfoWindow(title: 'My Location'))
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_markerList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: GoogleMap(
                    initialCameraPosition: _kGooglePlex,
                    myLocationEnabled: true,
                    markers: Set.of(_marker),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 6.0),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.cancel, color: Colors.grey, size: 40)),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.72,
                  left: MediaQuery.of(context).size.width * 0.2,
                  child: Container(
                    width: 210,
                    height: 40,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ))),
                        child: Row(
                          children: [
                            Icon(
                              Icons.gps_fixed,
                              color: Color(0xff8BDF85),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Use Current Location",
                                style: TextStyle(
                                  color: Color(0xff8BDF85),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ))
                          ],
                        )),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 18),
              child: FutureBuilder(
                  future: usrloc.UsrLocality(),
                  initialData: "Loading..",
                  builder: (BuildContext context, AsyncSnapshot<String> text) {
                     print(text.data.toString());
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       
                        Text(
                          text.data.toString(),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right:8.0),
                          child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Color(0xff8BDF85))
                              ))),
                          child: Row(
                           
                            children: const [
                              Icon(
                                Icons.gps_fixed,
                                color: Color(0xff8BDF85),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("CHANGE",
                                  style: TextStyle(
                                    color: Color(0xff8BDF85),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ))
                            ],
                          )),
                        ),

                      ],
                    );
                  }),
            ),
            Row(
              children: [
               const  Padding(
                  padding: const EdgeInsets.only(top:5.0, left:18),
                  child: Icon(Icons.location_on , color: Color(0xff8BDF85),),
                ),
                Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 18),
              child: FutureBuilder(
                  future: usrloc.UsrFn(),
                  initialData: "Loading..",
                  builder: (BuildContext context, AsyncSnapshot<String> text) {
                     print(text.data.toString());
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          text.data.toString(),
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        ),
                        

                      ],
                    );
                  }),
            )
              ],
            ),
          
          Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: Container(
             height: MediaQuery.of(context).size.height*0.051,
              width: double.infinity,
              color: Color(0xff8BDF85),
              child: Center(child: Text("Confirm" , style: TextStyle(color: Colors.white ,fontSize: 18), )),
            ),
          )
          ],
        ),
      ),
    );
  }
}
