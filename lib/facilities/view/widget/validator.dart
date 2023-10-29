import 'package:flutter/material.dart';

final TextEditingController passwordController = TextEditingController();

mixin ValidationMixin {
  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Please enter email';
    }
    if (!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password!.isEmpty) {
      return 'Please enter password';
    }
    final hasDigits = password.contains(RegExp('[0-9]'));
    if (!hasDigits) {
      return 'Password must contain at least one number';
    }
    if (password.length < 8) {
      return 'Password cannot be less than 8 characters';
    }
    return null;
  }

  String? validateFirstName(String? firstname) {
    if (firstname!.isEmpty) {
      return 'First name cannot be empty';
    }
    if (firstname.length < 3) {
      return 'Please enter a valid first name';
    }
    return null;
  }

  String? validateField(String? username) {
    if (username!.isEmpty) {
      return 'field cannot be empty';
    }
    
    return null;
  }

  String? validateLastName(String? lastname) {
    if (lastname!.isEmpty) {
      return 'Last name cannot be empty';
    }
    
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value != passwordController.text) {
      return 'The password doesnt match';
    }
    return null;
  }

  String? validatePhoneNo(String? value) {
    return null;
  
    // try {
    //   final phone = PhoneNumber.parse(value!, callerCountry: IsoCode.NG);
    //   if (phone.isValid(type: PhoneNumberType.mobile)) {
    //     return null;
    //   } else {
    //     return 'Enter a valid phone number';
    //   }
    // } catch (e) {
    //   return 'Enter a valid phone number';
    // }
  }
}
