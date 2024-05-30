class TransferModel {
  String country;
  String city;
  String airport;
  DateTime departureDateTime;
  DateTime arrivalDateTime;

  TransferModel({
    required this.country,
    required this.city,
    required this.airport,
    required this.departureDateTime,
    required this.arrivalDateTime,
  });

  factory TransferModel.fromJson(Map<String, dynamic> json) {
    return TransferModel(
      country: json['country'],
      city: json['city'],
      airport: json['airport'],
      departureDateTime: DateTime.parse(json['departureDateTime']),
      arrivalDateTime: DateTime.parse(json['arrivalDateTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'city': city,
      'airport': airport,
      'departureDateTime': departureDateTime.toIso8601String(),
      'arrivalDateTime': arrivalDateTime.toIso8601String(),
    };
  }
}
