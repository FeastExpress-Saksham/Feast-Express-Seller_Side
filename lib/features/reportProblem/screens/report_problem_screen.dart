import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class ReportProblemScreen extends StatefulWidget {
  final String tileTitle = "Report Problem";
  final String imageAssetName = "assets/images/report-problem.png";
  const ReportProblemScreen({super.key});

  @override
  State<ReportProblemScreen> createState() => _ReportProblemScreenState();
}

class _ReportProblemScreenState extends State<ReportProblemScreen> {
  MapController controller = MapController();

  @override
  void initState() {
    super.initState();
    login();
    login1();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FutureBuilder(
          future: login(),
          initialData: [67.25022379818182, 101.09582358],
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Align(
              alignment: Alignment.center,
              child: Container(
                // alignment: Alignment.center,
                height: 650,
                width: 650,
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(snapshot.data[0], snapshot.data[1]),
                    initialZoom: 9.2,
                  ),
                  mapController: controller,
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(snapshot.data[0], snapshot.data[1]),
                          width: 80,
                          height: 80,
                          child: Icon(Icons.home),
                        ),
                      ],
                    ),
                    PolygonLayer(polygons: [
                      Polygon(
                        points: [
                          LatLng(28.614379233333334, 77.0424062),
                          LatLng(28.619379233333334, 77.04306),
                          LatLng(28.6279233333334, 77.08306)
                        ],
                        color: Colors.blue,
                        isFilled: true,
                      )
                    ])
                    // MarkerLayer(markers: [
                    //      Marker(
                    //        point: _center,
                    //        builder: (ctx) => Container(
                    //          child: Icon(
                    //            Icons.account_circle,
                    //            color: Colors.red.shade900,
                    //          ),
                    //        ),
                    //      ),
                    //    ],)
                    // RichAttributionWidget(
                    //   attributions: [
                    //     TextSourceAttribution(
                    //       'OpenStreetMap contributors',
                    //       onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  getCurrentLocation() async {
    Location location = Location();

    LocationData _locationData;

    _locationData = await location.getLocation();

    setState(() {
      //_center = LatLng(_locationData.latitude, _locationData.longitude);
      controller.move(
          LatLng(_locationData.latitude!, _locationData.longitude!), 13.0);
    });
  }

  Future login() async {
    try {
      Response response = await get(
        Uri.parse(
            "https://e-commerce-marketplace-pfdj.onrender.com/api/mean-coordinates"),
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);

        print('Login successfully');
        return [data["meanLat"], data["meanLon"]];
      } else {
        print('failed');
        print(response.statusCode);
        return "Fail";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  Future login1() async {
    try {
      Response response = await get(
        Uri.parse(
            "https://e-commerce-marketplace-pfdj.onrender.com/api/fetch-coordinates"),
        headers: {},
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);

        print('Login successfully');
        return [data[0]["latitude"], data[0]["longitude"]];
      } else {
        print('failed');
        print(response.statusCode);
        //return "Fail";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
