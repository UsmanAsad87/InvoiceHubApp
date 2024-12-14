import 'package:invoice_producer/core/enums/signup_method_enum.dart';

import '../../../../core/enums/account_type.dart';
import 'daily_availability_model.dart';

class UserModel {
  final String uid;
  final String fullName;
  final String email;
  final SignUpMethodEnum signUpMethod;
  final String? profileImage;
  final String? address;
  final String? city;
  final String? country;
  final String? state;
  final String? zipCode;
  final String? defaultCompany;
  final String? defaultCard;
  final String? phoneNo;
  final bool? rememberMe;
  final String? fcmToken;
  final Map<String, dynamic>? searchTags;
  final String? subscriptionId;
  final String? subscriptionName;
  final bool? subscriptionIsValid;
  final bool? subscriptionApproved;
  final DateTime? subscriptionAdded;
  final DateTime? subscriptionExpire;

  UserModel(
      {
        required this.uid,
      required this.fullName,
      required this.email,
      required this.signUpMethod,
      this.profileImage,
      this.address,
      this.city,
      this.country,
      this.state,
      this.zipCode,
      this.defaultCompany,
      this.defaultCard,
      this.phoneNo,
        this.rememberMe,
      this.fcmToken,
      this.searchTags,
      this.subscriptionId,
      this.subscriptionName,
      this.subscriptionIsValid,
      this.subscriptionApproved,
      this.subscriptionAdded,
      this.subscriptionExpire});

  // Convert UserModel instance to JSON
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'signUpMethod': signUpMethod.method,
      'profileImage': profileImage,
      'address': address,
      'city': city,
      'country': country,
      'state': state,
      'zipCode': zipCode,
      'defaultCompany': defaultCompany,
      'defaultCard': defaultCard,
      'phoneNo': phoneNo,
      'rememberMe' : rememberMe,
      'fcmToken': fcmToken,
      'searchTags': searchTags,
      'subscriptionId': subscriptionId,
      'subscriptionName': subscriptionName,
      'subscriptionIsValid': subscriptionIsValid,
      'subscriptionApproved': subscriptionApproved,
      'subscriptionAdded': subscriptionAdded?.toIso8601String(),
      'subscriptionExpire': subscriptionExpire?.toIso8601String(),
    };
  }

  // Create a UserModel instance from JSON
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      fullName: map['fullName'],
      email: map['email'],
      signUpMethod: (map['signUpMethod'] as String).toSignUpMethodEnum(),
      profileImage: map['profileImage'] ?? '',
      address: map['address'] ?? '',
      city: map['city'] ?? '',
      country: map['country'] ?? '',
      state: map['state'] ?? '',
      zipCode: map['zipCode'] ?? '',
      defaultCompany: map['defaultCompany'] ?? '',
      defaultCard: map['defaultCard'] ?? '',
      phoneNo: map['phoneNo'] ?? '',
      rememberMe: map['rememberMe'] ?? false,
      fcmToken: map['fcmToken'] ?? '',
      searchTags: map['searchTags'] ?? '',
      subscriptionId: map['subscriptionId'] ?? '',
      subscriptionName: map['subscriptionName'] ?? '',
      // subscriptionIsValid: map['subscriptionIsValid'] ?? '',
      subscriptionApproved: map['subscriptionApproved'] ?? false,
      subscriptionAdded: map['subscriptionAdded'] == null ? null : DateTime.parse(map['subscriptionAdded']),
      subscriptionExpire: map['subscriptionExpire'] == null ? null : DateTime.parse(map['subscriptionExpire']),
    );
  }

  UserModel copyWith({
    String? uid,
    String? fullName,
    String? email,
    SignUpMethodEnum? signUpMethod,
    String? profileImage,
    String? address,
    String? city,
    String? country,
    String? state,
    String? zipCode,
    String? defaultCompany,
    String? defaultCard,
    String? phoneNo,
    bool? rememberMe,
    String? fcmToken,
    Map<String, dynamic>? searchTags,
    String? subscriptionId,
    String? subscriptionName,
    bool? subscriptionIsValid,
    bool? subscriptionApproved,
    DateTime? subscriptionAdded,
    DateTime? subscriptionExpire,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      signUpMethod: signUpMethod ?? this.signUpMethod,
      profileImage: profileImage ?? this.profileImage,
      address: address ?? this.address,
      city: city ?? this.city,
      country: country ?? this.country,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      defaultCompany: defaultCompany ?? this.defaultCompany,
      defaultCard: defaultCard ?? this.defaultCard,
      phoneNo: phoneNo ?? this.phoneNo,
      rememberMe: rememberMe ?? this.rememberMe,
      fcmToken: fcmToken ?? this.fcmToken,
      searchTags: searchTags ?? this.searchTags,
      subscriptionId: subscriptionId ?? this.subscriptionId,
      subscriptionName: subscriptionName ?? this.subscriptionName,
      subscriptionIsValid: subscriptionIsValid ?? this.subscriptionIsValid,
      subscriptionApproved: subscriptionApproved ?? this.subscriptionApproved,
      subscriptionAdded: subscriptionAdded ?? this.subscriptionAdded,
      subscriptionExpire: subscriptionExpire ?? this.subscriptionExpire,
    );
  }
}

