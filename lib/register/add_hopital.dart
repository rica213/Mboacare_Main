import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mboacare/utils/constants.dart';
import 'package:mboacare/widgets/custom_btn.dart';
import 'package:mboacare/widgets/extensions.dart';
import 'package:provider/provider.dart';
import '../colors.dart';
import '../dashboard.dart';

import '../widgets/input_fields.dart';
import 'add_hospital_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddHospitalProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.back,
          style: const TextStyle(color: AppColors.greyColor),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.greyColor),
          onPressed: () {
            // Navigate back to the dashboard page
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) => const DashboardScreen(
                        userName: '',
                      )),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: provider.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Hospital Name
                SizedBox(
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.information,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor),
                          ),
                          const Divider(
                            // Add a Divider widget below the text
                            color: AppColors.primaryColor,
                            // Set the color of the line
                            thickness: 2.0, // Set the thickness of the line
                          ),
                          // Add additional form fields or content here
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: AppFontSizes.fontSize4),
                      child: Text(
                        'Hospital Name *',
                        style: GoogleFonts.inter(
                          fontSize: AppFontSizes.fontSize14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )),
                SizedBox(height: AppFontSizes.fontSize6),
                EditTextForm(
                    hintText: "Enter name",
                    onChanged: (value) {
                      // setState(() {
                      //   provider.setName(value);
                      //   provider.validRegister();
                      // });
                    },
                    controller: provider.nameController),

                SizedBox(height: AppFontSizes.fontSize20),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: AppFontSizes.fontSize4),
                      child: Text(
                        'Hospital Email *',
                        style: GoogleFonts.inter(
                          fontSize: AppFontSizes.fontSize14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )),
                SizedBox(height: AppFontSizes.fontSize6),
                EditTextForm(
                    hintText: "Enter email",
                    onChanged: (value) {
                      // setState(() {
                      //   provider.setName(value);
                      //   provider.validRegister();
                      // });
                    },
                    prefixIcon: AppImages.emailIcon,
                    controller: provider.emailController),

                // Hospital Phone Number
                // Card(
                //   child: Padding(
                //     padding: const EdgeInsets.all(16.0),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         const Text(
                //           'Hospital Phone Number *',
                //           style: TextStyle(
                //             fontSize: 16,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //         TextFormField(
                //           decoration: const InputDecoration(
                //             hintText: 'Enter phone number',
                //             border: UnderlineInputBorder(
                //               borderSide: BorderSide(
                //                 color: Colors.black,
                //                 width: 1.0,
                //               ),
                //             ),
                //             isDense: true,
                //             contentPadding:
                //                 EdgeInsets.fromLTRB(0.0, 8.0, 12.0, 4.0),
                //           ),
                //           onSaved: (value) => _hospitalPhone = value,
                //           validator: (value) {
                //             if (value == null || value.isEmpty) {
                //               return 'Phone number is required';
                //             }
                //             return null;
                //           },
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                // Hospital Email Address
                // Card(
                //   child: Padding(
                //     padding: const EdgeInsets.all(16.0),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         const Text(
                //           'Hospital Email Address',
                //           style: TextStyle(
                //             fontSize: 16,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //         TextFormField(
                //           decoration: const InputDecoration(
                //             hintText: 'Enter email address (optional)',
                //             border: UnderlineInputBorder(
                //               borderSide: BorderSide(
                //                 color: Colors.black,
                //                 width: 1.0,
                //               ),
                //             ),
                //             isDense: true,
                //             contentPadding:
                //                 EdgeInsets.fromLTRB(0.0, 8.0, 12.0, 4.0),
                //           ),
                //           onSaved: (value) => _hospitalEmail = value,
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(height: AppFontSizes.fontSize20),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: AppFontSizes.fontSize4),
                      child: Text(
                        'Phone number *',
                        style: GoogleFonts.inter(
                          fontSize: AppFontSizes.fontSize14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )),
                SizedBox(height: AppFontSizes.fontSize6),
                PhoneNumberInput(
                  number: provider.number,
                  hintText: "Enter phone number",
                  controller: provider.phoneNumberController,
                  onInputChanged: (number) {
                    setState(() {});
                    debugPrint("onInputChanged: ${number.phoneNumber}");
                  },
                  validator: (value) {
                    setState(() {});
                    debugPrint("validator value: $value");
                    return "";
                  },
                  onInputValidated: (value) {
                    setState(() {});
                    debugPrint("onInputValidated value: $value");
                  },
                  onSubmit: () {
                    setState(() {});
                    debugPrint("onSubmit");
                  },
                  onSaved: (number) {
                    setState(() {});
                    debugPrint("onSaved: $number");
                  },
                ),
                SizedBox(height: AppFontSizes.fontSize20),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: AppFontSizes.fontSize4),
                      child: Text(
                        'Hospital Website *',
                        style: GoogleFonts.inter(
                          fontSize: AppFontSizes.fontSize14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )),
                SizedBox(height: AppFontSizes.fontSize6),
                EditTextForm(
                    hintText: "Enter website",
                    onChanged: (value) {
                      // setState(() {
                      //   provider.setName(value);
                      //   provider.validRegister();
                      // });
                    },
                    controller: provider.websiteController),

                // Specialities for the Hospitals
                // Card(
                //   child: Padding(
                //     padding: const EdgeInsets.all(16.0),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         const Text(
                //           'Specialities for the Hospitals',
                //           style: TextStyle(
                //             fontSize: 16,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //         TextFormField(
                //           decoration: const InputDecoration(
                //             hintText: 'Enter hospital specialities',
                //             border: UnderlineInputBorder(
                //               borderSide: BorderSide(
                //                 color: Colors.black,
                //                 width: 1.0,
                //               ),
                //             ),
                //             isDense: true,
                //             contentPadding:
                //                 EdgeInsets.fromLTRB(0.0, 8.0, 12.0, 4.0),
                //           ),
                //           onSaved: (value) => _hospitalSpecialities = value,
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                // Card(
                //   child: Padding(
                //     padding: const EdgeInsets.all(16),
                //     child: Column(
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //         const Align(
                //           alignment: Alignment.centerLeft,
                //           child: Text(
                //             'Medical Services Offered',
                //             style: TextStyle(
                //               fontSize: 16,
                //               fontWeight: FontWeight.bold,
                //             ),
                //           ),
                //         ),
                //         ListView.builder(
                //           physics: const ClampingScrollPhysics(),
                //           shrinkWrap: true,
                //           itemCount: checklistMedicalServices.length,
                //           itemBuilder: (context, index) {
                //             return CheckboxListTile(
                //               title:
                //                   Text(checklistMedicalServices[index].title),
                //               value: checklistMedicalServices[index].isChecked,
                //               onChanged: (value) {
                //                 setState(() {
                //                   checklistMedicalServices[index].isChecked =
                //                       value!;
                //                 });
                //               },
                //             );
                //           },
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(height: AppFontSizes.fontSize20),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: AppFontSizes.fontSize4),
                      child: Text(
                        'Hospital Address *',
                        style: GoogleFonts.inter(
                          fontSize: AppFontSizes.fontSize14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )),
                SizedBox(height: AppFontSizes.fontSize6),
                EditTextForm(
                  hintText: "Add address",
                  controller: provider.addressController,
                  onChanged: (value) {
                    // setState(() {
                    //   provider.setName(value);
                    //   provider.validRegister();
                    // });
                  },
                  prefixIcon: AppImages.markerPinIcon,
                ),

                SizedBox(height: AppFontSizes.fontSize20),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: AppFontSizes.fontSize4),
                      child: Text(
                        'Hospital Website *',
                        style: GoogleFonts.inter(
                          fontSize: AppFontSizes.fontSize14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )),
                SizedBox(height: AppFontSizes.fontSize6),
                EditTextForm(
                    hintText: "Enter website",
                    onChanged: (value) {
                      // setState(() {
                      //   provider.setName(value);
                      //   provider.validRegister();
                      // });
                    },
                    controller: provider.websiteController),

                SizedBox(height: AppFontSizes.fontSize20),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: AppFontSizes.fontSize4),
                      child: Text(
                        'Medical Services Offered *',
                        style: GoogleFonts.inter(
                          fontSize: AppFontSizes.fontSize14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )),
                SizedBox(height: AppFontSizes.fontSize6),
                EditTextForm(
                    hintText: "Add a medical service",
                    onChanged: (value) {
                      // setState(() {
                      //   provider.setName(value);
                      //   provider.validRegister();
                      // });
                    },
                    controller: provider.medicalController),

                SizedBox(height: AppFontSizes.fontSize20),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: AppFontSizes.fontSize4),
                      child: Text(
                        'Facilities Available *',
                        style: GoogleFonts.inter(
                          fontSize: AppFontSizes.fontSize14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )),
                SizedBox(height: AppFontSizes.fontSize6),
                EditTextForm(
                    hintText: "Add facility",
                    onChanged: (value) {
                      // setState(() {
                      //   provider.setName(value);
                      //   provider.validRegister();
                      // });
                    },
                    controller: provider.facilityController),

                SizedBox(height: AppFontSizes.fontSize20),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: AppFontSizes.fontSize4),
                      child: Text(
                        'Hospital Type *',
                        style: GoogleFonts.inter(
                          fontSize: AppFontSizes.fontSize14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )),
                SizedBox(height: AppFontSizes.fontSize6),
                EditTextForm(
                  hintText: "Select hospital type",
                  controller: provider.hospitalTypeController,
                  readonly: true,
                  onChanged: (value) {
                    // setState(() {
                    //   provider.setName(value);
                    //   provider.validRegister();
                    // });
                  },
                  suffixIcon: AppImages.arrowDown,
                ),

                SizedBox(height: AppFontSizes.fontSize20),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: AppFontSizes.fontSize4),
                      child: Text(
                        'Hospital Size *',
                        style: GoogleFonts.inter(
                          fontSize: AppFontSizes.fontSize14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )),
                SizedBox(height: AppFontSizes.fontSize6),
                EditTextForm(
                  hintText: "Select hospital size",
                  readonly: true,
                  suffixIcon: AppImages.arrowDown,
                  controller: provider.hospitalSizeController,
                  onChanged: (value) {
                    // setState(() {
                    //   provider.setName(value);
                    //   provider.validRegister();
                    // });
                  },
                ),

                SizedBox(height: AppFontSizes.fontSize20),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: AppFontSizes.fontSize4),
                      child: Text(
                        'Hospital Ownership *',
                        style: GoogleFonts.inter(
                          fontSize: AppFontSizes.fontSize14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )),
                SizedBox(height: AppFontSizes.fontSize6),
                EditTextForm(
                  hintText: "Select hospital ownership",
                  readonly: true,
                  suffixIcon: AppImages.arrowDown,
                  controller: provider.hospitalOwnerShipController,
                  onChanged: (value) {
                    // setState(() {
                    //   provider.setName(value);
                    //   provider.validRegister();
                    // });
                  },
                ),

                // Card(
                //   child: Padding(
                //     padding: const EdgeInsets.all(16),
                //     child: Column(
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //         const Align(
                //           alignment: Alignment.centerLeft,
                //           child: Text(
                //             'Emergency Services Available',
                //             style: TextStyle(
                //               fontSize: 16,
                //               fontWeight: FontWeight.bold,
                //             ),
                //           ),
                //         ),
                //         ListView.builder(
                //           physics: const ClampingScrollPhysics(),
                //           shrinkWrap: true,
                //           itemCount: checklistEmergencyService.length,
                //           itemBuilder: (context, index) {
                //             return CheckboxListTile(
                //               title:
                //                   Text(checklistEmergencyService[index].title),
                //               value: checklistEmergencyService[index].isChecked,
                //               onChanged: (value) {
                //                 setState(() {
                //                   checklistEmergencyService[index].isChecked =
                //                       value!;
                //                 });
                //               },
                //             );
                //           },
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                // const SizedBox(height: 20),
                // Radio buttons for  Hospital Bed Capacity
                // _buildChoiceChipForm(
                //   title: 'Bed Capacity *',
                //   name: 'hospitalBedCapacity',
                //   options: [
                //     'less than 50 Beds',
                //     '50-100 Beds',
                //     'more than 100 beds'
                //   ],
                //   onChanged: (value) => _hospitalBedCapacity = value,
                // ),

                // Radio buttons for Hospital Type
                // _buildChoiceChipForm(
                //   title: 'Hospital Type *',
                //   name: 'hospitalType',
                //   options: ['Public', 'Private', 'Other'],
                //   onChanged: (value) => _hospitalType = value,
                // ),

                // Radio buttons for Hospital Size
                // _buildChoiceChipForm(
                //   title: 'Hospital Size *',
                //   name: 'hospitalSize',
                //   options: ['Small', 'Medium', 'Large'],
                //   onChanged: (value) => _hospitalSize = value,
                // ),
                //
                // // Radio buttons for Hospital Ownership
                // _buildChoiceChipForm(
                //   title: 'Hospital Ownership',
                //   name: 'hospitalOwnership',
                //   options: ['Individual', 'Corporate', 'Government'],
                //   onChanged: (value) => _hospitalOwnership = value,
                // ),

                SizedBox(height: AppFontSizes.fontSize20),
                provider.selectedImage != null
                    ? _buildSelectedImageView(
                    selectedImage: provider.selectedImage,
                  onTap: provider.pickImage,
                )
                    : _buildImageUploadView(
                        onTap: provider.pickImage,
                      ),

                const SizedBox(height: 20),

                Center(
                  child: SizedBox(
                    width: context.getWidth() / 3,
                    child: AppButton(
                        onPressed: () {
                          provider.concatenateMedicalServices();
                          provider.concatenateFacilities();
                          provider.concatenateEmergencyService();
                          Future.delayed(const Duration(seconds: 1)).then((_) {
                            provider.submitForm();
                          });
                        },
                        title: 'Submit',
                        enabled: true),
                  ),
                ),

                // Center(
                //   child: ElevatedButton(
                //     onPressed: () {
                //       concatenateMedicalServices();
                //       concatenateFacilities();
                //       concatenateEmergencyService();
                //       Future.delayed(const Duration(seconds: 1)).then((_) {
                //         _submitForm();
                //       });
                //     },
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: AppColors.buttonColor,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(8),
                //       ),
                //     ),
                //     child: Text(
                //       'Submit',
                //       style: GoogleFonts.inter(
                //         fontSize: AppFontSizes.fontSize16,
                //         fontWeight: FontWeight.w600,
                //         color: AppColors.whiteColor,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChoiceChipForm({
    required String title,
    required String name,
    required List<String> options,
    void Function(String)? onChanged,
  }) {
    final provider = Provider.of<AddHospitalProvider>(context);
    String? selectedOption = _getSelectedOption(
        name,
        provider.hospitalType.toString(),
        provider.hospitalSize.toString(),
        provider.hospitalOwnership.toString(),
        provider.hospitalBedCapacity.toString(),
    );
    bool showOtherInput = selectedOption == 'Other';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            ...options.map(
              (option) => Row(
                children: [
                  Radio<String>(
                    value: option,
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value;
                        if (onChanged != null) {
                          onChanged(value!);
                        }
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  Text(option),
                  if (option == 'Other')
                    if (showOtherInput)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Enter other...',
                            ),
                            onChanged: (value) {
                              setState(() {
                                provider.setOtherValue(name, value);
                              });
                            },
                          ),
                        ),
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getPhoneNumber(String phoneNumber, PhoneNumber receivedNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');

    setState(() {
      receivedNumber = number;
    });
  }

  String? _getSelectedOption(
      String name,
      String hospitalType,
      String hospitalSize,
      String hospitalOwnership,
      String hospitalBedCapacity,
      ) {
    switch (name) {
      case 'hospitalType':
        return hospitalType;
      case 'hospitalSize':
        return hospitalSize;
      case 'hospitalOwnership':
        return hospitalOwnership;
      case 'hospitalBedCapacity':
        return hospitalBedCapacity;
      default:
        return null;
    }
  }


}

class ChecklistItem {
  String title;
  bool isChecked;

  ChecklistItem({required this.title, required this.isChecked});
}

Widget _buildImageUploadView({Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      height: 126,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFF949494)),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Image.asset(
              AppImages.uploadIcon,
              width: 30,
              height: 30,
            ),
          ),
          Text(
            AppStrings.uploadImage,
            style: GoogleFonts.inter(
              color: AppColors.greyColor,
              fontSize: AppFontSizes.fontSize14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            AppStrings.photoType,
            style: GoogleFonts.inter(
              color: AppColors.greyColor,
              fontSize: AppFontSizes.fontSize12,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    ),
  );
}

Widget _buildSelectedImageView({File? selectedImage, Function()? onTap}) {
  return Container(
      width: double.infinity,
      height: 126,
      decoration: ShapeDecoration(
        image: DecorationImage(
          image: FileImage(selectedImage!),
          fit: BoxFit.fill,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: onTap,
              child: Container(
                height: 32,
                margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: ShapeDecoration(
                  color: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Change photo',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: AppFontSizes.fontSize14,
                        fontWeight: FontWeight.w500,
                        height: 0.10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ));
}
