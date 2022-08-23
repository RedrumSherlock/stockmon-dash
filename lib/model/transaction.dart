class Transaction {
  // This transaction object will be the same from stock-data-master (https://github.com/RedrumSherlock/stockdatamaster)
  Transaction({
    this.amount,
    this.symbol,
    this.isBuy,
    this.price,
    this.dateTime,
  });

  double? amount;
  String? symbol;
  bool? isBuy;
  double? price;
  DateTime? dateTime;

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
        amount: json['amount'] as double,
        symbol: json['symbol'] as String,
        isBuy: json['action'] == 'buy' as bool,
        price: json['price'] as double,
        dateTime: DateTime.parse(json['dateTime'] as String));
  }
}
