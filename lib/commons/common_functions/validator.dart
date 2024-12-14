var regEx = RegExp(
    r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
RegExp numReg = RegExp(r'.*[0-9].*');
RegExp phoneNumReg =
    RegExp(r'^(\+\d{1,2}\s?)?1?\-?\.?\s?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$');
RegExp letterReg = RegExp(r'.*[A-Za-z].*');

String? emailValidator(String? value) {
  if (!regEx.hasMatch(value!)) {
    return 'Enter a valid email address';
  }
  return null;
}

String? bankValidator(String? value) {
  if (value!.isEmpty) {
    return 'Enter all bank detail';
  }
  return null;
}

String? isValidInstagramHandle(String? handle) {
  RegExp regex = RegExp(r'^[a-zA-Z0-9._]{1,30}$');
  if (!regex.hasMatch(handle!)) {
    return 'Enter a valid email address';
  }
  return null;
}


String? uNameValidator(String? value) {
  if (value!.isEmpty) {
    return 'Enter your user name';
  }
  if (value.length > 30) {
    return 'Exceeded 30 characters';
  }
  return null;
}

String? countryValidator(String? value) {
  if (value!.isEmpty) {
    return 'Enter your country';
  }
  return null;
}

String? sectionValidator(String? value) {
  if (value!.isEmpty) {
    return 'Can\'t be empty';
  }
  return null;
}

String? cityValidator(String? value) {
  if (value!.isEmpty) {
    return 'Enter your City';
  }
  return null;
}

String? addressValidator(String? value) {
  if (value!.isEmpty) {
    return 'Enter a Valid Address';
  }
  return null;
}

String? passValidator(String? value) {
  if (value!.length < 6) {
    return 'Can not have less than 6 characters';
  }
  return null;
}

String? phoneValidator(String? value) {
  // if (!phoneNumReg.hasMatch(value!)) {
  //   return 'Enter a valid phone number';
  // } else
    final RegExp phoneRegex =  RegExp(r'^(\+\d{1,3}-)?\d{1,3}-\d{3}-\d{4}$');

    if (!phoneRegex.hasMatch(value!)) {
      return 'Valid phone format +00-22-333-4444';
    }
  return null;
}

     /////////////////////////////////////////

String? taxNameValidator(String? value) {
  if (value!.isEmpty) {
    return 'Enter tax name';
  }
  return null;
}

String? percentageValidator(String? value) {
  if (value!.isEmpty) {
    return 'Enter amount';
  }
  return null;
}

String? shippingCostValidator(String? value) {
  if (value!.isEmpty) {
    return 'Enter Shipping cost';
  }
  return null;
}
String? quantityValidator(String? value) {
  if (value!.isEmpty) {
    return 'Enter quantity';
  }
  return null;
}

