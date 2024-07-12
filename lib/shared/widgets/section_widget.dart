import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SectionWidget extends GetView {
  const SectionWidget(
      {this.title, this.flex, this.icon, this.child, super.key});
  final String? title;
  final Widget? child;
  final int? flex;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    icon,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title ?? "",
                  style: TextStyle(color: Colors.purple.shade300, fontSize: 21),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: child!,
            ),
          )
        ],
      ),
    );
  }
}
