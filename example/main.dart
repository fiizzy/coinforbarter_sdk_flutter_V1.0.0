import 'package:coinforbarter_sdk/coinforbarter_sdk.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: coinForBarterNavigator(),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TheHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class TheHomePage extends StatefulWidget {
  const TheHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TheHomePage> createState() => _TheHomePageState();
}

class _TheHomePageState extends State<TheHomePage> {
  @override
  Widget build(BuildContext context) {
    theCallBack(int a, String b, dynamic c, Status s) {
      debugPrint('At the end of the day, The call back function works');
    }

    final PaymentConfig newPayment = PaymentConfig(
        // publicKey: '1645778437579HPc1e4KJi13T0eQrSW3LP4lDkxpE1',
        publicKey: 'XXXXX-XXXX-XXXX-XXXX',
        txRef: 'Flutter final Reference 1',
        amount: "150000",
        baseCurrency: 'NGN',
        customer: 'JohnDoe@noemail.cooom',
        customerFullName: 'John Amala Doe',
        callback: theCallBack);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[CoinForBarterButton(paymentConfig: newPayment)],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await coinForBarterInit(newPayment);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
