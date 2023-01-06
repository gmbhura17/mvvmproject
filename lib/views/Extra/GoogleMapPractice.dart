import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPractice extends StatefulWidget {

  @override
  _GoogleMapPracticeState createState() => _GoogleMapPracticeState();
}

class _GoogleMapPracticeState extends State<GoogleMapPractice> {

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(19.0759837, 72.8776559),
    zoom: 15,
  );

  Uint8List marketimages;
  List<String> images = ['img/marker.png','img/flag2.png', 'img/flag3.png', 'img/marker4.jpg', 'img/flag4.png','img/marker6.jpg'];

  final List<Marker> _markers = <Marker>[];

  final List<LatLng> _latLen = <LatLng>[

    LatLng(19.0760, 72.8777),
    LatLng(21.1702, 72.8311),
    LatLng(22.4707, 70.0577),
    LatLng(22.3072, 73.1812),
    LatLng(18.5204, 73.8567),
    LatLng(23.0225, 72.5714),
  ];

  Future<Uint8List> getImages(String path, int width) async{
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return(await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();

  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async{
    for(int i=0 ;i<images.length; i++){
      final Uint8List markIcons = await getImages(images[i], 100);
      _markers.add(
          Marker(
            markerId: MarkerId(i.toString()),
            icon: BitmapDescriptor.fromBytes(markIcons),
            position: _latLen[i],
            infoWindow: InfoWindow(
              title: 'Location: '+i.toString(),
            ),
          )
      );
      setState(() {
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0F9D58),
        title: Text("GFG"),
      ),
      body: Container(
        child: SafeArea(
          child: GoogleMap(
            initialCameraPosition: _kGoogle,
            markers: Set<Marker>.of(_markers),
            mapType: MapType.normal,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            compassEnabled: true,
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
            },
          ),
        ),
      ),
    );
  }
}