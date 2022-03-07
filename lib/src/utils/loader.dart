import 'package:flutter/material.dart';

import '../../coinforbarter_sdk.dart';

Widget loader() {
  return CircularProgressIndicator(
    color: MyStyles.primaryPurple,
    strokeWidth: 1,
  );
}
