import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapExample extends StatefulWidget {

  @override
  State<GoogleMapExample> createState() => _GoogleMapState();
}
class _GoogleMapState extends State<GoogleMapExample> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    loadData();
  }

   List<Marker> _markers=null;
  loadData() async{
    await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 1.2),
        "img/location.png").then((value){
      setState((){
        _markers = <Marker>[
          Marker(markerId: MarkerId('12'), position: LatLng(19.0760, 72.8777),icon: value),
          Marker(markerId: MarkerId('13'), position: LatLng(21.1702, 72.8311),icon: value),
          Marker(markerId: MarkerId('14'), position: LatLng(22.4707, 70.0577),icon: value),
          Marker(markerId: MarkerId('15'), position: LatLng(22.3072, 73.1812),icon: value),
          Marker(markerId: MarkerId('16'), position: LatLng(18.5204, 73.8567),icon: value),
          Marker(markerId: MarkerId('17'), position: LatLng(23.0225, 72.5714),icon: value)
        ];
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0F9D58),
        iconTheme: IconThemeData(color: Colors.red),
        title: Center(child: Text("Google Map")),
      ),
      body: (_markers!=null)?GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(19.0760,72.8777),
          zoom: 14.4746,
        ),
        markers: Set<Marker>.of(_markers),
        mapType: MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        compassEnabled: true,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ):Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
