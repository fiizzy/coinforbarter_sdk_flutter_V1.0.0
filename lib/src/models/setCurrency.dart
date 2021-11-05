// ignore_for_file: file_names

class SetCurrency {
  String? customer;
  String? txRef;
  String? baseCurrency;
  double? amount;

  SetCurrency({this.amount, this.baseCurrency, this.customer, this.txRef});

  Map toJson() {
    return {
      'customer': customer,
      'txRef': txRef,
      'baseCurrency': baseCurrency,
      'amount': amount,
    };
  }
}
