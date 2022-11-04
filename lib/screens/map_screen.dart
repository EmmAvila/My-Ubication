import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapsScreen extends StatefulWidget {
  static String routeName = 'Maps_Screen';
  const MapsScreen({Key? key}) : super(key: key);

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  // Aqui van las propiedades que funcionan como estados del statful;
  MapType mapType = MapType.normal;
  bool showOption = false;

  @override
  Widget build(BuildContext context) {
    Location location = Location();

    late bool serviceEnabled;
    late PermissionStatus permissionGranted;
    late LocationData locationData;

    const CameraPosition initialPoint = CameraPosition(
      target: LatLng(20.6806, -103.3525),
      zoom: 18,
    );
    // TODO:revisar que siga funcionando

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_rounded),
            onPressed: () {
              setState(() {
                showOption = !showOption;
              });
            },
          )
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              mapType: mapType,
              initialCameraPosition: initialPoint,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            if (showOption) mapsOptions()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.my_location),
          onPressed: () async {
            serviceEnabled = await location.serviceEnabled();
            if (!serviceEnabled) {
              serviceEnabled = await location.requestService();
              if (!serviceEnabled) {
                return;
              }
            }
            permissionGranted = await location.hasPermission();
            if (permissionGranted == PermissionStatus.denied) {
              permissionGranted = await location.requestPermission();
              if (permissionGranted != PermissionStatus.granted) {
                return;
              }
            }

            locationData = await location.getLocation();
            print(locationData.runtimeType);
            final GoogleMapController controller = await _controller.future;
            controller
                .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
              target: LatLng(locationData.latitude ?? 37.42796133580664,
                  locationData.longitude ?? -122.085749655962),
              zoom: 17.5,
            )));
          }),
    );
  }

  Positioned mapsOptions() {
    return Positioned(
      top: 5,
      right: 5,
      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.0),
            color: const Color.fromARGB(200, 33, 149, 243)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    mapType = MapType.normal;
                  });
                },
                icon: const FaIcon(
                  FontAwesomeIcons.road,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    mapType = MapType.terrain;
                  });
                },
                icon: const FaIcon(
                  FontAwesomeIcons.mountainCity,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    mapType = MapType.hybrid;
                  });
                },
                icon: const FaIcon(
                  FontAwesomeIcons.earthAmericas,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}
