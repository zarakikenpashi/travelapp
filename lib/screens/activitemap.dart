import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';

const double CAMERA_ZOOM = 13;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;

class ActiviteMap extends StatefulWidget {
  const ActiviteMap({super.key, required this.data});
  final Map<String, dynamic>? data;

  @override
  State<ActiviteMap> createState() => _ActiviteMapState();
}

class _ActiviteMapState extends State<ActiviteMap> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey = "AIzaSyCNZfIwGs9Y1hlRDCyiw3LV8dpLu1biIbM";
  LatLng SOURCE_LOCATION = LatLng(0, 0);
  LatLng DEST_LOCATION = LatLng(0, 0);

  // for my custom icons
  late BitmapDescriptor sourceIcon;
  late BitmapDescriptor destinationIcon;

  late SharedPreferences prefs;
  double latitude = 0.0;
  double longitude = 0.0;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    latitude = prefs.getDouble('latitude')!;
    longitude = prefs.getDouble('longitude')!;
    SOURCE_LOCATION = LatLng(latitude, longitude);
    DEST_LOCATION = LatLng(5.343924, -4.0645722);

    print("activités map");
  }

  @override
  void initState() {
    init();
    super.initState();
    setSourceAndDestinationIcons();
  }

  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), "assets/driving_pin.png");
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        "assets/destination_map_marker.png");
  }

  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    setMapPins();
    setPolylines();
  }

  void setMapPins() {
    setState(() {
      // source pin
      _markers.add(Marker(
        markerId: MarkerId("sourcePin"),
        position: SOURCE_LOCATION,
        //icon: sourceIcon
      ));
      // destination pin
      _markers.add(Marker(
        markerId: MarkerId("destPin"),
        position: DEST_LOCATION,
        //icon: destinationIcon
      ));
    });
  }

  setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPIKey,
        PointLatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude),
        PointLatLng(DEST_LOCATION.latitude, DEST_LOCATION.longitude));
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    setState(() {
      Polyline polyline = Polyline(
          polylineId: PolylineId("poly"),
          color: Color.fromARGB(255, 40, 122, 198),
          points: polylineCoordinates);
      _polylines.add(polyline);
    });
  }

  Future<void> _launchUrl(String phone) async {
    final Uri _url = Uri.parse('tel:$phone');
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? currentData = widget.data;

    CameraPosition initialLocation = CameraPosition(
        zoom: CAMERA_ZOOM,
        bearing: CAMERA_BEARING,
        tilt: CAMERA_TILT,
        target: SOURCE_LOCATION);

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: 500,
            height: 300,
            child: GoogleMap(
                myLocationEnabled: true,
                compassEnabled: true,
                tiltGesturesEnabled: false,
                markers: _markers,
                polylines: _polylines,
                mapType: MapType.normal,
                initialCameraPosition: initialLocation,
                onMapCreated: onMapCreated),
          ),
          Expanded(
            child: Container(
              width: 500,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(children: [
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(currentData!['image_hotel']),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Positioned(
                        right: 20,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () {
                            _launchUrl(currentData['tel_responsable']);
                          },
                          child: CircleAvatar(
                            radius: 30.0,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.call_outlined,
                              color: Colors.pink,
                            ),
                          ),
                        ),
                      ),
                    ]),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${currentData['nom_hotel']}",
                            style: TextStyle(fontSize: 30),
                          ),
                          Text("1.2 km")
                        ],
                      ),
                    ),
                    Divider(height: 10, color: Colors.grey),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Adresse"),
                          Text(
                            "1519 Taylor Street, New York NYC 10011, United States",
                            style: TextStyle(fontSize: 20),
                            maxLines: 3,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color.fromARGB(255, 255, 125, 126),
                                      Color.fromARGB(255, 236, 38, 125)
                                    ])),
                            child: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: GestureDetector(
                                onTap: () {
                                  MapsLauncher.launchCoordinates(
                                      currentData['latitude'],
                                      currentData['longitude']);
                                },
                                child: Text(
                                  "GET DIRECTION",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
