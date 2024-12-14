class SignatureModel {
  final String signatureId;
  final String image;

  SignatureModel({required this.signatureId, required this.image});

  // Convert SignatureModel to a map
  Map<String, dynamic> toMap() {
    return {
      'signatureId': signatureId,
      'image': image,
    };
  }

  // Create a SignatureModel from a map
  factory SignatureModel.fromMap(Map<String, dynamic> map) {
    return SignatureModel(
      signatureId: map['signatureId'],
      image: map['image'],
    );
  }

  // Create a copy of SignatureModel with optional new values
  SignatureModel copyWith({
    String? signatureId,
    String? image,
  }) {
    return SignatureModel(
      signatureId: signatureId ?? this.signatureId,
      image: image ?? this.image,
    );
  }

}
