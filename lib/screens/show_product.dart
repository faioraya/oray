import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:ung_ssru/models/product_model.dart';
import 'package:ung_ssru/screens/detail.dart';

class ShowProduct extends StatefulWidget {
  @override
  _ShowProductState createState() => _ShowProductState();
}

class _ShowProductState extends State<ShowProduct> {
  //virable

  //instanceเพื่อเข้าไปใน libralyเพื่อเรียกนำตัวหน้านำมาใช้

  Firestore firestore = Firestore.instance;

  //การดึงfirebaseทำการดึงไปอ่านไป
  StreamSubscription<QuerySnapshot> subscription;
  //arr List
  //import classที่อยู่ในปีกกาเเหลมๆทั้งสองอัน
  List<DocumentSnapshot> snapshots;

  //เรากำหนกค่าให้มันเพื่อไม่ให้ขึ้นค่าnull
  List<ProductModel> productModels = [];

  //method

  Widget showDetailShort(int index) {
    //ทำการตัดคำไม่ให้เกินค่าที่หนด
    String detailShort = (productModels[index].detail).substring(0, 50);
    return Container(
      width: 130.0,
      child: Text('$detailShort...'),
    );
  }

  Widget showname(int index) {
    return Text(
      productModels[index].name,
      style: TextStyle(fontSize: 24.0),
    );
  }

  Widget showText(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        showImage(index),
        showText(index),
        // showDetailShort(index),
      ],
    );
  }

  Widget showImage(int index) {
    return Container(
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(30.0)),
      height: 100.0,
      width: 150.0,
      child: Image.network(
        productModels[index].url,
        fit: BoxFit.contain,
      ),
    );
  }

  @override
  void initState() {
    // initStageทำงานเป็นครั้งเเรกเสมอที่เราตั้งขึ้นมาเพื่อทำงานเป็นครั้งเเรกก
    // TODO: implement initState
    super.initState();
    readFireStore();
    // ทำreadครั้งเเรก
  }

  Future<void> readFireStore() async {
    //เก็บเเฟ้มทีอยู่ใจfileBase ที่ชื่อว่าProduct =คือรูปที่เราเก็บมันเอาไว้
    CollectionReference collectionReference = firestore.collection('Product');
    //รอโหลดตรงนี้ได้
    //listenโหลดไปโชว์ไปได้เลย
    subscription = await collectionReference.snapshots().listen((dataSnapshot) {
      //จะเก็บไว้ในsnapshotจนมันอ้วนขึ้นเรื่อยๆ
      snapshots = dataSnapshot.documents;

      for (var snapshot in snapshots) {
        //ค่าName ที่อนู่ในfirebase
        String nameProduct = snapshot.data['Name'];
        print('nameProduct=$nameProduct');

        // / ับค่าจากfirebase,าเก็ยไว้ก่อน
        String deteilProduct = snapshot.data['Detail'];
        // print('nameDetail=$deteilProduct');
        String urlProduct = snapshot.data['Url'];
        print('Url=$urlProduct');

        ProductModel productModel =
            ProductModel(nameProduct, deteilProduct, urlProduct);

        setState(() {
          productModels.add(productModel);
          // readFireStore();
        });
      }
    });
  }

  Widget showListProduct() {
    //itmecount ดูว่ามีกี่อันเอาค่าของPriductModel มาทำการ.length
    return Container(
      //เราต้องการคลิ๊กจะคลิ๊กได้ยังไง
      child: ListView.builder(
        itemCount: productModels.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Container(
              decoration: index % 2 == 0
                  ? BoxDecoration(color: Colors.green)
                  : BoxDecoration(color: Colors.pink),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    showImage(index),
                    SizedBox(
                      width: 10.0,
                    ),
                    showname(index),
                    showDetailShort(index),
                  ]),
            ),
            onTap: () {
              //when you chilk to>>>
              //เมื่อเราคลิ๊กมันจะเข้าหน้าอักหน้าหนึ่ง
              print('You click Index=$index');
              var shdetail = MaterialPageRoute(                  //เพื่อให้เเสดงค่าpro
                  builder: (BuildContext context) => ShoeDetail(productModel: productModels[index],));
              Navigator.of(context).push(shdetail);
              // showDetailShort;
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: showListProduct(),
    );
  }
}
