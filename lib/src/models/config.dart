class PaymentConfig {
  String? publicKey;
  String? txRef;
  dynamic amount;
  String? baseCurrency;
  Map<String, dynamic>? meta;
  String? customer;
  String? customerPhoneNumber;
  String? customerFullName;

  ///This receives a Status code, message, Data (By the user) and Payment Status enum to be used when the payment ends
  Function(int statuscode, String message, dynamic data, Status)? callback;

  PaymentConfig(
      {required this.publicKey,
      required this.txRef,
      required this.amount,
      required this.baseCurrency,
      required this.customer,
      required this.customerFullName,
      required this.callback,
      this.customerPhoneNumber});
}

enum Status {
  success,
  error,
}
