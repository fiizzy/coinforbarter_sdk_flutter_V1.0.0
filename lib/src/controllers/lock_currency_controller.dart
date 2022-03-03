import 'package:coinforbarter_sdk/src/controllers/serviceController.dart';
import 'package:coinforbarter_sdk/src/services/services.dart';
import 'package:get/get.dart';

class LockCurrencyController extends GetxController {
  final ServiceController _serviceController = Get.find();
  Map lockCurrencyresponse = {}.obs;
  Rx<bool> isLoading = false.obs;

//Call lock currency service

  Future<Map> lockCurrencyService() async {
    isLoading.value = true;
    lockCurrencyresponse =
        await Services().lockCurrency(_serviceController.paymentID);
    isLoading.value = false;
    return lockCurrencyresponse;
  }
}
