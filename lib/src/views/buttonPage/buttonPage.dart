// // ignore_for_file: file_names

// import 'package:flutter/material.dart';
// import 'package:coinforbarter_sdk/coinforbarter.dart';

// class ButtonPage extends StatelessWidget {
//   final PaymentConfig newPayment = PaymentConfig(
//       // publicKey: 'XXXXXXXX',
//       txRef: 'Flutter final Reference 1',
//       amount: "150000",
//       baseCurrency: 'NGN',
//       customer: 'JohnDoe@noemail.cooom',
//       customerFullName: 'John Amala Doe',
//       callback: myCallBackFunction);

//   ButtonPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//           child: CoinForBarterButton(
//               color: Colors.red,
//               textColor: Colors.white,
//               paymentConfig: newPayment)),
//     );
//   }
// }

// myCallBackFunction(int a, String b, dynamic c, Status s) {
//   debugPrint('At the end of the day, The call back function works');
//   Get.off(() => ButtonPage());
// }
