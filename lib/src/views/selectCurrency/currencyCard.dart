// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:coinforbarter_sdk/src/controllers/selectCurrency_controller.dart';
import 'package:coinforbarter_sdk/src/controllers/serviceController.dart';
import 'package:coinforbarter_sdk/src/controllers/setCurrencyController.dart';
import 'package:coinforbarter_sdk/src/styles/styles.dart';
import 'package:coinforbarter_sdk/src/utils/compareCurrencies.dart';
import 'package:coinforbarter_sdk/src/views/dialog/dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class CurrencyCard extends StatelessWidget {
  final SelectCurrencyController _selectCurrencyController =
      Get.put(SelectCurrencyController());
  final ServiceController _serviceController = Get.find();
  final SetCurrencyController _setCurrencyController =
      Get.put(SetCurrencyController());
  final List networks;
  late String currency = '';
  late String abbrevation = '';
  late String icon = '';
  String? selectedCurrency;

  CurrencyCard(
      {Key? key,
      required this.networks,
      required this.currency,
      required this.abbrevation,
      required this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    _selectCurrencyController.getCurrencies();
    _serviceController.getCurrencyListings();
    CompareCurrencies().compareCurrencies();
    networks.add(abbrevation);
    // Map toJsonMap = SetCurrencyController().initTojson();
    _setCurrencyController.initTojson();

    return Obx(() => Card(
          color: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.network(
                      icon,
                      placeholderBuilder: (BuildContext context) => Container(
                        // padding: const EdgeInsets.all(5.0),
                        child: const Icon(
                          Icons.circle,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                    MyStyles.horizontalSpaceZero,
                    Text(
                      "$abbrevation | $currency",
                      style: MyStyles.bodyText,
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
                Row(
                  children: [
                    DropdownButton<String?>(
                      hint: _setCurrencyController.isLoading.value &&
                              selectedCurrency == abbrevation
                          ? CircularProgressIndicator(
                              strokeWidth: 1,
                              color: MyStyles.primaryPurple,
                            )
                          : const Text('Network'),
                      icon: const Icon(Icons.keyboard_arrow_down_outlined),
                      style: TextStyle(color: MyStyles.darkGrey),
                      onChanged: (a) async {
                        selectedCurrency = _selectCurrencyController
                            .selectedNetworkArray[_selectCurrencyController
                                .selectedNetworkArray.length -
                            1];

                        //The response from the setCurrency PATCH request
                        Map setCurrencyResponse = await _setCurrencyController
                            .setCurrencyFromController(
                                _serviceController.paymentID,
                                selectedCurrency,
                                _selectCurrencyController.selectedNetwork,
                                _setCurrencyController.toJsonTestMap);

                        await infoDialog(context, setCurrencyResponse);
                        selectedCurrency = '';
                      },
                      items: networks
                          .sublist(
                              0,
                              _setCurrencyController.isLoading.value
                                  ? 0
                                  : networks.length - 1)
                          .map<DropdownMenuItem<String>>((dynamic value) {
                        return DropdownMenuItem<String>(
                          onTap: () {
                            _selectCurrencyController.handleDropDownChnages(
                                networks, value);
                          },
                          value: value,
                          child: Text(
                            value,
                            style: MyStyles.bodyTextSmall,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
