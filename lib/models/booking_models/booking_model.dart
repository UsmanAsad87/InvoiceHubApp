import 'package:invoice_producer/models/booking_models/booked_service_model.dart';
import 'package:invoice_producer/models/booking_models/payement_model.dart';
import 'package:const_date_time/const_date_time.dart';
import '../../core/enums/paymentMode.dart';

class BookingModel {
  final String bookingId;
  final DateTime bookingCreatedDate;
  final String userName;
  final String userId;
  final String userImage;
  final String barberName;
  final String barberId;
  final String barberImage;
  final List<BookedServiceModel> bookedServices;
  final String couponId;
  final DateTime startTime;
  final DateTime endTime;
  final double subTotal;
  final double total;
  final double serviceCharges;
  final PaymentModel paymentModel;
  final String bookingDescription;
  final DateTime bookingDate;
  final bool isCancelled;

//<editor-fold desc="Data Methods">
  const BookingModel({
    this.isCancelled = false,
    this.bookingDate = const ConstDateTime(0),
    this.bookingId = '',
    this.bookingCreatedDate = const ConstDateTime(0),
    this.userName = '',
    this.userId = '',
    this.userImage = '',
    this.barberName = '',
    this.barberId = '',
    this.barberImage = '',
    this.bookedServices = const [],
    this.couponId = '',
    this.startTime = const ConstDateTime(0),
    this.endTime = const ConstDateTime(0),
    this.subTotal = 0.0,
    this.total = 0.0,
    this.serviceCharges = 0.0,
    this.paymentModel = const PaymentModel(id: '', paymentMode: PaymentModeEnum.FullPayment, depositAmount: 0.0),
    this.bookingDescription = '',
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BookingModel &&
          runtimeType == other.runtimeType &&
          bookingId == other.bookingId &&
          bookingCreatedDate == other.bookingCreatedDate &&
          userName == other.userName &&
          userId == other.userId &&
          userImage == other.userImage &&
          barberName == other.barberName &&
          barberId == other.barberId &&
          barberImage == other.barberImage &&
          bookedServices == other.bookedServices &&
          couponId == other.couponId &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          subTotal == other.subTotal &&
          total == other.total &&
          serviceCharges == other.serviceCharges &&
          paymentModel == other.paymentModel &&
          bookingDescription == other.bookingDescription &&
          bookingDate == other.bookingDate &&
          isCancelled == other.isCancelled);

  @override
  int get hashCode =>
      bookingId.hashCode ^
      bookingCreatedDate.hashCode ^
      userName.hashCode ^
      userId.hashCode ^
      userImage.hashCode ^
      barberName.hashCode ^
      barberId.hashCode ^
      barberImage.hashCode ^
      bookedServices.hashCode ^
      couponId.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      subTotal.hashCode ^
      total.hashCode ^
      serviceCharges.hashCode ^
      paymentModel.hashCode ^
      bookingDescription.hashCode ^
      bookingDate.hashCode ^
      isCancelled.hashCode;

  @override
  String toString() {
    return 'BookingModel{ bookingId: $bookingId, bookingCreatedDate: $bookingCreatedDate, userName: $userName, userId: $userId, userImage: $userImage, barberName: $barberName, barberId: $barberId, barberImage: $barberImage, bookedServices: $bookedServices, couponId: $couponId, startTime: $startTime, endTime: $endTime, subTotal: $subTotal, total: $total, serviceCharges: $serviceCharges, paymentModel: $paymentModel, bookingDescription: $bookingDescription, bookingDate: $bookingDate, isCancelled: $isCancelled,}';
  }

  BookingModel copyWith({
    String? bookingId,
    DateTime? bookingCreatedDate,
    String? userName,
    String? userId,
    String? userImage,
    String? barberName,
    String? barberId,
    String? barberImage,
    List<BookedServiceModel>? bookedServices,
    String? couponId,
    DateTime? startTime,
    DateTime? endTime,
    double? subTotal,
    double? total,
    double? serviceCharges,
    PaymentModel? paymentModel,
    String? bookingDescription,
    DateTime? bookingDate,
    bool? isCancelled,
  }) {
    return BookingModel(
      bookingId: bookingId ?? this.bookingId,
      bookingCreatedDate: bookingCreatedDate ?? this.bookingCreatedDate,
      userName: userName ?? this.userName,
      userId: userId ?? this.userId,
      userImage: userImage ?? this.userImage,
      barberName: barberName ?? this.barberName,
      barberId: barberId ?? this.barberId,
      barberImage: barberImage ?? this.barberImage,
      bookedServices: bookedServices ?? this.bookedServices,
      couponId: couponId ?? this.couponId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      subTotal: subTotal ?? this.subTotal,
      total: total ?? this.total,
      serviceCharges: serviceCharges ?? this.serviceCharges,
      paymentModel: paymentModel ?? this.paymentModel,
      bookingDescription: bookingDescription ?? this.bookingDescription,
      bookingDate: bookingDate ?? this.bookingDate,
      isCancelled: isCancelled ?? this.isCancelled,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bookingId': bookingId,
      'bookingCreatedDate': bookingCreatedDate.millisecondsSinceEpoch,
      'userName': userName,
      'userId': userId,
      'userImage': userImage,
      'barberName': barberName,
      'barberId': barberId,
      'barberImage': barberImage,
      'bookedServices': bookedServices.map((e) => e.toMap()).toList(),
      'couponId': couponId,
      'startTime': startTime.millisecondsSinceEpoch,
      'endTime': endTime.millisecondsSinceEpoch,
      'subTotal': subTotal,
      'total': total,
      'serviceCharges': serviceCharges,
      'paymentModel': paymentModel.toMap(),
      'bookingDescription': bookingDescription,
      'bookingDate': bookingDate.millisecondsSinceEpoch,
      'isCancelled': isCancelled,
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      bookingId: map['bookingId'] as String,
      bookingCreatedDate:
          DateTime.fromMillisecondsSinceEpoch(map['bookingCreatedDate']),
      userName: map['userName'] as String,
      userId: map['userId'] as String,
      userImage: map['userImage'] as String,
      barberName: map['barberName'] as String,
      barberId: map['barberId'] as String,
      barberImage: map['barberImage'] as String,
      bookedServices: (map['bookedServices'] as List<dynamic>)
          .map((e) => BookedServiceModel.fromMap(e))
          .toList(),
      couponId: map['couponId'] as String,
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime']),
      endTime: DateTime.fromMillisecondsSinceEpoch(map['endTime']),
      bookingDate: DateTime.fromMillisecondsSinceEpoch(map['bookingDate']),
      subTotal: map['subTotal'] as double,
      total: map['total'] as double,
      serviceCharges: map['serviceCharges'] as double,
      paymentModel:
          PaymentModel.fromMap(map['paymentModel'] as Map<String, dynamic>),
      bookingDescription: map['bookingDescription'] as String,
      isCancelled: map['isCancelled'] as bool,
    );
  }

//</editor-fold>
}
/*


Map<String, dynamic> toMap() {
  return {
    'bookingId': bookingId,
    'bookingCreatedDate': bookingCreatedDate.millisecondsSinceEpoch,
    'userName': userName,
    'userId': userId,
    'userImage': userImage,
    'barberName': barberName,
    'barberId': barberId,
    'barberImage': barberImage,
    'bookedServices': bookedServices.map((e) => e.toMap()).toList(),
    'couponId': couponId,
    'startTime': startTime.millisecondsSinceEpoch,
    'endTime': endTime.millisecondsSinceEpoch,
    'subTotal': subTotal,
    'total': total,
    'serviceCharges': serviceCharges,
    'paymentModel': paymentModel.toMap(),
    'bookingDescription': bookingDescription,
    'bookingDate': bookingDate.millisecondsSinceEpoch,
     'isCancelled': this.isCancelled,
  };
}

factory BookingModel.fromMap(Map<String, dynamic> map) {
return BookingModel(
bookingId: map['bookingId'] as String,
bookingCreatedDate:
DateTime.fromMillisecondsSinceEpoch(map['bookingCreatedDate']),
userName: map['userName'] as String,
userId: map['userId'] as String,
userImage: map['userImage'] as String,
barberName: map['barberName'] as String,
barberId: map['barberId'] as String,
barberImage: map['barberImage'] as String,
bookedServices: (map['bookedServices'] as List<dynamic>)
    .map((e) => BookedServiceModel.fromMap(e))
    .toList(),
couponId: map['couponId'] as String,
startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime']),
endTime: DateTime.fromMillisecondsSinceEpoch(map['endTime']),
bookingDate: DateTime.fromMillisecondsSinceEpoch(map['bookingDate']),
subTotal: map['subTotal'] as double,
total: map['total'] as double,
serviceCharges: map['serviceCharges'] as double,
paymentModel:
PaymentModel.fromMap(map['paymentModel'] as Map<String, dynamic>),
bookingDescription: map['bookingDescription'] as String,
 isCancelled: map['isCancelled'] as bool,
);
}



const BookingModel({
    this.bookingDate = const ConstDateTime(0),
    this.bookingId = '',
    this.bookingCreatedDate = const ConstDateTime(0),
    this.userName = '',
    this.userId = '',
    this.userImage = '',
    this.barberName = '',
    this.barberId = '',
    this.barberImage = '',
    this.bookedServices = const [],
    this.couponId = '',
    this.startTime = const ConstDateTime(0),
    this.endTime = const ConstDateTime(0),
    this.subTotal = 0.0,
    this.total = 0.0,
    this.serviceCharges = 0.0,
    this.paymentModel = const PaymentModel(id: '', paymentMode: ''),
    this.bookingDescription = '',
  });
 */
