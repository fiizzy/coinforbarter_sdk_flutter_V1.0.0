import 'package:flutter/material.dart';
import 'package:flutter_sdk_2/styles/styles.dart';

class ProductCard extends StatelessWidget {
  final String? businessName;
  final String? paymentDescription;
  final double? amount;
  final String? baseCurrrency;

  // ignore: use_key_in_widget_constructors
  ProductCard(
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
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.circle),
                  MyStyles.horizontalSpaceZero,
                  Container(
                    child: Text(businessName!),
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Description",
                style: MyStyles.headerOne,
                textAlign: TextAlign.left,
              ),
            ),
            MyStyles.verticalSpaceZero,
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                "$paymentDescription",
                style: MyStyles.bodyText,
                textAlign: TextAlign.left,
              ),
            ),
            MyStyles.verticalSpaceOne,
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Price",
                style: MyStyles.headerOne,
                textAlign: TextAlign.left,
              ),
            ),
            MyStyles.verticalSpaceZero,
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                "$amount $baseCurrrency",
                style: MyStyles.bodyText,
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
        padding: EdgeInsets.all(20),
      ),
    );
  }
}
