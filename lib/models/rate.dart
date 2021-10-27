class Rate {
  double rate;
  String comment;

  Rate({required this.rate, required this.comment});

  factory Rate.fromJson(dynamic data) {
    return Rate(
      rate: data['rating'] == null ? 0.0 : data['rating'].toDouble(),
      comment: data['commentary'],
    );
  }
}