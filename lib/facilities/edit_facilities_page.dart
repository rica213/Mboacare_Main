import 'package:flutter/material.dart';
import 'package:mboacare/colors.dart';

class EditFacilitiesPage extends StatefulWidget {
  const EditFacilitiesPage({super.key});

  @override
  State<EditFacilitiesPage> createState() => _EditFacilitiesPageState();
}

class _EditFacilitiesPageState extends State<EditFacilitiesPage> {
  String selectedValue = 'Item 1';
  List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: const Text(
          'Edit facility',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.grey),
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Hospital Information',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.buttonColor),
              ),
              Divider(
                color: AppColors.buttonColor,
                thickness: 3,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Hospital name *',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                hintText: 'Central Park Hospital',
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Hospital Email',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                hintText: 'support@centrapark.org',
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Phone Number *',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                hintText: '+44 786789378',
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Hospital Website *',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                hintText: 'centralpark.org',
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Hospital Address *',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                hintText: '5447, Park Lane, London, UK',
              ),
             
              SizedBox(
                height: 20,
              ),
              Text('Medical Services Offered'),
              SizedBox(
                height: 10,
              ),
              ChipTextFieldScreen(),
              SizedBox(
                height: 20,
              ),
              Text('Facilities available'),
              SizedBox(
                height: 10,
              ),
              ChipTextFieldScreen(),
              SizedBox(
                height: 20,
              ),
              //  DropdownButton(
              //    value: selectedValue,
              //    onChanged: (String? newValue) {
              //      setState(() {
              //        selectedValue = newValue!;
              //      });
              //    },
              //    items: items.map((String item) {
              //      return DropdownMenuItem(
              //        value: item,
              //        child: RadioListTile(
              //          title: Text(item),
              //          value: item,
              //          groupValue: selectedValue,
              //          onChanged: (value) {
              //            setState(() {
              //              selectedValue = value!;
              //            });
              //          },
              //        ),
              //      );
              //    }).toList(),
              //  ),
              SizedBox(height: 20),
              Text('Selected Value: $selectedValue'),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.grey200),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.grey, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.grey, width: 1),
        ),
        // errorBorder: const UnderlineInputBorder(
        //   borderSide: BorderSide(color: AppColors.red),
        // ),
      ),
    );
  }
}

class ChipTextFieldScreen extends StatefulWidget {
  const ChipTextFieldScreen({super.key});

  @override
  State<ChipTextFieldScreen> createState() => _ChipTextFieldScreenState();
}

class _ChipTextFieldScreenState extends State<ChipTextFieldScreen> {
  TextEditingController tagsController = TextEditingController();
  List<String> tags = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        tags.isNotEmpty
            ? GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(10),
                itemCount: tags.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisExtent: 45,
                ),
                itemBuilder: (context, index) => Chip(
                  backgroundColor: Colors.white,
                  label: Text(
                    tags[index],
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 17),
                  ),
                  deleteIconColor: Colors.black,
                  padding: const EdgeInsets.all(0),
                  onDeleted: () {
                    setState(() {
                      tags.remove(tags[index]);
                    });
                  },
                ),
              )
            : const SizedBox.shrink(),
        TextFormField(
          controller: tagsController,
          cursorColor: Colors.teal,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.grey, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.grey, width: 1),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            hintText: "Enter tag here",
          ),
          onFieldSubmitted: (_) {
            setState(() {
              tags.add(tagsController.text);
              // provider.placerModel.ad.tags = tags;
              tagsController.text = '';
            });
          },
        ),
      ],
    );
  }
}
