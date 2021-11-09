# CoinForBarter SDK

CoinForBarter Flutter SDK.

## Getting Started

This SDK allows you to recieve payments in cryptocurrency for your projects.

Follow these simple steps to start

1. Visit www.coinforbarter.com to get started by creating an account.
   >
2. Go to the API section of the dashboard and get your _public keys_ [test keys for testing]
   >
3. Import the CoinForBarter SDK and follow the code example.

> **IMPORTANT:**

To use CoinForBarter SDK, you must import `'package:coinforbarter_sdk/coinforbarter.dart';` in your `main.dart` file and set `navigatorKey: Get.key,` inside of your `MaterialApp()`

> This is because CoinForBarter SDK depends on contextless state management which depends on the [GetX_package](https://pub.dev/packages/get).

This however doesn't disturb any state managment package that you are using.

> Your standard `main.dart` code then looks like this

```dart
import 'package:flutter/material.dart';
import 'package:coinforbarter_sdk/coinforbarter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Include Get.key as the value of your navigatorKey likeso
        navigatorKey: Get.key,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ButtonPage());
  }
}


class ButtonPage extends StatelessWidget {
  final PaymentConfig newPayment = PaymentConfig(
      publicKey: 'XXXXXXXX-XXXXXXXX-XXXXXXX',
      txRef: 'Flutter final Reference 1',
      amount: 0.1,
      baseCurrency: 'ETH',
      customer: 'JohnDoe@noemail.cooom',
      customerFullName: 'John Amala Doe',
      callback: myCallBackFunction);

  ButtonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: CoinForBarterButton(
              color: Colors.red,
              textColor: Colors.white,
              paymentConfig: newPayment)),
    );
  }
}

myCallBackFunction(int a, String b, dynamic c, Status s) {
  debugPrint('At the end of the day, The call back function works');
}
```

## Want to contribute

Join the CoinForBarter Dev Slack Community [here](coinforbarter-fgc7751.slack.com)

If you would like to contribute to the SDK (e.g. by improving the documentation, solving a bug or adding a cool new feature), please carefully review the [codebase](https://github.com/fiizzy/coinforbarter_sdk_flutter_V1.0.0) and send in your [pull request](https://github.com/fiizzy/coinforbarter_sdk_flutter_V1.0.0/pulls).

## Author

This CoinForBarter SDK for Flutter is developed by [Github : Fiizzy](https://github.com/fiizzy) or [IG : Fizzy.codes](https://instagram.com/fizzy.codes) with ❤️
