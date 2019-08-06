import 'package:flutter/material.dart';
import 'package:ung_ssru/models/product_model.dart';

class ShoeDetail extends StatefulWidget {
  final ProductModel productModel;
  ShoeDetail({Key key, this.productModel}) : super(key: key);
//key คืออะไรรูปเเบบของการสร้างkey รับค่าของตัวmodel

  @override
  _ShoeDetailState createState() => _ShoeDetailState();
}

class _ShoeDetailState extends State<ShoeDetail> {
  //virable
  ProductModel productModel;
  String name = '';
  String detail = '';
  String url = '';

  //method

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //รับของมาจากชั้นหนึ่งเพื่อนำมาใช้
    //รับค่าwidetมาใช้
    productModel = widget.productModel;
    setState(() {
      //เพื่อโชว์ก่อนไม่ให้เป็นค่าว่างเปล่า
      name = productModel.name;
      detail = productModel.detail;
      url = productModel.url;
      print('name=$name');
    });
  }

  Widget showName() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        productModel.name,
        style: TextStyle(fontSize: 24.0,color: Colors.pink),
      ),
    );
  }

  Widget showImage() {
    return Container(
      width: 100,
      height: 100,
      child: Image.network(
        productModel.url,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget shorDetail() {
    return Text(productModel.detail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Name',
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(40.0),
        children: <Widget>[
          showName(),
          showImage(),
          shorDetail(),
        ],
      ),
    );
  }
}
