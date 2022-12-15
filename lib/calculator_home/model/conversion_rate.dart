class ConvertSymbol{
  final double price;

  const ConvertSymbol({
    required this.price,
  });

  factory ConvertSymbol.fromJson(Map<String, dynamic> json, String symbol) {
    return ConvertSymbol(
      price: json[symbol]['price'] as double,
    );
  }
}
class ConversionRate {
  final ConvertSymbol quote;

  const ConversionRate({
    required this.quote,
  });

  factory ConversionRate.fromJson(Map<String, dynamic> json, String symbol) {
    return ConversionRate(
      quote: ConvertSymbol.fromJson(json['quote'], symbol),
    );
  }
}