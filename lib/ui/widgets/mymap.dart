import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Completer<GoogleMapController> _controller = Completer();
  LatLng _myPosition = LatLng(8.3178, 77.0709);
  @override
  void initState() {
    _getPosition();
    super.initState();
  }
  void _getPosition() async{
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
     _myPosition = LatLng(position.latitude, position.longitude);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: _myPosition, zoom: 14)));
    print(_myPosition);
  }
  @override
  Widget build(BuildContext context) {
      return Container(
      // height: 150,
      child: GoogleMap(
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          mapType: MapType.terrain,
          initialCameraPosition: CameraPosition(target: _myPosition, zoom: 15),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },


        ),
      );
  }



}
