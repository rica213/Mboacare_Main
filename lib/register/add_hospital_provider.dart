import 'package:flutter/cupertino.dart';

class AddHospitalProvider extends ChangeNotifier{
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final websiteController = TextEditingController();
  final medicalController = TextEditingController();
  final facilityController = TextEditingController();
  final hospitalTypeController = TextEditingController();
  final hospitalSizeController = TextEditingController();
  final hospitalOwnerShipController = TextEditingController();
}