// class UserModel{
//   final String uid;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final AccountTypeEnum accountType;
//   final DateTime createdAt;
//   final String profileImage;
//   final String phoneNumber;
//   final bool isNew;
//   final int totalNumberOfBookings;
//   final double totalAmountSpent;
//   final String fcmToken;
//   final bool isAvailable;
//   final bool isOnline;
//   final List<DailyAvailabilityModel> barberAvailability;
//   final Map<String, dynamic> searchTags;
//
// //<editor-fold desc="Data Methods">
//   const UserModel({
//     required this.uid,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.accountType,
//     required this.createdAt,
//     required this.profileImage,
//     required this.phoneNumber,
//     required this.isNew,
//     required this.totalNumberOfBookings,
//     required this.totalAmountSpent,
//     required this.fcmToken,
//     required this.isAvailable,
//     required this.isOnline,
//     required this.barberAvailability,
//     required this.searchTags,
//   });
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       (other is UserModel &&
//           runtimeType == other.runtimeType &&
//           uid == other.uid &&
//           firstName == other.firstName &&
//           lastName == other.lastName &&
//           email == other.email &&
//           accountType == other.accountType &&
//           createdAt == other.createdAt &&
//           profileImage == other.profileImage &&
//           phoneNumber == other.phoneNumber &&
//           isNew == other.isNew &&
//           totalNumberOfBookings == other.totalNumberOfBookings &&
//           totalAmountSpent == other.totalAmountSpent &&
//           fcmToken == other.fcmToken &&
//           isAvailable == other.isAvailable &&
//           isOnline == other.isOnline &&
//           barberAvailability == other.barberAvailability &&
//           searchTags == other.searchTags);
//
//   @override
//   int get hashCode =>
//       uid.hashCode ^
//       firstName.hashCode ^
//       lastName.hashCode ^
//       email.hashCode ^
//       accountType.hashCode ^
//       createdAt.hashCode ^
//       profileImage.hashCode ^
//       phoneNumber.hashCode ^
//       isNew.hashCode ^
//       totalNumberOfBookings.hashCode ^
//       totalAmountSpent.hashCode ^
//       fcmToken.hashCode ^
//       isAvailable.hashCode ^
//       isOnline.hashCode ^
//       barberAvailability.hashCode ^
//       searchTags.hashCode;
//
//   @override
//   String toString() {
//     return 'UserModel{ uid: $uid, firstName: $firstName, lastName: $lastName, email: $email, accountType: $accountType, createdAt: $createdAt, profileImage: $profileImage, phoneNumber: $phoneNumber, isNew: $isNew, totalNumberOfBookings: $totalNumberOfBookings, totalAmountSpent: $totalAmountSpent, fcmToken: $fcmToken, isAvailable: $isAvailable, isOnline: $isOnline, barberAvailability: $barberAvailability, searchTags: $searchTags,}';
//   }
//
//   UserModel copyWith({
//     String? uid,
//     String? firstName,
//     String? lastName,
//     String? email,
//     AccountTypeEnum? accountType,
//     DateTime? createdAt,
//     String? profileImage,
//     String? phoneNumber,
//     bool? isNew,
//     int? totalNumberOfBookings,
//     double? totalAmountSpent,
//     String? fcmToken,
//     bool? isAvailable,
//     bool? isOnline,
//     List<DailyAvailabilityModel>? barberAvailability,
//     Map<String, dynamic>? searchTags,
//   }) {
//     return UserModel(
//       uid: uid ?? this.uid,
//       firstName: firstName ?? this.firstName,
//       lastName: lastName ?? this.lastName,
//       email: email ?? this.email,
//       accountType: accountType ?? this.accountType,
//       createdAt: createdAt ?? this.createdAt,
//       profileImage: profileImage ?? this.profileImage,
//       phoneNumber: phoneNumber ?? this.phoneNumber,
//       isNew: isNew ?? this.isNew,
//       totalNumberOfBookings:
//           totalNumberOfBookings ?? this.totalNumberOfBookings,
//       totalAmountSpent: totalAmountSpent ?? this.totalAmountSpent,
//       fcmToken: fcmToken ?? this.fcmToken,
//       isAvailable: isAvailable ?? this.isAvailable,
//       isOnline: isOnline ?? this.isOnline,
//       barberAvailability: barberAvailability ?? this.barberAvailability,
//       searchTags: searchTags ?? this.searchTags,
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'uid': uid,
//       'firstName': firstName,
//       'lastName': lastName,
//       'email': email,
//       'accountType': accountType.type,
//       'createdAt': createdAt.millisecondsSinceEpoch,
//       'profileImage': profileImage,
//       'phoneNumber': phoneNumber,
//       'isNew': isNew,
//       'totalNumberOfBookings': totalNumberOfBookings,
//       'totalAmountSpent': totalAmountSpent,
//       'fcmToken': fcmToken,
//       'isAvailable': isAvailable,
//       'isOnline': isOnline,
//       'barberAvailability': barberAvailability.map((e) => e.toMap()).toList(),
//       'searchTags': searchTags,
//     };
//   }
//
//   factory UserModel.fromMap(Map<String, dynamic> map) {
//     return UserModel(
//       uid: map['uid'] as String,
//       firstName: map['firstName'] as String,
//       lastName: map['lastName'] as String,
//       email: map['email'] as String,
//       accountType: (map['accountType'] as String).toAccountTypeEnum(),
//       createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
//       profileImage: map['profileImage'] as String,
//       phoneNumber: map['phoneNumber'] as String,
//       isNew: map['isNew'] as bool,
//       totalNumberOfBookings: map['totalNumberOfBookings'] as int,
//       totalAmountSpent: map['totalAmountSpent'] as double,
//       fcmToken: map['fcmToken'] as String,
//       isAvailable: map['isAvailable'] as bool,
//       isOnline: map['isOnline'] as bool,
//       barberAvailability:
//       (map['barberAvailability'] as List<dynamic>)
//           .map((e) => DailyAvailabilityModel.fromMap(e))
//           .toList(),
//       searchTags: map['searchTags'] as Map<String, dynamic>,
//     );
//   }
//
// //</editor-fold>
// }

// Map<String, dynamic> toMap() {
//   return {
//     'uid': uid,
//     'firstName': firstName,
//     'lastName': lastName,
//     'email': email,
//     'accountType': accountType.type,
//     'createdAt': createdAt.millisecondsSinceEpoch,
//     'profileImage': profileImage,
//     'phoneNumber': phoneNumber,
//     'isNew': isNew,
//     'totalNumberOfBookings': totalNumberOfBookings,
//     'totalAmountSpent': totalAmountSpent,
//     'fcmToken': fcmToken,
//     'barberAvailability': barberAvailability.map((e) => e.toMap()).toList(),
//     'searchTags': searchTags,
//   };
// }
//
// factory UserModel.fromMap(Map<String, dynamic> map) {
// return UserModel(
// uid: map['uid'] as String,
// firstName: map['firstName'] as String,
// lastName: map['lastName'] as String,
// email: map['email'] as String,
// accountType: (map['accountType'] as String).toAccountTypeEnum(),
// createdAt:  DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
// profileImage: map['profileImage'] as String,
// phoneNumber: map['phoneNumber'] as String,
// isNew: map['isNew'] as bool,
// totalNumberOfBookings: map['totalNumberOfBookings'] as int,
// totalAmountSpent: map['totalAmountSpent'] as double,
// fcmToken: map['fcmToken'] as String,
// barberAvailability:
// (map['barberAvailability'] as List<dynamic>)
//     .map((e) => DailyAvailabilityModel.fromMap(e))
//     .toList(),
// searchTags: map['searchTags'] as Map<String, dynamic>,
// );
// }
