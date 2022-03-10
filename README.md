# CoinForBarter SDK

### Getting Started

This SDK allows you to recieve payments in cryptocurrency for your projects.

Follow these simple steps to start

1. Visit www.coinforbarter.com to get started by creating an account.
   >
2. Go to the API section of the dashboard and get your _public keys_ [test keys for testing]
   >
3. Import the CoinForBarter SDK and follow the code example.

   - You can read more on how to integrate this SDK in your flutter app via this [medium post](https://medium.com/@obilaja/how-to-integrate-a-cryptocurrency-payment-gateway-in-your-flutter-app-9e97ca72d91e)

#### Install CoinForBarter

Add the following line to your pubspec.yaml file.

```dart
dependencies: coinforbarter_sdk:
```

_You are advised to use the latest version of the SDK for the best experience._

#### Import the SDK

```dart
import 'package:coinforbarter_sdk/coinforbarter.dart';
```

#### Initialize the NavigatorKey in your MaterialApp

Under the hood, coinForBarter SDK depends on a contextless Navigation, so you have to provide a `coinForBarterNavigator()` to your `MaterialApp()`

```dart
import 'package:flutter/material.dart';
import 'package:coinforbarter_sdk/coinforbarter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Include coinForBarterNavigator as the value of your navigatorKey likeso
        navigatorKey: coinForBarterNavigator(),
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ButtonPage());
  }
}


class ButtonPage extends StatelessWidget {

  ButtonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text("Testing payments")),
      );
    }
  }
}
```

#### Initalize your PaymentConfig

The `PaymentConfig()` object allows you provide a payload that contains most of your payment requests that the CoinForBarter API uses to process your payment transactions. The filed variables include

- `publicKey`
- `txRef`
- `amount`
- `baseCurrency`
- `customer`
- `customerFullName`
- `callback`
  - ##### The callback function
    Your callback function should recieve 4 main arguments which are going to be passed through into your function when a payment has been processed. The arguments are in this order
    - `statusCode`
      - Returns the status code of the payment after it has ended
        >
    - `message`
      - Returns a standard coinForBarter message
        >
    - `data`
      - This provides more details about the transaction.
        >
    - `Status`
      - An enum that returns either `Status.success`, `Status.error`, `Status.cancelled`

The code from above should look something like this when your `paymentConfig()` is set:

```dart
import 'package:flutter/material.dart';
import 'package:coinforbarter_sdk/coinforbarter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Include coinForBarterNavigator as the value of your navigatorKey likeso
        navigatorKey: coinForBarterNavigator(),
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
          child: Text("Testing payments")),
      );
    }
}

myCallBackFunction(int statusCode, String data, String message, Status status) {
  debugPrint('At the end of the day, The call back function works');
}
```

#### Starting a Payment

Now that we have our payment config already setup, we are noe ready to connect to the coinForbarter API. We can initialize payment by two major ways:

- `CoinForBarterButton()`
  - The provides you a button that allows you pass in a `color`, `textColor` and your `PaymentConfig()` object.
    >
- `coinForBarterInit()`
  - This is a function of type `Future<void>` that gives you more control to use the payment API however you want to call it.

Example below:

```dart
import 'package:flutter/material.dart';
import 'package:coinforbarter_sdk/coinforbarter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Include coinForBarterNavigator as the value of your navigatorKey likeso
        navigatorKey: coinForBarterNavigator(),
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

myCallBackFunction(int statusCode, String data, String message, Status status) {
  debugPrint('At the end of the day, The call back function works');
}
```

or call the init function in a button like so:

```dart
ElevatedButton(
  child:Text(data),
  onTap: () async {
    await coinForBarterInit();
  }
);
```

Once the function is called, or the button pressed, CoinForBarter handles everything there on.

#### Error Handling

Errors are logged to the console, and sometimes also logged on the app in form of drop downs.

## Want to contribute

You can read more about [CoinForBarter](https://coinforbarter.com) or the [official docs here](https://developers.coinforbarter.com)

Join the CoinForBarter Dev Slack Community [here](coinforbarter-fgc7751.slack.com)

If you would like to contribute to the SDK (e.g. by improving the documentation, solving a bug or adding a cool new feature), please carefully review the [codebase](https://github.com/fiizzy/coinforbarter_sdk_flutter_V1.0.0) and send in your [pull request](https://github.com/fiizzy/coinforbarter_sdk_flutter_V1.0.0/pulls).

## Author

This CoinForBarter SDK for Flutter is developed by [Github : Fiizzy](https://github.com/fiizzy) or [IG : Fizzy.codes](https://instagram.com/fizzy.codes) with ❤️
