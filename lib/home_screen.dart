


import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController googleMapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Screen'),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:
            CameraPosition(target: LatLng(25.001352, 88.803456), zoom: 16),
        onTap: (LatLng? latlag) {
          print(latlag);
        },
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
        },
        trafficEnabled: true,
        markers: <Marker>{
          Marker(
            markerId: MarkerId('initial-position'),
            position: LatLng(25.001194544202562, 88.80355942994356),
            infoWindow: InfoWindow(title: 'Amader Mosjid'),
            onTap: () {
              print('On Tap Amader Mosjid');
            },
          ),
          Marker(
            markerId: MarkerId('Home'),
            position: LatLng(25.003586510068306, 88.80471210926771),
            infoWindow: InfoWindow(
              title: 'Home',
            ),
            onTap: () {
              print('On tap home');
            },
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            draggable: true,
            onDragStart: (LatLng onStartLatLng) {
              print('On start drag $onStartLatLng');
            },
            onDragEnd: (LatLng onStopLatLng) {
              print('On End Drag $onStopLatLng');
            },
          ),
        },
        circles: <Circle>{
          Circle(
              circleId: CircleId('initial_id'),
              fillColor: Colors.red.withOpacity(0.3),
              center: LatLng(25.001194544202562, 88.80355942994356),
              radius: 300,
              strokeColor: Colors.blue,
              strokeWidth: 1,
              onTap: () {
                print('Enter into Dengue zone');
              }),
          Circle(
              circleId: CircleId('blue-circle'),
              fillColor: Colors.blue.withOpacity(0.3),
              center: LatLng(25.003586510068306, 88.80471210926771),
              radius: 300,
              strokeColor: Colors.blue,
              strokeWidth: 1,
              onTap: () {
                print('Enter into Dengue zone');
              }),
        },
        polylines: <Polyline>{
          Polyline(
              polylineId: PolylineId('random'),
              color: Colors.black,
              jointType: JointType.mitered,
              points: <LatLng>[
                LatLng(25.00265033080389, 88.80476977676153),
                LatLng(25.00265033080389, 88.80661144852638),
                LatLng(25.00264698837892, 88.80790494382381),
                LatLng(25.00251967230614, 88.80946531891823)
              ]),
        },
        polygons: <Polygon>{
          Polygon(
              polygonId: PolygonId('poly-id'),
              fillColor: Colors.pink.withOpacity(0.3),
              points: <LatLng>[
                LatLng(24.998026150853075, 88.80153067409992),
                LatLng(24.996442075477947, 88.80196753889322),
                LatLng(24.999836584524335, 88.80858421325684),
                LatLng(25.006216950264573, 88.80930002778769),
                LatLng(25.00539655795706, 88.79871938377619),
                LatLng(24.997419932207418, 88.79828251898289),
              ])
        },
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          googleMapController
              .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            zoom: 17,
            target: LatLng(25.001194544202562, 88.80355942994356),
          )));
        },
        child: Icon(Icons.location_history),
      ),
    );
  }
}
