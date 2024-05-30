import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapPage(),
    );
  }
}

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const LatLng _initialPosition =
      LatLng(10.642229786868436, 122.23086118207644);
  static const LatLng _targetPosition =
      LatLng(10.643732008938223, 122.23491136673093);

  late GoogleMapController _controller;

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map Page"),
      ),
      body: Center(
        child: Container(
          width: 300, // Adjust the width as needed
          height: 200, // Adjust the height as needed
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 15,
            ),
            markers: {
              Marker(
                markerId: MarkerId("_currentLocation"),
                icon: BitmapDescriptor.defaultMarker,
                position: _initialPosition
              ),
              Marker(
                markerId: MarkerId("_targetLocation"),
                icon: BitmapDescriptor.defaultMarker,
                position: _targetPosition
              ),
            },
          ),
        ),
      ),
    );
  }
}
