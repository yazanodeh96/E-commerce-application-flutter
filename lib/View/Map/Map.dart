import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;

class TheMap extends StatefulWidget {
  const TheMap({super.key});

  @override
  State<TheMap> createState() => _TheMapState();
}

class _TheMapState extends State<TheMap> {
  bool isLoading = false;
  loc.LocationData? locationData;
  List<Placemark>? placemark;
  final TextStyle textStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  void getPermission() async {
    if (await Permission.location.isGranted) {
      getLocation();
    } else {
      Permission.location.request();
    }
  }

  void getLocation() async {
    setState(() {
      isLoading = true;
    });

    locationData = await loc.Location.instance.getLocation();
    setState(() {
      isLoading = false;
    });
  }

  void getAddress() async {
    if (locationData != null) {
      setState(() {
        isLoading = true;
      });
      placemark = await placemarkFromCoordinates(
          locationData!.latitude!, locationData!.longitude!);

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Map ").tr(),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Text(
                      locationData != null
                          ? "Latitude: ${locationData!.latitude} "
                          : "Latitude: Not Available ",
                      style: textStyle),
                  Text(
                    locationData != null
                        ? "Longitude: ${locationData!.longitude} "
                        : "Longitude: Not Available ",
                    style: textStyle,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple),
                      onPressed: getPermission,
                      child: Text("Get Location ")),
                  SizedBox(
                    height: 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                        placemark != null
                            ? "Address :${placemark![0].street}${placemark![0].locality}${placemark![0].country} "
                            : "Address No Available ",
                        style: textStyle),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple),
                      onPressed: getAddress,
                      child: Text("Get Address", style: textStyle))
                ],
              ),
            ),
    );
  }
}
