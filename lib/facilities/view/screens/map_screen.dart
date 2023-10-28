import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Location location = Location();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.6844, 73.0479),
    zoom: 14.4746,
  );
  LatLng? currentP = null;

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _marker.addAll(_list);
    getLocationUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentP == null
          ? Text('Loading')
          : GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: true,
              compassEnabled: true,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: {
                Marker(
                    markerId: MarkerId('1'),
                    icon: BitmapDescriptor.defaultMarker,
                    position: currentP!,
                    infoWindow: InfoWindow(title: 'Source position')),
                Marker(
                    markerId: MarkerId('1'),
                    icon: BitmapDescriptor.defaultMarker,
                    position: LatLng(33.6844, 73.0479),
                    infoWindow: InfoWindow(title: 'My position')),
                Marker(
                    markerId: MarkerId('3'),
                    icon: BitmapDescriptor.defaultMarker,
                    position: LatLng(33.6844, 73.0479),
                    infoWindow: InfoWindow(title: 'My position'))
              },
            ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: const Text('To the lake!'),
      //   icon: const Icon(Icons.directions_boat),
      // ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();

    if (_serviceEnabled) {
      _serviceEnabled = await location.requestService();
    } else {
      return;
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
    }
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
    location.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          print(currentP);
        });
      }
    });
  }
}
