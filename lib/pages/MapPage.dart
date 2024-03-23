import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../model/Actualite.dart';
import '../webservice/api_service.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late final Set<Marker> _markers = {};
  late List<Actualite> _actualites = [];
  late GoogleMapController mapController;

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    await _fetchActualites();
    _populateMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        markers: _markers,
        initialCameraPosition: const CameraPosition(
          target: LatLng(45.764043, 4.835659),
          zoom: 11,
        ),
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
          Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()),
        },
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _fetchActualites() async {
    try {
      final List<dynamic> data = await ActuApi.instance.fetchActualites();
      setState(() {
        _actualites = data.map((e) => Actualite.fromJson(e)).toList();
        _actualites.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching actualites: $e');
      }
    }
  }

  void _populateMarkers() {
    _markers.clear();
    _markers.addAll(_actualites.map((actualite) => Marker(
      markerId: MarkerId(actualite.id.toString()),
      position: LatLng(actualite.latitude, actualite.longitude),
      infoWindow:
      InfoWindow(title: actualite.title, snippet: actualite.description),
    )));
  }

}
