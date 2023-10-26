import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mboacare/colors.dart';
import 'package:mboacare/facilities/provider/facilities_provider.dart';
import 'package:mboacare/facilities/view/screens/pick_address_page.dart';
import 'package:mboacare/facilities/view/widget/chip_text_field.dart';
import 'package:provider/provider.dart';

import '../widget/custom_textfield.dart';

class AddFacilitiesPage extends StatefulWidget {
  const AddFacilitiesPage({super.key});

  @override
  State<AddFacilitiesPage> createState() => _AddFacilitiesPageState();
}

class _AddFacilitiesPageState extends State<AddFacilitiesPage> {
  String selectedSize = 'Select hospital type';
  List<String> size = [
    'Public',
    'Private',
    'Other',
  ];
  String selectedType = 'Select hospital size';
  List<String> type = [
    'Small',
    'Medium',
    'Large',
  ];
  String selectedOwnership = 'Select hospital ownership';
  List<String> ownership = [
    'Individual',
    'Corporate',
    'Government',
  ];

  bool isSize = false;
  bool isType = false;
  bool isOwnership = false;
  int selectedIndex = 0;
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _selectedImage = File(pickedImage.path);
      }
    });
  }

  List<String> facilitiesTags = [];
  List<String> medicalTags = [];
  final formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneNoController = TextEditingController();
  final _emailController = TextEditingController();
  final _websiteController = TextEditingController();
  final _addressController = TextEditingController();
  TextEditingController medicalTagsController = TextEditingController();
  TextEditingController facilitiesTagsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final facilitiesProvider = Provider.of<FacilitiesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
            )),
        title: const Text(
          'Back',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.grey),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Hospital Information',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.buttonColor),
              ),
              const Divider(
                color: AppColors.buttonColor,
                thickness: 2.5,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Hospital name *',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                hintText: 'Central Park Hospital',
                controller: _nameController,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Hospital Email',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                hintText: 'support@centrapark.org',
                controller: _emailController,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Phone Number *',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                hintText: '+44 786789378',
                controller: _phoneNoController,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Hospital Website *',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                hintText: 'centralpark.org',
                controller: _websiteController,
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      (MaterialPageRoute(
                          builder: (context) => const PickAddressPage())));
                },
                child: const Text(
                  'Hospital Address *',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      (MaterialPageRoute(
                          builder: (context) => const PickAddressPage())));
                },
                child: CustomTextField(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(17.0),
                    child: SvgPicture.asset(
                      'lib/assests/icons/location.svg',
                    ),
                  ),
                  hintText: '5447, Park Lane, London, UK',
                  controller: _addressController,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Medical Services Offered'),
              const SizedBox(
                height: 10,
              ),
              medicalTags.isNotEmpty
                  ? GridView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(10),
                      itemCount: medicalTags.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisExtent: 45,
                      ),
                      itemBuilder: (context, index) => Chip(
                        backgroundColor: Colors.white,
                        label: Text(
                          medicalTags[index],
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 17),
                        ),
                        deleteIconColor: Colors.black,
                        padding: const EdgeInsets.all(0),
                        onDeleted: () {
                          setState(() {
                            medicalTags.remove(medicalTags[index]);
                          });
                        },
                      ),
                    )
                  : const SizedBox.shrink(),
              TextFormField(
                controller: medicalTagsController,
                cursorColor: Colors.teal,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: AppColors.grey300, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: AppColors.grey300, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: AppColors.grey300, width: 1.5),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  hintText: 'Add a medical service',
                ),
                onFieldSubmitted: (_) {
                  setState(() {
                    medicalTags.add(medicalTagsController.text);
                    // tags;
                    // print(tags);
                    // print('gg${widget.tag}');
                    medicalTagsController.text = '';
                  });
                },
              ),
              // ChipTextFieldScreen(
              //   hintText: 'Add a medical service',
              //   tag: medicalTags,
              // ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Facilities available',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  facilitiesTags.isNotEmpty
                      ? GridView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(10),
                          itemCount: facilitiesTags.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisExtent: 45,
                          ),
                          itemBuilder: (context, index) => Chip(
                            backgroundColor: Colors.white,
                            label: Text(
                              facilitiesTags[index],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17),
                            ),
                            deleteIconColor: Colors.black,
                            padding: const EdgeInsets.all(0),
                            onDeleted: () {
                              setState(() {
                                facilitiesTags.remove(facilitiesTags[index]);
                              });
                            },
                          ),
                        )
                      : const SizedBox.shrink(),
                  TextFormField(
                    controller: facilitiesTagsController,
                    cursorColor: Colors.teal,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: AppColors.grey300, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: AppColors.grey300, width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: AppColors.grey300, width: 1.5),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      hintText: 'Add a facility',
                    ),
                    onFieldSubmitted: (_) {
                      setState(() {
                        facilitiesTags.add(facilitiesTagsController.text);
                        //  widget.tag = tags;
                        print(facilitiesTags);
                        // print('gg${widget.tag}');
                        facilitiesTagsController.text = '';
                      });
                    },
                  ),
                ],
              ),
              // ChipTextFieldScreen(
              //   hintText: 'Add a facility',
              //   tag: facilitiesTags,
              // ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Hospital Type',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  isType = !isType;
                  setState(() {});
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      border: Border.all(color: AppColors.grey300, width: 1.5),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedSize,
                            style: const TextStyle(
                                color: AppColors.grey200,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.grey,
                          )
                        ]),
                  ),
                ),
              ),
              if (isType)
                Card(
                  elevation: 0.2,
                  child: SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Select Hospital Type',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                        ),
                        const Divider(
                          color: AppColors.grey,
                        ),
                        ListView.builder(
                          primary: true,
                          shrinkWrap: true,
                          itemCount: size.length,
                          itemBuilder: (context, index) {
                            return Container(
                              color: selectedIndex == index
                                  ? AppColors.grey100
                                  : Colors.transparent,
                              child: InkWell(
                                  onTap: () {
                                    selectedSize = size[index];
                                    selectedIndex = index;
                                    isType = false;
                                    setState(() {});
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        selectedIndex == index
                                            ? SvgPicture.asset(
                                                'lib/assests/icons/check.svg')
                                            : SvgPicture.asset(
                                                'lib/assests/icons/uncheck.svg'),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          size[index],
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  )),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Hospital Size',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  isSize = !isSize;
                  setState(() {});
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      border: Border.all(color: AppColors.grey300, width: 1.5),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedType,
                            style: const TextStyle(
                                color: AppColors.grey200,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.grey,
                          )
                        ]),
                  ),
                ),
              ),
              if (isSize)
                Card(
                  elevation: 0.2,
                  child: SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Select hospital Size',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                        ),
                        const Divider(
                          color: AppColors.grey,
                        ),
                        ListView.builder(
                          primary: true,
                          shrinkWrap: true,
                          itemCount: type.length,
                          itemBuilder: (context, index) {
                            return Container(
                              color: selectedIndex == index
                                  ? AppColors.grey100
                                  : Colors.transparent,
                              child: InkWell(
                                  onTap: () {
                                    isSize = false;
                                    selectedType = type[index];
                                    selectedIndex = index;
                                    setState(() {});
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        selectedIndex == index
                                            ? SvgPicture.asset(
                                                'lib/assests/icons/check.svg')
                                            : SvgPicture.asset(
                                                'lib/assests/icons/uncheck.svg'),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          type[index],
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  )),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Hospital Ownership',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  isOwnership = !isOwnership;
                  setState(() {});
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      border: Border.all(color: AppColors.grey300, width: 1.5),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedOwnership,
                            style: const TextStyle(
                                color: AppColors.grey200,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.grey,
                          )
                        ]),
                  ),
                ),
              ),
              if (isOwnership)
                Card(
                  elevation: 0.2,
                  child: SizedBox(
                    height: 230,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Select hospital ownership',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                        ),
                        const Divider(
                          color: AppColors.grey,
                        ),
                        ListView.builder(
                          primary: true,
                          shrinkWrap: true,
                          itemCount: ownership.length,
                          itemBuilder: (context, index) {
                            return Container(
                              color: selectedIndex == index
                                  ? AppColors.grey100
                                  : Colors.transparent,
                              child: InkWell(
                                  onTap: () {
                                    isOwnership = false;
                                    selectedOwnership = ownership[index];
                                    selectedIndex = index;
                                    setState(() {});
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        selectedIndex == index
                                            ? SvgPicture.asset(
                                                'lib/assests/icons/check.svg')
                                            : SvgPicture.asset(
                                                'lib/assests/icons/uncheck.svg'),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          ownership[index],
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  )),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColors.grey300, width: 1.5)),
                child: _selectedImage != null
                    ? Image.file(
                        _selectedImage!,
                        fit: BoxFit.cover,
                        height: 150,
                      )
                    : InkWell(
                        onTap: () {
                          _pickImage();
                        },
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            SvgPicture.asset('lib/assests/icons/upload.svg'),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Click to upload your hospital image',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'SVG, PNG, JPG or GIF (max. 800x400px)',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.grey),
                            )
                          ],
                        ),
                      ),
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AddFacilitiesPage()));
                    facilitiesProvider.addFacilities(
                        
                        name: _nameController.text,
                        email: _emailController.text,
                        website: _websiteController.text,
                        phoneno: _phoneNoController.text,
                        latitude: 'n',
                        longitude: 'k',
                        serviceType: medicalTags,
                        facilitiesType: facilitiesTags,
                        hospitalType: selectedType,
                        hospitalOwner: selectedOwnership,
                        hospitalSize: selectedSize,
                        hospitalImage: _selectedImage!);

                    log('''
${_emailController.text} 
${_nameController.text} ${_websiteController.text} ${_phoneNoController.text} 
${medicalTags} 
${facilitiesTags} 
${selectedOwnership} 
${selectedSize} 
${_selectedImage} 
${selectedType}
''');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColor,
                    foregroundColor: AppColors.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    minimumSize: const Size(150, 45),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
