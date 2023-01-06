import 'package:flutter/material.dart';
import 'package:mvvmproject/models/Animal.dart';

class ViewAnimallist extends StatefulWidget {
  Animal obj;

  ViewAnimallist({this.obj});
  @override
  State<ViewAnimallist> createState() => _ViewAnimallistState();
}
  @override
  State<ViewAnimallist> createState() => _ViewAnimallistState();

class _ViewAnimallistState extends State<ViewAnimallist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Animal List"),
      ),
      body: Card(
        elevation: 20,
        child: Container(
          color: Colors.white30,
          width: 200,
          height: 450,
          child: Column(
            children: [
              SizedBox(height: 20,),
              Image.network(widget.obj.diet,width: 200,),
              SizedBox(height: 20,),
              Text(widget.obj.geoRange),
              SizedBox(height: 20,),
              Text(widget.obj.latinName),
              SizedBox(height: 20,),
              Text(widget.obj.geoRange),

            ],
          ),
        ),
      ),
    );
  }
}
