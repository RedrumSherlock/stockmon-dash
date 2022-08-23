class Market {
  // This market object will be the same from stock-data-master (https://github.com/RedrumSherlock/stockdatamaster)
  Market(
    this.currentDay,
    this.type,
    this.isValid,
  );

  String currentDay;
  String type;
  bool isValid;

  factory Market.fromJson(Map<String, dynamic> json) {
    return Market(
      json['current_day'] as String,
      json['market_type'] as String,
      json['market_valid'][0] as bool,
    );
  }
}
