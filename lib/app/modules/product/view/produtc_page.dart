import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/product/controller/product_controller.dart';

class ProductView extends GetView<ProductController> {
  const ProductView({super.key});

  Widget headerBuild(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          //===================back
          Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade100,
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(0, 1))
                  ],
                  borderRadius: BorderRadius.circular(
                      15)), //بدنا نروع ع الكونتينير تبعيت البرودكت ونحطو ب ويدجت ونضيف الصورة الي مصورتا
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.purple.shade200,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })),
          const Expanded(child: Text("")),
          //===================shoping cart
          Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade100,
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(0, 1))
                  ],
                  borderRadius: BorderRadius.circular(
                      15)), //بدنا نروع ع الكونتينير تبعيت البرودكت ونحطو ب ويدجت ونضيف الصورة الي مصورتا
              child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.purple.shade200,
                  ),
                  onPressed: () {}))
        ],
      ),
    );
  }

  Widget imageProduct() {
    return Container(
      padding: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade100,
                spreadRadius: 1,
                blurRadius: 0,
                offset: const Offset(0, 1))
          ],
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50.0),
              bottomRight: Radius.circular(
                  50.0)) //بدنا نروع ع الكونتينير تبعيت البرودكت ونحطو ب ويدجت ونضيف الصورة الي مصورتا
          ),
      child: Column(
        children: <Widget>[
          Image.asset(
              'assets/images/post_3.jpg'), //لازم نحط صورة متل الفريز مثلا
          const Padding(padding: EdgeInsets.only(top: 30.0)),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            //===================back
            Container(
                decoration: BoxDecoration(
                    color: Colors.purple.shade200,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade100,
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 1))
                    ],
                    borderRadius: BorderRadius.circular(
                        15) //بدنا نروع ع الكونتينير تبعيت البرودكت ونحطو ب ويدجت ونضيف الصورة الي مصورتا
                    ),
                child: IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.minus,
                      color: Colors.white,
                    ),
                    onPressed: () {})),
            const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "1",
                  style: TextStyle(color: Colors.black, fontSize: 25.0),
                )),
            //===================shoping cart
            Container(
                decoration: BoxDecoration(
                    color: Colors.purple.shade200,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade100,
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 1))
                    ],
                    borderRadius: BorderRadius.circular(15)),
                child: IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.plus,
                      color: Colors.white,
                    ),
                    onPressed: () {})),
          ]),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                imageProduct(),
                Container(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        "سيتامول",
                        style: TextStyle(fontSize: 30.0),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.favorite, color: Colors.purple.shade200),
                          const Text("5", style: TextStyle(fontSize: 16.0)),
                          const Expanded(child: Text("")),
                          const Icon(Icons.star, color: Colors.orange),
                          const Text("5 review",
                              style: TextStyle(fontSize: 16.0)),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 15.0)),
                      const Text(
                        "تاخذ حبة السيتامول للتخفيف من اعراض الصدا والحمى وارتفاع درجة الحرارة وسمكن الالام للعظام ",
                        style: TextStyle(fontSize: 18.0, color: Colors.grey),
                      )
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              height: 120,
              child: headerBuild(context),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.only(left: 50, right: 30),
          height: 75.0,
          decoration: BoxDecoration(
              //  color: Colors.red[300],
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Colors.purple,
                    Colors.purple.shade200,
                    Colors.purple.shade300,
                    Colors.purple,
                  ]),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade100,
                    spreadRadius: 7,
                    blurRadius: 4,
                    offset: const Offset(0, 3))
              ],
              borderRadius: BorderRadius.circular(40)),
          child: Row(
            children: <Widget>[
              const Text(
                "1500",
                style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const Expanded(child: Text("")),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.purple.shade100,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade100,
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(0, 1))
                      ],
                      borderRadius: BorderRadius.circular(40)),
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: const Text("إضاغة إلى السلة",
                      style: TextStyle(color: Colors.white, fontSize: 20))),
              Container(
                child: const Icon(
                  Icons.shopping_basket,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
