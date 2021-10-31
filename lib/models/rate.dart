class Rate {
  double rate;
  String comment;
  Map<String, dynamic> user;

  Rate({required this.rate, required this.comment, required this.user});

  factory Rate.fromJson(dynamic data) {
    return Rate(
        rate: data['rating'] == null ? 0.0 : data['rating'].toDouble(),
        comment: data['commentary'],
        user: data['user']);
  }
}
