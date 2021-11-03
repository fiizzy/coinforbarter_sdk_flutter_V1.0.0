// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:coinforbarter_sdk/styles/styles.dart';

class ProductCard extends StatelessWidget {
  final String? businessName;
  final String? paymentDescription;
  final double? amount;
  final String? baseCurrrency;

  // ignore: use_key_in_widget_constructors
  const ProductCard(
      {this.businessName,
      this.paymentDescription,
      this.amount,
      this.baseCurrrency});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.circle),
                MyStyles.horizontalSpaceZero,
                Text(businessName!)
              ],
            ),
            const Divider(
              color: Colors.grey,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Description",
                style: MyStyles.headerOne,
                textAlign: TextAlign.left,
              ),
            ),
            MyStyles.verticalSpaceZero,
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                "$paymentDescription",
                style: MyStyles.bodyText,
                textAlign: TextAlign.left,
              ),
            ),
            MyStyles.verticalSpaceOne,
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Price",
                style: MyStyles.headerOne,
                textAlign: TextAlign.left,
              ),
            ),
            MyStyles.verticalSpaceZero,
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                "$amount $baseCurrrency",
                style: MyStyles.bodyText,
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
      ),
    );
  }
}
