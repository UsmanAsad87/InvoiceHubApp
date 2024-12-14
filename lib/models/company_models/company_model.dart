import '../city_model/city_model.dart';
import '../country_model/country_model.dart';
import '../state_model/state_model.dart';

class CompanyModel {
  final String companyId;
  final String name;
  final String companyType;
  final String registrationNo;
  final Country? country;
  final String street;
  final City? city;
  final StateModel? state;
  final String email;
  final String phoneNo;
  final String websiteName;
  final String logo;
  final String fax;
  final String postCode;
  final Map<String, dynamic> searchTag;
  final DateTime? date;

  CompanyModel(
      {required this.companyId,
      required this.name,
      required this.companyType,
      required this.registrationNo,
      this.country,
      required this.street,
      required this.city,
      required this.state,
      required this.email,
      required this.phoneNo,
      required this.websiteName,
      required this.logo,
      required this.fax,
      required this.postCode,
      required this.searchTag,
      this.date});

  // Convert CompanyModel to a map
  Map<String, dynamic> toMap() {
    return {
      'companyId': companyId,
      'name': name,
      'companyType': companyType,
      'registrationNo': registrationNo,
      'country': country?.toJson(),
      'street': street,
      'city': city?.toJson(),
      'state': state?.toJson(),
      'email': email,
      'phoneNo': phoneNo,
      'websiteName': websiteName,
      'logo': logo,
      'fax': fax,
      'postCode': postCode,
      'searchTag': searchTag,
      'date': DateTime.now(),
    };
  }

  // Create a CompanyModel instance from a map
  factory CompanyModel.fromMap(Map<String, dynamic> map) {
    return CompanyModel(
      companyId: map['companyId'],
      name: map['name'],
      companyType: map['companyType'],
      registrationNo: map['registrationNo'],
      // country: Country.fromJson(map['country']),
      country: map['country'] is Map<String, dynamic>
          ? Country.fromJson(map['country'])
          : null,
      street: map['street'],
      city: map['city'] is Map<String, dynamic>
          ? City.fromJson(map['city'])
          : null,
      state: map['state'] is Map<String, dynamic>
          ? StateModel.fromJson(map['state'])
          : null,
      email: map['email'],
      phoneNo: map['phoneNo'],
      websiteName: map['websiteName'],
      logo: map['logo'],
      fax: map['fax'],
      postCode: map['postCode'],
      searchTag: map['searchTag'],
    );
  }

  // Create a new CompanyModel instance with updated values
  CompanyModel copyWith({
    String? companyId,
    String? name,
    String? companyType,
    String? registrationNo,
    Country? country,
    String? street,
    City? city,
    StateModel? state,
    String? email,
    String? phoneNo,
    String? websiteName,
    String? logo,
    String? fax,
    String? postCode,
    Map<String, dynamic>? searchTag,
  }) {
    return CompanyModel(
      companyId: companyId ?? this.companyId,
      name: name ?? this.name,
      companyType: companyType ?? this.companyType,
      registrationNo: registrationNo ?? this.registrationNo,
      country: country ?? this.country,
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      email: email ?? this.email,
      phoneNo: phoneNo ?? this.phoneNo,
      websiteName: websiteName ?? this.websiteName,
      logo: logo ?? this.logo,
      fax: fax ?? this.fax,
      postCode: postCode ?? this.postCode,
      searchTag: searchTag ?? this.searchTag,
    );
  }
}
