import 'package:stockmondash/model/transaction.dart';

class Trader {
  // This trader object will be the same from stock-data-master (https://github.com/RedrumSherlock/stockdatamaster)
  Trader(
    this.initFunds,
    this.cash,
    this.totalValue,
    this.startDate,
    this.endDate,
    this.name,
    this.latestPrice,
    this.positions,
    this.transactionList,
  );

  num initFunds;
  num cash;
  num totalValue;
  DateTime startDate;
  DateTime endDate;
  String name;
  Map<String, num> latestPrice;
  Map<String, int> positions;
  List<Transaction> transactionList;

  factory Trader.fromJson(Map<String, dynamic> json) {
    return Trader(
      json['init_funds'] as num,
      json['cash'] as num,
      json['total_value'] as num,
      DateTime.parse(json['start_date'] as String),
      DateTime.parse(json['end_date'] as String),
      json['trader_name'] as String,
      json['latest_price'] != null
          ? (json['latest_price'] as Map<String, dynamic>).map((key, value) => MapEntry(key, value as num))
          : {},
      json['position'] != null ? (json['position'] as Map<String, dynamic>).map((key, value) => MapEntry(key, value as int)) : {},
      json['last_5_transactions'] != null
          ? List<Transaction>.from(
              (json['last_5_transactions'] as Iterable<dynamic>).map<dynamic>(
                  (dynamic o) =>
                      Transaction.fromJson(o as Map<String, dynamic>)))
          : [],
    );
  }
}
