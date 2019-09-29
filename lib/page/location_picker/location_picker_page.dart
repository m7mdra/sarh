import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPickerScreen extends StatefulWidget {
  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  Completer<GoogleMapController> _controller = Completer();
  bool _isCameraMoving = false;
  var _markers = Set<Marker>();
  var _marker = Marker(
      markerId: MarkerId("marker"), position: LatLng(25.276987, 55.296249));

  @override
  void initState() {
    super.initState();
    _markers.add(_marker);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick a location'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _isCameraMoving
            ? null
            : () {
                Navigator.pop(context, Location.fromLatLng(_marker.position));
              },
        label: Text('Select current location'),
        disabledElevation: 0,
        icon: Icon(Icons.check),
      ),
      body: SafeArea(
        child: GoogleMap(
          zoomGesturesEnabled: true,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          markers: _markers,
          onMapCreated: (map) {
            _controller.complete(map);
          },
          onCameraIdle: () {
            setState(() {
              _isCameraMoving = false;
            });
          },
          onCameraMove: (position) {
            setState(() {
              _markers.remove(_marker);
              var newMarker = Marker(
                  markerId: MarkerId("marker"),
                  position: position.target,
                  infoWindow: InfoWindow(title: 'this is you'));
              _markers.add(newMarker);
              this._marker = newMarker;
              _isCameraMoving = true;
            });
          },
          initialCameraPosition:
              CameraPosition(target: LatLng(25.276987, 55.296249), zoom: 12),
        ),
      ),
    );
  }
}

class Location {
  final double latitude;
  final double longitude;

  Location(this.latitude, this.longitude);

  factory Location.fromLatLng(LatLng latLng) =>
      Location(latLng.latitude, latLng.longitude);

  @override
  String toString() {
    return '$latitude,$longitude';
  }
}
