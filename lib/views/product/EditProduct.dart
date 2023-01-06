import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mvvmproject/helpers/ApiHandler.dart';
import 'package:mvvmproject/resources/UrlResources.dart';
import 'package:mvvmproject/views/product/ViewProducts.dart';
import 'package:provider/provider.dart';

import '../../providers/ProductProvider.dart';

class Editproduct extends StatefulWidget {
  var Editid = "";

  Editproduct({this.Editid});

  @override
  State<Editproduct> createState() => _EditProductstate();
}

class _EditProductstate extends State<Editproduct> {
  TextEditingController _product = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _quantity = TextEditingController();
  ProductProvider provider;
  fetchProducts() async {


    Map<String, String> params = {
      "pid": widget.Editid,
    };
    await provider.editproducts(context,params);
    _product.text = provider.singleobj.pname.toString();
    _price.text = provider.singleobj.price.toString();
    _quantity.text = provider.singleobj.qty.toString();

  }

  @override
  void initState() {
    super.initState();
    provider = Provider.of<ProductProvider>(context,listen:false);
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            // Text("Product :"),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _product,
                // obscureText: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Product',
                    hintText: 'Enter Your Product'),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            // Text("Price :"),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _price,
                // obscureText: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Price',
                    hintText: 'Enter Your price'),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            // Text("Quantity :"),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _quantity,
                // obscureText: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Quantity',
                    hintText: 'Enter your quantity'),
              ),
            ),
            SizedBox(
              height: 70,
            ),
            GestureDetector(
                onTap: () async {
                  var name = _product.text.toString();
                  var q = _quantity.text.toString();
                  var p = _price.text.toString();

                  Map<String, String> params = {
                    "pname": name,
                    "qty": q,
                    "price": p,
                    "pid": widget.Editid
                  };

                  await provider.updateproduct(context,params);

                  if(provider.isupdated)
                    {
                      await provider.allproducts(context);
                      Navigator.of(context).pop();
                    }
                  else
                    {
                      print("Error");
                    }


                },
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                )),
            SizedBox(
              height: 130,
            ),
          ],
        ),
      ),
    );
  }
}
