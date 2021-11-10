import 'package:flutter/material.dart';

///Returns true if the API key is a test key
// ignore: non_constant_identifier_names
bool isAPIkeyTest(String APIkey) {
//Check substring
  String substring = APIkey.substring(0, 8);
  debugPrint('This is the API key substring: $substring');

  if (substring == 'C4B_TEST') {
    return true;
  } else {
    return false;
  }
}
