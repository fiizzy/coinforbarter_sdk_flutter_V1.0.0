import 'package:flutter/material.dart';

import '../../coinforbarter_sdk.dart';

Widget loader() {
  return Container(
    padding: const EdgeInsets.all(5),
    height: 30,
    width: 30,
    child: CircularProgressIndicator(
      color: MyStyles.primaryPurple,
      strokeWidth: 1,
    ),
  );
}
