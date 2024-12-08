import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeoLocation extends StatefulWidget {
  const GeoLocation({super.key});

  @override
  State<GeoLocation> createState() => _GeoLocationState();
}

class _GeoLocationState extends State<GeoLocation> {
  Position? position;

  @override
  void initState() {

    super.initState();
    ListenCurrentLocation();
  }

  Future<void> ListenCurrentLocation() async {
    final isGranted = await isLocationPermissionGranted();
    if (isGranted) {
      final isServiceEnable = await checkGPSServiceEnable();
      if (isServiceEnable) {
        Geolocator.getPositionStream(
          locationSettings: LocationSettings(
           // timeLimit:Duration(seconds: 3),
            distanceFilter: 10,
            accuracy: LocationAccuracy.bestForNavigation
          )
        ).listen((pos){
          print(pos);

        });
      } else {
        Geolocator.openLocationSettings();
      }
    } else {
      final result = await requestLocationPermission();
      if (result) {
        getCurrentLocation();
      } else {
        Geolocator.openAppSettings();
      }
    }

  }


  Future<void> getCurrentLocation() async {
    final isGranted = await isLocationPermissionGranted();
    if (isGranted) {
      final isServiceEnable = await checkGPSServiceEnable();
      if (isServiceEnable) {
        Position p = await Geolocator.getCurrentPosition(
        );
        position=p;
        setState(() {

        });
      } else {
        Geolocator.openLocationSettings();
      }
    } else {
      final result = await requestLocationPermission();
      if (result) {
        getCurrentLocation();
      } else {
        Geolocator.openAppSettings();
      }
    }
  }

  Future<bool> isLocationPermissionGranted() async {
    LocationPermission permession = await Geolocator.checkPermission();
    if (permession == LocationPermission.always ||
        permession == LocationPermission.whileInUse) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> requestLocationPermission() async {
    LocationPermission permession = await Geolocator.requestPermission();
    if (permession == LocationPermission.always ||
        permession == LocationPermission.whileInUse) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkGPSServiceEnable() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("My Current Location$position"),
            ElevatedButton(
                onPressed: () {
                  getCurrentLocation();
                }, child: Text('Get Current Location'))
          ],
        ),
      ),
    );
  }
}
