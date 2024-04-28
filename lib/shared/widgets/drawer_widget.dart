import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDrawer extends GetView {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: const Text(
              "ghazal",
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            ),
            accountEmail: const Text(
              'ghazal@gmail.com',
              style: TextStyle(fontSize: 20.0, color: Colors.grey),
            ),
            currentAccountPicture: GestureDetector(
              child: const CircleAvatar(
                backgroundColor: Colors.purple,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
            decoration: BoxDecoration(color: Colors.grey[100]),
          ),
          InkWell(
            onTap: () {},
            child: const ListTile(
                trailing: Icon(
                  Icons.arrow_forward,
                  color: Colors.grey,
                ),
                title: Text(
                  "الصفحة الرئيسية",
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
                leading: Icon(
                  Icons.home,
                  color: Colors.purple,
                )),
          ),
        ],
      ),
    );
  }
}
