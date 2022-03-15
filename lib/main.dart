import 'package:flutter/material.dart';
import 'coinforbarter_sdk.dart';

void main() async {
  // _initServices();
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Get.put(LockCurrencyController());
    return MaterialApp(
        navigatorKey: coinForBarterNavigator(),
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ButtonPage());
  }
}
