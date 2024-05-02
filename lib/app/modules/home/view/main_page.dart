import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/home/controller/home_controller.dart';

import '../../../routes/app_routes.dart';

// ignore: must_be_immutable
class MainView extends GetView<HomeController> {
  var myarr_product = [
    {
      "pro_id": "1",
      "pro_name": "product1",
      "pro_desc":
          "desc product1 desc product1 desc product1 desc product1 desc product1",
      "pro_image": 'assets/images/post_2.jpg',
    },
    {
      "pro_id": "2",
      "pro_name": "product2",
      "pro_desc":
          "desc product2 desc product2 desc product2 desc product2 desc product2",
      "pro_image": 'assets/images/post_3.jpg',
    },
    {
      "pro_id": "3",
      "pro_name": "product3",
      "pro_desc":
          "desc product3 desc product3 desc product3 desc product3 desc product3",
      "pro_image": 'assets/images/pos_4.jpg',
    },
  ];

  var myarr_category = [
    {"cat_id": "1", "cat_name": "cat1", 'image': 'assets/images/cat_1.jpg'},
    {"cat_id": "2", "cat_name": "cat2", 'image': 'assets/images/cat_2.jpg'},
  ];

  MainView({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
                alignment: Alignment.bottomLeft,
                margin: const EdgeInsets.only(top: 30.0),
                padding: const EdgeInsets.only(right: 15.0),
                child: const Text(
                  'deliverd to',
                  style: TextStyle(color: Colors.grey),
                )),
            Row(
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: const Text(
                      'Your Location',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    )),
                IconButton(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.purple.shade200,
                    ),
                    onPressed: () {})
              ],
            ),
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.only(right: 10.0),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(25.0)),
                child: const TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search",
                      suffixIcon: Icon(Icons.search)),
                ),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 110.0,
          child: ListView.builder(
              itemCount: myarr_category.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return SingleCatrgory(
                  caId: myarr_category[index]["cat_id"],
                  catName: myarr_category[index]["cat_name"],
                  image: myarr_category[index]['image'],
                );
              }),
        ),
      ),
      SizedBox(
        height: Get.height / 1.8,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            itemCount: myarr_product.length,
            itemBuilder: (BuildContext context, int index) {
              return SigleProduct(
                pro_id: myarr_product[index]["pro_id"],
                pro_name: myarr_product[index]["pro_name"],
                pro_image: myarr_product[index]["pro_image"],
                pro_decs: myarr_product[index]["pro_desc"],
              );
            }),
      )
    ]);
  }
}

class SigleProduct extends StatelessWidget {
  final String? pro_id;
  final String? pro_name;
  final String? pro_decs;
  final String? pro_image;

  const SigleProduct(
      {super.key, this.pro_id, this.pro_name, this.pro_decs, this.pro_image});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.rootDelegate.toNamed(Paths.PRODUCT_PAGE);
      },
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: AssetImage(pro_image!))),
              ),
              Text(
                pro_name!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                pro_decs!,
                style: const TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SingleCatrgory extends StatelessWidget {
  final String? caId;
  final String? catName;
  final String? image;
  const SingleCatrgory({super.key, this.caId, this.catName, this.image});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.only(right: 10.0),
        child: Column(
          children: <Widget>[
            Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.purple.shade200),
                child: Image.asset(
                  image!,
                  height: 45,
                  width: 45,
                )),
            Text(
              catName!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
