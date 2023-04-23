import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MapPage extends ConsumerStatefulWidget {
  static const routeName = '/map';

  const MapPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late StreamSubscription<Position> positionStream;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getUserCurrentLocation();
    });
    super.initState();
  }

  void _listenToLocationChanges() {
    positionStream = Geolocator.getPositionStream(
      locationSettings:
          const LocationSettings(timeLimit: Duration(milliseconds: 5000)),
    ).listen((Position value) async {
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 14,
      );

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    });
  }

  @override
  void dispose() {
    positionStream.cancel();
    super.dispose();
  }

  Future<void> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
    });
    _listenToLocationChanges();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        myLocationEnabled: true,
        compassEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: const CameraPosition(
          target: LatLng(0, 0),
          zoom: 14,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
