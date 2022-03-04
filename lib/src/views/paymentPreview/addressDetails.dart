// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:coinforbarter_sdk/src/controllers/lock_currency_controller.dart';
import 'package:coinforbarter_sdk/src/controllers/selectCurrency_controller.dart';
import 'package:coinforbarter_sdk/src/controllers/setCurrencyController.dart';
import 'package:coinforbarter_sdk/src/styles/styles.dart';
import 'package:coinforbarter_sdk/src/utils/alert.dart';
import 'package:coinforbarter_sdk/src/utils/route.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddressDetails extends StatelessWidget {
  AddressDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // const AddressDetails({Key? key}) : super(key: key);
    final SelectCurrencyController _selectCurrencyController = Get.find();
    final SetCurrencyController _setCurrencyController = Get.find();
    final LockCurrencyController _lockCurrencyController = Get.find();

    num amount = _selectCurrencyController.getAmount().value;
    String currency =
        _setCurrencyController.setCurrencyResponse!['data']['currency'];
    String network = _selectCurrencyController.selectedNetwork.value;
    // print(_lockCurrencyController.lockCurrencyresponse['data']);
    String address = _lockCurrencyController.lockCurrencyresponse['data']
        ['addressInformation']['address'];

    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Wrap(
                  direction: Axis.horizontal,
                  children: [
                    const Text('You are to transfer'),
                    MyStyles.horizontalSpaceZero,
                    Text(
                      '$amount $currency}',
                      style: MyStyles.bodyTextBold,
                    ),
                    Text(' on $network network'),
                  ],
                )),
            MyStyles.verticalSpaceOne,
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Address",
                style: MyStyles.bodyTextBold,
              ),
            ),
            MyStyles.verticalSpaceZero,
            Wrap(
              children: [
                Text(
                  address,
                  style: MyStyles.bodyText,
                ),
                MyStyles.horizontalSpaceZero,
                InkWell(
                  child: Icon(
                    Icons.copy,
                    color: MyStyles.primaryPurple,
                    size: 30,
                  ),
                  onTap: () async {
                    await Clipboard.setData(ClipboardData(text: address));
                    Get.snackbar('Copied', 'Address copied!');
                  },
                ),
              ],
            ),
            Image.network(
              QRcode().getQRcode(currency, address, amount, network),
              height: 200,
              errorBuilder: (context, object, stacktrace) {
                return Container(
                  padding: const EdgeInsets.all(70),
                  child: const Text(
                      "Unable to get QR code. Copy the address instead"),
                );
              },
              // loadingBuilder: (a, b, c) {
              //   return const CircularProgressIndicator();
              // },
            ),
            MyStyles.verticalSpaceOne,
            Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
                color: MyStyles.listeningColor,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  direction: Axis.horizontal,
                  children: [
                    Text(
                        'We are now listening to your transaction on the address above ',
                        style: MyStyles.bodyTextSmall),
                  ],
                )),
            MyStyles.verticalSpaceOne,
            Material(
              child: InkWell(
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
                onTap: () async {
                  await showAlert(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
