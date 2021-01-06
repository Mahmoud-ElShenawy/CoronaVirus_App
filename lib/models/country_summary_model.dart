class CountrySummaryModel {
  final DateTime dateTime;
  final String country;
  final int confirmed;
  final int active;
  final int deaths;
  final int recovered;

  CountrySummaryModel({
    this.dateTime,
    this.country,
    this.confirmed,
    this.active,
    this.deaths,
    this.recovered,
  });

  factory CountrySummaryModel.fromJson(Map<String, dynamic> json) {
    return CountrySummaryModel(
      dateTime: DateTime.parse(json['Date']),
      country: json['Country'],
      confirmed: json['Confirmed'],
      active: json['Active'],
      deaths: json['Deaths'],
      recovered: json['Recovered'],
    );
  }
}
