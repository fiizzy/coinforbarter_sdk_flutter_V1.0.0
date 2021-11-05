// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:coinforbarter_sdk/src/styles/styles.dart';

class SecuredByCoinForBarter extends StatelessWidget {
  const SecuredByCoinForBarter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock, size: 15),
            MyStyles.horizontalSpaceZero,
            Text(
              'Secured By CoinfForBarter',
              style: MyStyles.bodyTextSmall,
            )
          ],
        ),
      ),
    );
  }
}
