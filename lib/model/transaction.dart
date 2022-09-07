class Transaction {
  // This transaction object will be the same from stock-data-master (https://github.com/RedrumSherlock/stockdatamaster)
  Transaction({
    this.amount,
    this.symbol,
    this.isBuy,
    this.price,
    this.dateTime,
  });

  int? amount;
  String? symbol;
  bool? isBuy;
  num? price;
  DateTime? dateTime;

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
        amount: json['amount'] as int,
        symbol: json['symbol'] as String,
        isBuy: (json['action'] as String).toLowerCase() == 'buy',
        price: json['price'] as num,
        dateTime: DateTime.parse(json['datetime'] as String));
  }
}
