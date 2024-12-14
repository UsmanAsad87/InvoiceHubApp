enum SignUpMethodEnum {
  email('email'),
  linkedIn('linkedIn'),
  google('google'),
  apple('apple'),
  instagram('instagram');

  const SignUpMethodEnum(this.method);
  final String method;
}

// Using an extension for conversion
extension ConvertSignUpMethod on String {
  SignUpMethodEnum toSignUpMethodEnum() {
    switch (this) {
      case 'linkedIn':
        return SignUpMethodEnum.linkedIn;
      case 'email':
        return SignUpMethodEnum.email;
      case 'google':
        return SignUpMethodEnum.google;
      case 'apple':
        return SignUpMethodEnum.apple;
      case 'instagram':
        return SignUpMethodEnum.instagram;
      default:
        return SignUpMethodEnum.email;
    }
  }
}