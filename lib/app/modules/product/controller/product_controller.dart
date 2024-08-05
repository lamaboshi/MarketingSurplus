import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:overlayment/overlayment.dart';

import '../../../../shared/service/order_service.dart';
import '../../../../shared/service/util.dart';
import '../../../data/model/product.dart';

class ProductController extends GetxController {
  final keyForm = GlobalKey<FormState>();
  final stringPickImage = ''.obs;
  final errorData = ''.obs;
  final amount = 0.obs;
  final newProduct = Product(
          name: 'test',
          descripation: 'Some Data',
          expiration: DateTime.now().add(const Duration(days: 2)),
          dateTime: DateTime.now(),
          oldPrice: 300,
          newPrice: 100)
      .obs;
  String? forceValue(String? value) {
    if (value == null || value.isEmpty) {
      return 'requird';
    }
    return null;
  }

  Future<bool> updateProduct() async {
    if (stringPickImage.value.trim().isNotEmpty) {
      newProduct.value.image =
          Utility.dataFromBase64String(stringPickImage.value);
    }

    var result = await OrderService().updateProduct(newProduct.value);
    if (result) {
      stringPickImage.value = '';
      Overlayment.dismissLast();
      onInit();
    }
    return result;
  }

  Future<void> deleteProduct(int id) async {
    var result = await OrderService().deleteProduct(id);
    if (result) {
      Overlayment.dismissLast();
      onInit();
    }
  }

  Future pickImageFun() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      stringPickImage.value = Utility.base64String(await image.readAsBytes());
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }
}
