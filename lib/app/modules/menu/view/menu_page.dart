import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/widgets/animated_toggle.dart';
import '../controller/menu_controller.dart' as con;

class MenView extends GetView<con.MenuController> {
  MenView({super.key});
  final TextEditingController _controller = TextEditingController(
    text: '',
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: SizedBox(
                        height: 45,
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: Colors.purple),
                            ),
                            hintText: "Search for Items",
                            prefixIcon: const Icon(Icons.search),
                            prefixIconColor: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.purple.shade200)),
                      child: Padding(
                        padding: const EdgeInsets.all(11),
                        child: InkWell(
                          child: Icon(
                            Icons.segment_rounded,
                            color: Colors.purple.shade200,
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              AnimatedToggle(
                values: const ['List', 'Map'],
                onToggleCallback: (value) {
                  controller.toggleValue.value = value;
                },
                buttonColor: Colors.purple.shade200,
                backgroundColor: Colors.purple.shade100,
                textColor: const Color(0xFFFFFFFF),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text('Sort by:'),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 110,
                          child: DropdownButton<String>(
                            iconEnabledColor: Colors.purple,
                            items: <String>['Hello Here', 'B', 'C', 'D']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(color: Colors.purple),
                                ),
                              );
                            }).toList(),
                            onChanged: (_) {},
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Text('Sold Out'),
                        const SizedBox(
                          width: 5,
                        ),
                        CupertinoSwitch(
                          value: true,
                          activeColor: Colors.purple.shade200,
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              Icon(
                Icons.location_pin,
                size: 150,
                color: Colors.purple.shade200,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'No stores in this area, yet!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                    color: Colors.purple.shade200),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Try changing your location or expanding',
              ),
              const Text(
                ' your distance to get more result',
              ),
              const SizedBox(
                height: 20,
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
                        'choose location',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )),
            ],
          ),
          const SizedBox()
        ],
      ),
    );
  }
}
