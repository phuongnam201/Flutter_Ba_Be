import 'package:flutter/material.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  CameraPosition _cameraPosition = const CameraPosition(
      target: LatLng(21.584600777914314, 105.81188929564517), zoom: 17);
  late LatLng _initialPosition =
      const LatLng(21.584600777914314, 105.81188929564517);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
        backgroundColor: AppColors.mainColor,
      ),
      body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: double.infinity,
                      margin: EdgeInsets.all(Dimensions.width20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          width: 2,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      child: Stack(
                        children: [
                          GoogleMap(
                            initialCameraPosition: CameraPosition(
                                target: _initialPosition, zoom: 17),
                            onTap: (latlng) {
                              
                            },
                            zoomControlsEnabled: false,
                            compassEnabled: false,
                            indoorViewEnabled: true,
                            mapToolbarEnabled: false,
                            myLocationEnabled: true,
                            onCameraIdle: () {
                              
                            },
                            onCameraMove: ((position) =>
                                _cameraPosition = position),
                            onMapCreated: (GoogleMapController controller) {
                              //locationController.setMapController(controller);
                            },
                          ),
                          /**get your location */
                          // Positioned(
                          //   bottom: 16.0,
                          //   right: 16.0,
                          //   child: FloatingActionButton(
                          //     onPressed: () async {
                          //       Position curr_position =
                          //           await locationController
                          //               .determinePosition();
                          //       print("current lat: " +
                          //           curr_position.latitude.toString());
                          //       print("current lng: " +
                          //           curr_position.longitude.toString());
                          //       _cameraPosition = CameraPosition(
                          //           target: LatLng(curr_position.latitude,
                          //               curr_position.longitude),
                          //           zoom: 17);
                          //       locationController.updatePosition(
                          //           _cameraPosition, true);
                          //     },
                          //     tooltip: 'Get My Location',
                          //     child: Icon(Icons.location_searching_sharp),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    
                  ],
                ),
              ),
            
    );
  }
}