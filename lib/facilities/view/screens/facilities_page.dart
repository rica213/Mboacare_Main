import 'package:flutter/material.dart';
import 'package:mboacare/colors.dart';
import 'package:mboacare/facilities/model/facilities_model.dart';
import 'package:mboacare/facilities/provider/facilities_provider.dart';
import 'package:mboacare/facilities/view/screens/add_facilities_page.dart';
import 'package:mboacare/facilities/view/widget/facilities_widget.dart';
import 'package:provider/provider.dart';

class FacilitiesPage extends StatelessWidget {
  const FacilitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
     final facilitiesProvider = Provider.of<FacilitiesProvider>(context);
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.arrow_back),
          title: const Text(
            'Manage facilities',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.grey),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: facilities.length,
                  itemBuilder: (context, index) {
                    return FacilitiesWidget(
                      facilitiesModel: facilities[index],
                    );
                  }),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddFacilitiesPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonColor,
                  foregroundColor: AppColors.whiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(350, 50),
                ),
                child: const Text(
                  'ADD A FACILITY',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

