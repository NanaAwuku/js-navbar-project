import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animarker/core/ripple_marker.dart';
import 'package:flutter_animarker/widgets/animarker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:ui' as ui;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

//Setting dummies values
const kStartPosition = LatLng(5.802332993126346, -0.35745423522293535);
const kCameraPosition = CameraPosition(target: kStartPosition, zoom: 12);
const kMarkerId = MarkerId('MarkerId1');
const kDuration = Duration(seconds: 5);
const kLocations = [
  kStartPosition,
  LatLng(5.802332993126346, -0.35745423522293535),
  LatLng(5.801872, -0.355076),
  LatLng(5.799510, -0.351383),
  LatLng(5.796256, -0.348112),
  LatLng(5.794261, -0.344682),
  LatLng(5.792372, -0.340831),
  LatLng(5.790430, -0.338510),
  LatLng(5.784211, -0.335271),
  LatLng(5.780567, -0.332720),
  LatLng(5.776728, -0.329450)
];

double _originLatitude = 5.802332993126346,
    _originLongitude = -0.35745423522293535;
double _destLatitude = 5.5540191529923515,
    _destLongitude = -0.21125878552423552;
double _stat1Latitude = 5.667652633363262,
    _stat1Longitude = -0.27031652698831055;
double _stat2Latitude = 5.616917410407343,
    _stat2Longitude = -0.2296471893422632;
double _stat3Latitude = 5.754734518236746,
    _stat3Longitude = -0.3216129316706105;

Map<PolylineId, Polyline> polylines = {};
List<LatLng> polylineCoordinates = [];
PolylinePoints polylinePoints = PolylinePoints();
String googleAPiKey = "AIzaSyCf-HzMahiJPRvOiNXPWCHN0kKQKJwk5HQ";
late LatLng _currentPosition;
bool _isLoading = true;

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late Uint8List customIcon;
  late Uint8List busIcon;

  final markers = <MarkerId, Marker>{};
  final controller = Completer<GoogleMapController>();
  final stream = Stream.periodic(kDuration, (count) => kLocations[count])
      .take(kLocations.length);

  @override
  void initState() {
    stream.forEach((value) => newLocationUpdate(value));
    super.initState();
    customMarker();
    getLocation();
    _getPolyline();
  }

  getLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double lat = position.latitude;
    double long = position.longitude;

    LatLng location = LatLng(lat, long);

    setState(() {
      _currentPosition = location;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: _isLoading
                ? Center(child: CircularProgressIndicator())
                : Animarker(
                    curve: Curves.ease,
                    mapId: controller.future
                        .then<int>((value) => value.mapId), //Grab Google Map Id
                    markers: markers.values.toSet(),
                    child: GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: kCameraPosition,
                      onMapCreated: (gController) => controller.complete(
                          gController), //Complete the future GoogleMapController
                      polylines: Set<Polyline>.of(polylines.values),
                    ),
                  )));
  }

  void newLocationUpdate(LatLng latLng) {
    var marker = RippleMarker(
        markerId: kMarkerId,
        position: latLng,
        ripple: true,
        icon: BitmapDescriptor.fromBytes(busIcon));
    setState(() => markers[kMarkerId] = marker);
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.blueAccent.shade200,
        points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(_originLatitude, _originLongitude),
      PointLatLng(_destLatitude, _destLongitude),
      travelMode: TravelMode.driving,
      // wayPoints: [PolylineWayPoint(location: "circle accra")]
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  customMarker() async {
    customIcon = await loadAsset('assets/bus_loc_green.png', 100);
    busIcon = await loadAsset('assets/bus_icon.png', 150);

    /// origin marker
    _addMarker(LatLng(_originLatitude, _originLongitude), "origin",
        BitmapDescriptor.defaultMarker);

    /// bustop marker
    _addMarker(LatLng(_stat2Latitude, _stat2Longitude), "station2",
        BitmapDescriptor.fromBytes(customIcon));

    /// bustop marker
    _addMarker(LatLng(_stat1Latitude, _stat1Longitude), "station1",
        BitmapDescriptor.fromBytes(customIcon));

    _addMarker(LatLng(_stat3Latitude, _stat3Longitude), "station3",
        BitmapDescriptor.fromBytes(customIcon));

    /// destination marker
    _addMarker(LatLng(_destLatitude, _destLongitude), "destination",
        BitmapDescriptor.defaultMarkerWithHue(90));
  }

  Future<Uint8List> loadAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
