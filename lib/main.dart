import 'package:flutter/material.dart';
import 'package:module21_google_map_with_rafat/geo_location.dart';
import 'package:module21_google_map_with_rafat/home_screen.dart';

void main(){
  runApp(const GoogleMapsApp());
}

class GoogleMapsApp extends StatelessWidget {
  const GoogleMapsApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:GeoLocation(),
    );
  }
}
