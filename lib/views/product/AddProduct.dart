import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/ProductProvider.dart';
import 'ViewProducts.dart';

class AddProduct extends StatefulWidget {

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController _product  = TextEditingController();
  TextEditingController _price  = TextEditingController();
  TextEditingController _quantity  = TextEditingController();
  ProductProvider provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<ProductProvider>(context,listen:false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
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
                controller: _product ,
                // obscureText: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Product',
                    hintText: 'Enter Your Product'
                ),
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
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Price',
                    hintText: 'Enter Your price'
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            // Text("Quantity :"),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _quantity ,
                // obscureText: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Quantity',
                    hintText: 'Enter your quantity'
                ),
              ),
            ),
            SizedBox(
              height: 70,
            ),
            GestureDetector(
              onTap: () async{
                var name = _product.text.toString();
                var q = _quantity.text.toString();
                var p = _price.text.toString();
                // insert procduct normal -api  (post) ..1 product
                Map<String,String> params = {
                  "pname":name,
                  "qty":q,
                  "price":p
                };
                await provider.addproducts(context,params);
                if(provider.isinserted)
                  {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ViewProducts()));
                  }
                else
                  {
                    print("Errors");
                  }
              },
              child: Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text('Submit', style: TextStyle(color: Colors.white, fontSize: 25),),
                ),
              ),
            ),
            SizedBox(
              height: 130,
            ),
          ],
        ),
      ),
    );
  }
}
