class Insight {
  String insight;

  Insight({required this.insight});

  factory Insight.fromJson(Map<String, dynamic> json) {
    return Insight(
      insight: json['insight'],
    );
  }
}