import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/favorites/controller/favorites_controller.dart';

class FavoritesView extends GetView<FavoritesController> {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Column(
              children: [
                Text(
                  'No favorites added yet',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Tap the heart icon on a store to add it to your',
                ),
                Text(
                  'favorites and it will show up here',
                ),
              ],
            ),
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: SizedBox(
              height: 140,
              width: 350,
              child: Column(
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                        color: Colors.grey.shade300,
                        child: SizedBox(
                          height: 100,
                          width: 350,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                    alignment: Alignment.topRight,
                                    child: Obx(
                                      () => Icon(
                                        Icons.favorite,
                                        color: controller.currentColor.value,
                                      ),
                                    )),
                                const Align(
                                    alignment: Alignment.topLeft,
                                    child: Icon(
                                      Icons.circle,
                                      color: Colors.white,
                                      size: 50,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      )),
                  Expanded(
                      child: Container(
                    color: Colors.white,
                    child: const SizedBox(
                      height: 40,
                      width: 350,
                    ),
                  ))
                ],
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple.shade200,
                  shape: const StadiumBorder()),
              child: const SizedBox(
                width: 150,
                height: 50,
                child: Center(
                  child: Text(
                    'Find a Surprise Bag',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )),
          const SizedBox()
        ],
      ),
    );
  }
}
