class SupportModel{
  final String id;
  final String userId;
  final String subject;
  final String message;
  final DateTime createdOn;


  SupportModel({
    required this.id,
    required this.userId,
    required this.subject,
    required this.message,
    required this.createdOn,
  });

  // Convert a SupportModel to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'subject': subject,
      'message': message,
      'createdOn': createdOn.toIso8601String(), // Converting DateTime to ISO String
    };
  }

  // Create a SupportModel from a Map
  factory SupportModel.fromMap(Map<String, dynamic> map) {
    return SupportModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      subject: map['subject'] ?? '',
      message: map['message'] ?? '',
      createdOn: DateTime.parse(map['createdOn']), // Converting String back to DateTime
    );
  }

  // Create a copy of SupportModel with some fields updated
  SupportModel copyWith({
    String? id,
    String? userId,
    String? subject,
    String? message,
    DateTime? createdOn,
  }) {
    return SupportModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      subject: subject ?? this.subject,
      message: message ?? this.message,
      createdOn: createdOn ?? this.createdOn,
    );
  }
}