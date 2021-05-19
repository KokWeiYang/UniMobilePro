import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'newproduct.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      home: MyShop(),
    );
  }
}

class MyShop extends StatefulWidget {
  @override
  _MyShopState createState() => _MyShopState();
}

class _MyShopState extends State<MyShop> {
  double screenHeight, screenWidth;
  List _productlist;
  int _pageno = 1;
  int pagenum = 0;
  @override
  void initState() {
    super.initState();
    _loadimage();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        backgroundColor: Color(0xfff4a460),
        appBar: AppBar(
          backgroundColor: Color(0xffff6347),
          title: Text('My Shop'),
        ),
        body: Center(
          child: Column(
            children: [
              _productlist == null
                  ? Flexible(child: Center(child: Text('empty')))
                  : Flexible(
                      child: Center(
                      child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: (screenWidth / screenHeight) / 1.2,
                          children: List.generate(
                            _productlist.length,
                            (index) {
                              return Padding(
                                padding: EdgeInsets.fromLTRB(5, 6, 5, 6),
                                child: Card(
                                  color: Colors.deepOrange[50],
                                  child: SingleChildScrollView(
                                    child: Column(children: [
                                      SizedBox(height: 10),
                                      Container(
                                        height: screenWidth / 2.5,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "https://hubbuddies.com/269971/myshop/images/product/${_productlist[index]['productid']}.png",
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              new Transform.scale(
                                                  scale: 0.5,
                                                  child:
                                                      CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              new Icon(
                                            Icons.broken_image,
                                            size: screenWidth / 3,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        height: screenWidth / 2.4,
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  5, 1, 5, 1),
                                              height: screenWidth / 2.4,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  
                                                    Container(
                                                        child: Text(
                                                      'Product Name: ',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )),
                                                    Expanded(
                                                        child: Text(
                                                      _productlist[index]
                                                          ['productname'],
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      textAlign:
                                                          TextAlign.justify,
                                                    )),
                                                  
                                                  SizedBox(height: 10),
                                                  
                                                    Container(
                                                        child: Text(
                                                            'Product Type:',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),)),
                                                    Expanded(
                                                        child: Text(
                                                      _productlist[index]
                                                          ['producttype'],
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      textAlign:
                                                          TextAlign.justify,
                                                    )),
                                                  SizedBox(height: 10),
                                                  
                                                    Container(
                                                        child: Text(
                                                            'Product Price:',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),)),
                                                    Expanded(
                                                        child: Text("RM"+
                                                      _productlist[index]
                                                          ['productprice']+" each",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      textAlign:
                                                          TextAlign.justify,
                                                    )),
                                                  SizedBox(height: 10),
                                                  
                                                    Container(
                                                        child: Text(
                                                            'Product Quantity: ',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),)),
                                                    Expanded(
                                                        child: Text(
                                                      _productlist[index]
                                                          ['productqty'],
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      textAlign:
                                                          TextAlign.justify,
                                                    )),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                              );
                            },
                          )),
                    )),
            ],
          ),
        ),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: Color(0xffff6e00),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewProduct()),
                );
              }),
        ),
      ),
    );
  }

  void _loadimage() {
    print(_pageno);
    http.post(
        Uri.parse("https://hubbuddies.com/269971/myshop/php/load_image.php"),
        body: {
          "pageno": _pageno.toString(),
        }).then((response) {
      if (response.body == "nodata") {
        return;
      } else {
        var jsondata = json.decode(response.body);
        _productlist = jsondata["products"];
        pagenum = _productlist[0]['numpage'];
        setState(() {});
        print(_productlist);
      }
    });
  }
}
