import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var myarr_product = [
    {
      "pro_id": "1",
      "pro_name": "product1",
      "pro_desc":
          "desc product1 desc product1 desc product1 desc product1 desc product1",
      "pro_image": 'assets/images/intro_3.png',
    },
    {
      "pro_id": "2",
      "pro_name": "product2",
      "pro_desc":
          "desc product2 desc product2 desc product2 desc product2 desc product2",
      "pro_image": 'assets/images/intro_3.png',
    },
    {
      "pro_id": "3",
      "pro_name": "product3",
      "pro_desc":
          "desc product3 desc product3 desc product3 desc product3 desc product3",
      "pro_image": 'assets/images/intro_3.png',
    },
  ];

  var myarr_category = [
    {
      "cat_id": "1",
      "cat_name": "cat1",
      "cat_image": 'assets/images/intro_3.png',
    },
    {
      "cat_id": "2",
      "cat_name": "cat2",
      "cat_image": 'assets/images/intro_3.png',
    },
    {
      "cat_id": "3",
      "cat_name": "cat3",
      "cat_image": 'assets/images/intro_3.png',
    },
    {
      "cat_id": "4",
      "cat_name": "cat4",
      "cat_image": 'assets/images/intro_3.png',
    },
    {
      "cat_id": "5",
      "cat_name": "cat5",
      "cat_image": 'assets/images/intro_3.png',
    },
    {
      "cat_id": "6",
      "cat_name": "cat6",
      "cat_image": 'assets/images/intro_3.png',
    },
    {
      "cat_id": "7",
      "cat_name": "cat7",
      "cat_image": 'assets/images/intro_3.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(children: <Widget>[
            Container(
                alignment: Alignment.bottomRight,
                margin: const EdgeInsets.only(top: 30.0),
                padding: const EdgeInsets.only(right: 15.0),
                child: const Text(
                  "توصيل الطلب إلى",
                  style: TextStyle(color: Colors.grey),
                )),
            Row(
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: const Text(
                      "موقع الزبون",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    )),
                IconButton(
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.red,
                    ),
                    onPressed: () {})
              ],
            ),
            Container(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: <Widget>[
                  const Icon(
                    Icons.menu,
                    color: Colors.red,
                    size: 40.0,
                  ),
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
                            hintText: "بحث",
                            suffixIcon: Icon(Icons.search)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 110.0,
              child: ListView.builder(
                  itemCount: myarr_category.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return SingleCatrgory(
                        cat_id: myarr_category[index]["cat_id"],
                        cat_name: myarr_category[index]["cat_name"],
                        cat_image: myarr_category[index]["cat_image"]);
                  }),
            ),
            SizedBox(
              height: 320.0,
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
          ]),
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: 0,
            selectedItemColor: Colors.red,
            selectedFontSize: 14,
            unselectedItemColor: Colors.grey,
            unselectedFontSize: 12,
            showSelectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications, size: 30.0),
                label: "الاشعارات",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.restaurant_menu, size: 30.0),
                  label: 'العروض'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person, size: 30.0), label: 'حسابي'),
            ]),
      ),
    );
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
    return Container(
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
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            pro_decs!,
            style: const TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
  }
}

class SingleCatrgory extends StatelessWidget {
  final String? cat_id;
  final String? cat_name;
  final String? cat_image;
  const SingleCatrgory({super.key, this.cat_id, this.cat_name, this.cat_image});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10.0),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.red[100]),
            child: Image.asset(
              cat_image!,
              width: 35,
              height: 35,
            ),
          ),
          Text(
            cat_name!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
