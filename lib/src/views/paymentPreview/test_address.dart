import 'package:coinforbarter_sdk/coinforbarter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TestAddressCard extends StatelessWidget {
  const TestAddressCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ServiceController _serviceController = Get.find();
    return SizedBox(
        child: Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              "TEST PAYMENT",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
                'Open the link below in your browser and make a test payment'),
            const SizedBox(
              height: 10,
            ),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              runAlignment: WrapAlignment.spaceBetween,
              children: [
                Text(
                  "https://coinforbarter.com",
                  style: MyStyles.bodyText,
                ),
                MyStyles.horizontalSpaceZero,
                InkWell(
                  child: Icon(
                    Icons.copy,
                    color: MyStyles.primaryPurple,
                    size: 20,
                  ),
                  onTap: () async {
                    await Clipboard.setData(
                        const ClipboardData(text: "https://coinforbarter.com"));
                    Get.snackbar('Copied', 'Address copied!');
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Wrap(
              children: [
                Text(
                  "${_serviceController.paymentID}",
                  style: MyStyles.bodyText,
                ),
                MyStyles.horizontalSpaceZero,
                InkWell(
                  child: Icon(
                    Icons.copy,
                    color: MyStyles.primaryPurple,
                    size: 20,
                  ),
                  onTap: () async {
                    await Clipboard.setData(
                        ClipboardData(text: "${_serviceController.paymentID}"));
                    Get.snackbar('Copied', 'Address copied!');
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {
                showAlert(context);
              },
              child: InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10),
                  color: MyStyles.faintRed,
                  child: Center(
                    child: Text(
                      "TERMINATE",
                      style: MyStyles.bodyTextSmall,
                    ),
                  ),
                ),
                onTap: () {
                  showAlert(context);
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
