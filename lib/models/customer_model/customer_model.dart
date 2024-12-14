import '../country_model/country_model.dart';

class CustomerModel {
  final String customerId;
  final String companyName;
  final String name;
  final String email;
  final String phoneNo;
  final String billingAddress1;
  final String billingAddress2;
  final Country? country;
  // final String workingAddress1;
  // final String workingAddress2;
  final String image;
  final String note;
  final Map<String, dynamic> searchTags;
  DateTime? date;

  CustomerModel({
    required this.customerId,
    required this.companyName,
    required this.email,
    required this.name,
    required this.phoneNo,
    required this.billingAddress1,
    required this.billingAddress2,
    this.country,
    // required this.workingAddress1,
    // required this.workingAddress2,
    required this.image,
    required this.note,
    required this.searchTags,
    this.date,
  });

  // Named constructor for creating a CustomerModel from a map
  CustomerModel.fromMap(Map<String, dynamic> map)
      : customerId = map['customerId'],
        companyName = map['companyName'],
        name = map['name'],
        email = map['email'],
        phoneNo = map['phoneNo'],
        billingAddress1 = map['billingAddress1'],
        billingAddress2 = map['billingAddress2'],
        country = map['country'] is Map<String, dynamic>
            ? Country.fromJson(map['country'])
            : null,
        // map['country'],
        // workingAddress1 = map['workingAddress1'],
        // workingAddress2 = map['workingAddress2'],
        image = map['image'],
        note = map['note'],
        searchTags = Map<String, dynamic>.from(map['searchTags']);

  // Method to convert CustomerModel to a map
  Map<String, dynamic> toMap() {
    return {
      'customerId': customerId,
      'companyName': companyName,
      'name' : name,
      'email': email,
      'phoneNo': phoneNo,
      'billingAddress1': billingAddress1,
      'billingAddress2': billingAddress2,
      'country': country?.toJson(),
      // 'workingAddress1': workingAddress1,
      // 'workingAddress2': workingAddress2,
      'note': note,
      'image': image,
      'searchTags': searchTags,
      'date' : DateTime.now()
    };
  }

  // Method to create a copy of CustomerModel with specified fields changed
  CustomerModel copyWith({
    String? customerId,
    String? companyName,
    String? name,
    String? email,
    String? phoneNo,
    String? billingAddress1,
    String? billingAddress2,
    Country? country,
    // String? workingAddress1,
    // String? workingAddress2,
    String? note,
    String? image,
    Map<String, dynamic>? searchTags,
  }) {
    return CustomerModel(
      customerId: customerId ?? this.customerId,
      companyName: companyName ?? this.companyName,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNo: phoneNo ?? this.phoneNo,
      billingAddress1: billingAddress1 ?? this.billingAddress1,
      billingAddress2: billingAddress2 ?? this.billingAddress2,
      country: country ?? this.country,
      // workingAddress1: workingAddress1 ?? this.workingAddress1,
      // workingAddress2: workingAddress2 ?? this.workingAddress2,
      note: note ?? this.note,
      image: image ?? this.image,
      searchTags: searchTags ?? this.searchTags,
    );
  }
}
