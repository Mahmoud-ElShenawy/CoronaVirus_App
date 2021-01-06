class GlobalSummaryModel {
  final DateTime dateTime;
  final int totalRecovered;
  final int totalConfirmed;
  final int totalDeaths;
  final int newDeaths;
  final int newRecovered;
  final int newConfirmed;

  GlobalSummaryModel({
      this.newConfirmed,
      this.totalConfirmed,
      this.newDeaths,
      this.totalDeaths,
      this.newRecovered,
      this.totalRecovered,
      this.dateTime,}
  );

  factory GlobalSummaryModel.fromJson(Map<String, dynamic> json) {
    return GlobalSummaryModel(
      newConfirmed: json['Global']['NewConfirmed'],
      totalConfirmed: json['Global']['TotalConfirmed'],
      newDeaths: json['Global']['NewDeaths'],
      totalDeaths: json['Global']['TotalDeaths'],
      newRecovered: json['Global']['NewRecovered'],
      totalRecovered: json['Global']['TotalRecovered'],
      dateTime: DateTime.parse(json['Date']),
    );
  }
}
