class ConvertedSimpleObject {
  const ConvertedSimpleObject({
    this.aString,
    this.anInt,
    this.aDouble,
    this.aListOfStrings,
    this.aListOfInts,
    this.aListOfDoubles,
  });

  final String? aString;
  final int? anInt;
  final double? aDouble;
  final List<String>? aListOfStrings;
  final List<int>? aListOfInts;
  final List<double>? aListOfDoubles;

  factory ConvertedSimpleObject.fromJson(Map<String, dynamic> json) {
    return ConvertedSimpleObject(
      aString: json['aString'] as String?,
      anInt: json['anInt'] as int?,
      aDouble: json['aDouble'] as double?,
      aListOfStrings: json['aListOfStrings'] != null
          ? List<String>.from(json['aListOfStrings'] as Iterable<dynamic>)
          : null,
      aListOfInts: json['aListOfInts'] != null
          ? List<int>.from(json['aListOfInts'] as Iterable<dynamic>)
          : null,
      aListOfDoubles: json['aListOfDoubles'] != null
          ? List<double>.from(json['aListOfDoubles'] as Iterable<dynamic>)
          : null,
    );
  }
}
