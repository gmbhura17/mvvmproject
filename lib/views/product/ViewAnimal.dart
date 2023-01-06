import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mvvmproject/providers/AnimalProvider.dart';
import 'package:provider/provider.dart';


class ViewAnimal extends StatefulWidget {

  @override
  State<ViewAnimal> createState() => _ViewAnimalState();
}

class _ViewAnimalState extends State<ViewAnimal> {
  AnimalProvider provider;


    fetchProducts() async {
      await provider.allanimals(context);
    }
    @override
    void initState() {
      super.initState();
      // provider = Provider.of<AnimalProvider>(context,listen:false);
      provider = Provider.of<AnimalProvider>(context,listen:false);
      fetchProducts();
    }
    @override
    Widget build(BuildContext context) {
      provider = Provider.of<AnimalProvider>(context,listen:true);
    return Scaffold(
      appBar: AppBar(
        title: Text("View Animal"),
      ),
      body: (provider.alldata != null) ? ListView.builder(
        itemCount: provider.alldata.length,
        itemBuilder: (context, index) {
          return Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
            child: Card(
              elevation: 10,
              color: Colors.white,
              child: ListTile(

                title: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Column(
                    children: [
                      Text(" lifespan= "+provider.alldata[index].lifespan.toString(),style: TextStyle(fontSize: 20),),
                      Text("name = "+provider.alldata[index].name.toString(),style: TextStyle(fontSize: 20),),
                      Text("id = "+provider.alldata[index].id.toString(),style: TextStyle(fontSize: 20),),
                      Text("geoRange =  "+provider.alldata[index].geoRange.toString(),style: TextStyle(fontSize: 20),),
                      Text("lifespan  = "+  provider.alldata[index].lifespan.toString(),style: TextStyle(fontSize: 20),),
                    ],
                  ),
                ),
                subtitle: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Editproduct()));
                      },
                      child: Container(
                          color: Colors.red,
                          height: 100,
                          width:130,
                          child: Text("Edit")),
                    ),
                    GestureDetector(
                      onTap: ()  async{
                        // delete product normal (post) ..3
                        Uri url = Uri.parse("http://picsyapps.com/studentapi/deleteProductNormal.php");
                        Map<String,String> params = {
                        };
                        var response = await http.post(url,body: params);
                        if(response.statusCode==200)
                        {
                          var json = jsonDecode(response.body);
                          if(json["status"]=="true")
                          {
                            await provider.allanimals(context);
                          }
                          else
                          {
                            print("Not Delete");
                          }
                        }
                      },
                      child: Container(
                          width: 110,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: Colors.green[400],
                          ),
                          child: Center(child: Text("Delete Product",style: TextStyle(),))),
                    ),
                  ],
                ),
                // subtitle: Column(
                //   children: [
                //     GestureDetector(
                //       onTap: () {
                //         Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ViewAnimallist()));
                //       },
                //       child: Container(
                //           color: Colors.red,
                //           height: 100,
                //           width:130,
                //           child: Text("Edit")),
                //     ),
                //   ],
                // ),
              ),
            ),
          );
        },
      ) : Center(child: CircularProgressIndicator(
      )),
    );
  }
}
