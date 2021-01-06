// Created By Mahmoud El Shenawy (Email : Mr.Mahmoud.El.Shenawy@Gmail.com)

class CountryModel {
  final String country;
  final String slug;
  final String iso2;

  CountryModel({
    this.country,
    this.slug,
    this.iso2,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      country: json['Country'],
      slug: json['Slug'],
      iso2: json['ISO2'],
    );
  }
}
