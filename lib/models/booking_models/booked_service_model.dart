import 'package:invoice_producer/models/service_models/service_model.dart';
//
// class BookedServiceModel{
//   final String id;
//   final ServiceModel serviceModel;
//   final DateTime startTime;
//   final DateTime endTime;
//   final int numberOfSlots;
//
// //<editor-fold desc="Data Methods">
//   const BookedServiceModel({
//     required this.id,
//     required this.serviceModel,
//     required this.startTime,
//     required this.endTime,
//     required this.numberOfSlots,
//   });
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       (other is BookedServiceModel &&
//           runtimeType == other.runtimeType &&
//           id == other.id &&
//           serviceModel == other.serviceModel &&
//           startTime == other.startTime &&
//           endTime == other.endTime &&
//           numberOfSlots == other.numberOfSlots);
//
//   @override
//   int get hashCode =>
//       id.hashCode ^
//       serviceModel.hashCode ^
//       startTime.hashCode ^
//       endTime.hashCode ^
//       numberOfSlots.hashCode;
//
//   @override
//   String toString() {
//     return 'BookedServiceModel{ id: $id, serviceModel: $serviceModel, startTime: $startTime, endTime: $endTime, numberOfSlots: $numberOfSlots,}';
//   }
//
//   BookedServiceModel copyWith({
//     String? id,
//     ServiceModel? serviceModel,
//     DateTime? startTime,
//     DateTime? endTime,
//     int? numberOfSlots,
//   }) {
//     return BookedServiceModel(
//       id: id ?? this.id,
//       serviceModel: serviceModel ?? this.serviceModel,
//       startTime: startTime ?? this.startTime,
//       endTime: endTime ?? this.endTime,
//       numberOfSlots: numberOfSlots ?? this.numberOfSlots,
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'serviceModel': serviceModel.toMap(),
//       'startTime': startTime.millisecondsSinceEpoch,
//       'endTime': endTime.millisecondsSinceEpoch,
//       'numberOfSlots': numberOfSlots,
//     };
//   }
//
//   factory BookedServiceModel.fromMap(Map<String, dynamic> map) {
//     return BookedServiceModel(
//       id: map['id'] as String,
//       serviceModel: ServiceModel.fromMap(map['serviceModel'] as Map<String, dynamic>),
//       startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime']),
//       endTime: DateTime.fromMillisecondsSinceEpoch(map['endTime']),
//       numberOfSlots: map['numberOfSlots'] as int,
//     );
//   }
//
// //</editor-fold>
// }


class BookedServiceModel{
  final int quantity;
  final ServiceModel serviceModel;

//<editor-fold desc="Data Methods">
  const BookedServiceModel({
    required this.quantity,
    required this.serviceModel,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is BookedServiceModel &&
              runtimeType == other.runtimeType &&
              quantity == other.quantity &&
              serviceModel == other.serviceModel);

  @override
  int get hashCode => quantity.hashCode ^ serviceModel.hashCode;

  @override
  String toString() {
    return 'ServiceSelectModel{ quantity: $quantity, serviceModel: $serviceModel,}';
  }

  BookedServiceModel copyWith({
    int? quantity,
    ServiceModel? serviceModel,
  }) {
    return BookedServiceModel(
      quantity: quantity ?? this.quantity,
      serviceModel: serviceModel ?? this.serviceModel,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'quantity': quantity,
      'serviceModel': serviceModel.toMap(),
    };
  }

  factory BookedServiceModel.fromMap(Map<String, dynamic> map) {
    return BookedServiceModel(
      quantity: map['quantity'] as int,
      serviceModel: ServiceModel.fromMap(map['serviceModel'] as Map<String, dynamic>),
    );
  }

//</editor-fold>
}