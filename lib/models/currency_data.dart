class CurrencyData {
  final String base;
  final int amount;
  final Map<String, dynamic> result;
  final int ms;

  CurrencyData({
    required this.base,
    required this.amount,
    required this.result,
    required this.ms,
  });

  factory CurrencyData.fromJson(Map<String, dynamic> json) {
    return CurrencyData(
      base: json['base'],
      amount: json['amount'],
      result: json['result'],
      ms: json['ms'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'base': base,
      'amount': amount,
      'result': result,
      'ms': ms,
    };
  }
}
