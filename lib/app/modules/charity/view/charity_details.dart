import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/charity/controller/charity_controller.dart';
import 'package:marketing_surplus/shared/service/util.dart';
import 'package:overlayment/overlayment.dart';

import '../../../data/model/charity.dart';

class CharityDetails extends GetView<CharityController> {
  final Charity? charity;

  const CharityDetails({this.charity, super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SizedBox(
          height: Get.height / 3,
          width: Get.width,
          child: Utility.getImage(
              base64StringPh: charity!.image, link: charity!.onlineImage),
        ),
        Container(
          height: Get.height / 3,
          width: Get.width,
          color: Colors.purple.withOpacity(0.3),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15, left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  charity!.name ?? '',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 21),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Align(
            alignment: Alignment.topRight,
            child: IconButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.purple.shade200)),
                onPressed: () {
                  Overlayment.dismissLast();
                },
                icon: Icon(Icons.arrow_back)),
          ),
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Flexible(
            child: SizedBox(
              height: Get.height / 3,
              width: Get.width,
            ),
          ),
          Flexible(
              flex: 2,
              child: Card(
                  margin: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(25),
                          right: Radius.circular(25))),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          charity!.name ?? '',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 19,
                                              color: Colors.purple.shade300),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Flexible(
                                                child: Text('target Group :')),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Flexible(
                                                child: Text(
                                                    charity!.targetGroup ?? ''))
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Flexible(child: Text('goals:')),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Flexible(
                                                child:
                                                    Text(charity!.goals ?? ''))
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Flexible(
                                                child: Text(
                                                    'Association License:')),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Flexible(
                                                child: Text(charity!
                                                        .associationLicense ??
                                                    ''))
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Flexible(child: Text('Email:')),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Flexible(
                                                child:
                                                    Text(charity!.email ?? ''))
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Flexible(child: Text('phone:')),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Flexible(
                                                child:
                                                    Text(charity!.phone ?? ''))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(18),
                                    child: FloatingActionButton.extended(
                                        backgroundColor: Colors.purple.shade200,
                                        onPressed: () async {
                                          await controller
                                              .saveCharityForDonatin(charity!);
                                        },
                                        label: SizedBox(
                                            width: Get.width / 2,
                                            child: Center(
                                                child: Text('Donation')))),
                                  )
                                ],
                              ),
                            ),
                          ]))))
        ])
      ]),
    );
  }
}
