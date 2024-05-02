import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritesController extends GetxController {
  final currentColor = Colors.white.obs;
  Timer? _timer;
  @override
  void onInit() {
    _startTimer();
    super.onInit();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      currentColor.value =
          currentColor.value == Colors.white ? Colors.purple : Colors.white;
    });
  }
}
