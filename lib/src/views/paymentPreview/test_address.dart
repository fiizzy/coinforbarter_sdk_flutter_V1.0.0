import 'package:coinforbarter_sdk/coinforbarter_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TestAddressCard extends StatelessWidget {
  const TestAddressCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ServiceController _serviceController = Get.find();
    final SelectCurrencyController _selectCurrencyController = Get.find();
    num amount = _selectCurrencyController.getAmount().value;
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
                  "https://developers.coinforbarter.com/docs/overview-test-wallets/",
                  style: MyStyles.bodyTextSmall,
                ),
                MyStyles.horizontalSpaceZero,
                InkWell(
                  child: Icon(
                    Icons.copy,
                    color: MyStyles.primaryPurple,
                    size: 20,
                  ),
                  onTap: () async {
                    await Clipboard.setData(const ClipboardData(
                        text:
                            "https://developers.coinforbarter.com/docs/overview-test-wallets/"));
                    Get.snackbar('Copied', 'Address copied!');
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              runAlignment: WrapAlignment.spaceBetween,
              children: [
                Text(
                  "$amount",
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
                    await Clipboard.setData(ClipboardData(text: "$amount"));
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
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
                color: MyStyles.faintRed,
                child: Center(
                  child: Text(
                    "Cancel",
                    style: MyStyles.bodyTextSmall,
                  ),
                ),
              ),
              onTap: () {
                showAlert(context);
              },
            ),
          ],
        ),
      ),
    ));
  }
}
