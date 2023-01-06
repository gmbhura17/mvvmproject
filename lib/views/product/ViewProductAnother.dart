import 'package:flutter/material.dart';
import 'package:mvvmproject/providers/ProductProvider.dart';
import 'package:mvvmproject/resources/UrlResources.dart';
import 'package:mvvmproject/views/product/EditProduct.dart';
import 'package:provider/provider.dart';
class ViewProductAnother extends StatefulWidget {

  @override
  State<ViewProductAnother> createState() => _ViewProductAnotherState();
}

class _ViewProductAnotherState extends State<ViewProductAnother> {
  ProductProvider provider;
  @override
  void initState() {
    super.initState();
    provider = Provider.of<ProductProvider>(context,listen:false);
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ProductProvider>(context,listen:true);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Product Other")),
        actions: [
          IconButton(
            onPressed: (){

            },
            icon: Icon(Icons.star),
          )
        ],
      ),
      body: (provider.alldata != null) ? ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: provider.alldata.length,
        itemBuilder: (context, index) {

          if(double.parse(provider.alldata[index].price.toString())<=150)
            {
              return
                Container(
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
                            Column(
                              children: [
                                Text("Product = "+provider.alldata[index].pname.toString(),style: TextStyle(fontSize: 20),),
                                Text("Price = "+provider.alldata[index].price.toString(),style: TextStyle(fontSize: 20),),
                                Text("Quantity= "+  provider.alldata[index].qty.toString(),style: TextStyle(fontSize: 20),),
                                SizedBox(height: 18),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: ()  async{
                                        // delete product normal (post) ..3
                                        AlertDialog alert = new AlertDialog(
                                          title: Center(child: Text("ALert !")),
                                          content: Text("You Want To Delete !"),
                                          actions: [
                                            Row(
                                              children: [
                                                TextButton(onPressed: (){
                                                  Navigator.of(context).pop();
                                                },
                                                    child: Text("Cancel")
                                                ),
                                                TextButton(
                                                    onPressed: () async {
                                                      Uri url = Uri.parse(UrlResources.DELETE_PRODUCTS);
                                                      Map<String,String> params = {
                                                        "pid":provider.alldata[index].pid.toString()
                                                      };
                                                      await provider.deleteproducts(context,params);
                                                      if(provider.isdeleted)
                                                      {
                                                        await provider.allproducts(context);
                                                      }
                                                      else
                                                      {
                                                        print("product Not Deleted");
                                                      }
                                                      Navigator.of(context).pop();
                                                    }, child: Text("Delete")),
                                              ],
                                            ),
                                          ],
                                        );
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return alert;
                                            });
                                      },
                                      child: Container(
                                          width: 160,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black),
                                            color: Colors.yellowAccent,
                                          ),
                                          child: Center(child: Text("Delete Products",style: TextStyle(color: Colors.black),))),
                                    ),
                                    GestureDetector(
                                      onTap: () {

                                        var id = provider.alldata[index].pid.toString();

                                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Editproduct(Editid: id,)));
                                      },
                                      child: Container(
                                          width: 160,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black),
                                            color: Colors.yellowAccent,
                                          ),
                                          child: Center(child: Text("Update Products",style: TextStyle(color: Colors.black),))),
                                    ),
                                    // GestureDetector(
                                    //   onTap: () {
                                    //     Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Editproduct()));
                                    //   },
                                    //   child: Container(
                                    //       color: Colors.red,
                                    //       height: 40,
                                    //       width:160,
                                    //       child: Text("Edit")),
                                    // )
                                  ],
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                      subtitle: Column(
                        children: [

                          GestureDetector(
                            onTap: ()  async{
                              // delete product normal (post) ..3
                              Uri url = Uri.parse(UrlResources.DELETE_PRODUCTS);
                              Map<String,String> params = {
                                "pid":provider.alldata[index].pid.toString()
                              };
                              await provider.deleteproducts(context,params);
                              if(provider.isdeleted)
                              {
                                await provider.allproducts(context);
                              }
                              else
                              {
                                print("Product Not Deleted");
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
                    ),
                  ),
                );
            }

        },
      ) : Center(child: CircularProgressIndicator()),
    );
  }
}
