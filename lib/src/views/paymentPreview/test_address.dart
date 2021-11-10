import 'package:coinforbarter_sdk/coinforbarter.dart';
import 'package:flutter/material.dart';

class TestAddressCard extends StatelessWidget {
  const TestAddressCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ServiceController _serviceController = Get.find();

    return SizedBox(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
                child: Text(
                    'visit www.-----.com to make a test payment of this amount')),
            InkWell(
                onTap: () {
                  showAlert(context);
                },
                child: Text('The test address card')),
          ],
        ),
      ),
    ));
  }
}
