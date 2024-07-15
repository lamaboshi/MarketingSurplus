import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/service/util.dart';
import '../../../../shared/widgets/textfield_widget.dart';
import '../../../data/model/company_type_model.dart';
import '../controller/setting_profile_controller.dart';

class ProfileDetailsCompany extends GetView<SettingProfileController> {
  const ProfileDetailsCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        child: Column(
          children: [
            Positioned(
              bottom: 0,
              right: Get.width / 2.5,
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.purple.shade100, width: 4),
                    borderRadius: const BorderRadius.all(Radius.circular(80))),
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: Obx(() => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: controller.stringPickImage.value.isNotEmpty
                            ? Utility.imageFromBase64String(
                                controller.stringPickImage.value, 70, 70)
                            : Utility.getImage(
                                base64StringPh: controller.company.value.image,
                                link: controller.company.value.onlineImage),
                      )),
                ),
              ),
            ),
            controller.isNotEdit.value
                ? SizedBox.shrink()
                : InkWell(
                    onTap: () {
                      controller.pickImageFun();
                    },
                    child: Text('AddYourPhoto'.tr)),
            Text(
              controller.company.value.name == null
                  ? ''
                  : controller.company.value.name!,
              style: TextStyle(
                  color: Colors.purple.shade300,
                  fontWeight: FontWeight.bold,
                  fontSize: 21),
            ),
            TextFieldWidget(
              value: controller.company.value.email,
              onChanged: (value) {
                controller.company.value.email = value;
              },
              textInputType: TextInputType.emailAddress,
              label: 'entem-title'.tr,
              isReadOnly: controller.isNotEdit.value,
            ),
            TextFieldWidget(
              value: controller.company.value.name,
              onChanged: (value) {
                controller.company.value.name = value;
              },
              textInputType: TextInputType.emailAddress,
              label: 'entername-title'.tr,
              isReadOnly: controller.isNotEdit.value,
            ),
            TextFieldWidget(
              value: controller.company.value.password,
              onChanged: (value) {
                controller.company.value.password = value;
              },
              textInputType: TextInputType.emailAddress,
              label: 'entpass-title'.tr,
              isReadOnly: controller.isNotEdit.value,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () => DropdownButton<CompanyTypeModel>(
                  isExpanded: true,
                  hint:
                      Text('pleasechos-title'.tr), // Not necessary for Option 1
                  value: controller.companyTypes
                      .where((p0) =>
                          p0.id == controller.company.value.companyTypeId)
                      .first,
                  onChanged: controller.isNotEdit.value
                      ? null
                      : (newValue) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          controller.company.value.companyTypeId = newValue!.id;
                        },
                  items: controller.companyTypes.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e.type!),
                    );
                  }).toList(),
                ),
              ),
            ),
            TextFieldWidget(
              value: controller.company.value.licenseNumber,
              onChanged: (value) {
                controller.company.value.licenseNumber = value;
              },
              textInputType: TextInputType.emailAddress,
              label: 'licnum-title'.tr,
              isReadOnly: controller.isNotEdit.value,
            ),
            TextFieldWidget(
              value: controller.company.value.address,
              onChanged: (value) {
                controller.company.value.address = value;
              },
              textInputType: TextInputType.emailAddress,
              label: 'enteradd-title'.tr,
              isReadOnly: controller.isNotEdit.value,
            ),
            TextFieldWidget(
              value: controller.company.value.telePhone,
              onChanged: (value) {
                controller.company.value.telePhone = value;
              },
              textInputType: TextInputType.emailAddress,
              isReadOnly: controller.isNotEdit.value,
              label: 'tele-title'.tr,
            ),
          ],
        ),
      ),
    );
  }
}
