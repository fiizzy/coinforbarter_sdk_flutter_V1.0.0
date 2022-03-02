// // ignore_for_file: file_names

// import 'package:flutter/material.dart';
// import 'package:coinforbarter_sdk/src/styles/styles.dart';

// class NextButton extends StatefulWidget {
//   // NextButton({Key? key}) : super(key: key);
//   final Color? color;
//   final Color? textColor;
//   final String? route;

//   const NextButton({
//     Key? key,
//     this.color,
//     this.textColor,
//     this.route,
//   }) : super(key: key);

//   @override
//   _NextButtonState createState() => _NextButtonState();
// }

// class _NextButtonState extends State<NextButton> {
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//         style: ButtonStyle(
//           padding: MaterialStateProperty.all(EdgeInsets.zero),
//         ),
//         onPressed: () async {
//           Navigator.pushNamed(context, widget.route!);
//         },
//         child: Container(
//           color: widget.color,
//           width: MediaQuery.of(context).size.width * .8,
//           height: MyStyles.buttonHeight,
//           child: Center(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.lock,
//                   color: widget.textColor,
//                 ),
//                 MyStyles.horizontalSpaceZero,
//                 Text('Pay with CoinForBarter',
//                     style: TextStyle(color: widget.textColor))
//               ],
//             ),
//           ),
//         ));
//   }
// }
