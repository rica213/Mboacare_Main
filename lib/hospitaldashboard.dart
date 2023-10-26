import 'package:flutter/material.dart';
import 'package:mboacare/chip_widget.dart';
import 'package:mboacare/hospitaldetails.dart';
import 'package:provider/provider.dart';
import 'hospital_model.dart';
import 'hospital_provider.dart';
import 'colors.dart';
import 'dart:developer' as devtools show log;

class HospitalDashboard extends StatefulWidget {
  const HospitalDashboard({super.key});

  @override
  State<HospitalDashboard> createState() => _HospitalDashboardState();
}

class _HospitalDashboardState extends State<HospitalDashboard> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'View All'; // Initialize with 'View All'
  String _selectedDropdownFilter = 'View All'; // Initialize with 'View All'
  late List<HospitalData> filteredHospitals;
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Defined but not referenced
  // Uncomment to use the code below
  // Function to launch the website URL
  // Future<void> _launchURL(String url) async {
  //   devtools.log('Launching URL: $url');

  //   if (url.isNotEmpty &&
  //       (url.startsWith('http://') || url.startsWith('https://'))) {
  //     try {
  //       final Uri uri = Uri.parse(url);
  //       if (await url_launcher.canLaunchUrl(uri)) {
  //         await url_launcher.launchUrl(uri);
  //       } else {
  //         devtools.log('Could not launch $url');
  //       }
  //     } catch (e) {
  //       devtools.log('Error launching URL: $e');
  //     }
  //   } else {
  //     devtools.log('Invalid URL: $url');
  //   }
  // }

  Future<void> _refreshData() async {
    //final hospitalProvider = Provider.of<HospitalProvider>(context);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() {
      //hospitalProvider.getHospitalsStream();
    });
  }

  @override
  Widget build(BuildContext context) {
    final hospitalProvider = Provider.of<HospitalProvider>(context);

    return GestureDetector(
      onTap: () {
        // Unfocus the search field when tapping outside
        _searchFocusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Image.asset(
            'lib/assests/images/logo.png',
          ),
          backgroundColor: AppColors.navbarColor,
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 50, // Set the height of the search bar
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocusNode, // Add this line
                onTap: () {
                  _searchFocusNode.requestFocus(); // Add this line
                },
                onChanged: (query) {
                  devtools.log('Search query: $query');
                  hospitalProvider.filterHospitals(query);
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Search Hospitals',
                  // labelStyle: const TextStyle(color: AppColors.primaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: AppColors.navbarColor,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: AppColors.primaryColor,
                      width: 1.0,
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.primaryColor,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 12.0,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  // textAlign: TextAlign.center,
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Connecting Hospitals',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                          fontFamily:
                              'Inter', // Replace with the appropriate font family
                        ),
                      ),
                      TextSpan(text: '\n'), // Add a line break here
                      TextSpan(
                        text: 'Globally',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                          fontFamily:
                              'Inter', // Replace with the appropriate font family
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Effortlessly Access a Network of Hospitals Worldwide',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryTextColor,
                    fontFamily:
                        'Inter', // Replace with the appropriate font family
                  ),
                  // textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16.0),

                // Filter Tabs
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildFilterTab('View All'),
                      _buildFilterTab('Surgery'),
                      _buildFilterTab('Paediatrics'),
                      _buildFilterTab('Internal Medicine'),
                      _buildFilterTab('Obstetrics & Gynaecology'),
                      _buildFilterTab('Cardiology'),
                      _buildFilterTab('Oncology'),
                      _buildFilterTab('Neurology'),
                    ],
                  ),
                ),

                // const SizedBox(height: 16.0),

                // Dropdown Filter
                // DropdownButton<String>(
                //   isExpanded: true,
                //   icon: const Icon(Icons.keyboard_arrow_down),
                //   value: _selectedDropdownFilter,
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       _selectedDropdownFilter = newValue!;
                //       _selectedFilter =
                //           newValue; // Set the filter tab value based on dropdown selection
                //       hospitalProvider.setSelectedFilter(_selectedFilter);
                //       Future.delayed(const Duration(milliseconds: 500))
                //           .then((_) {
                //         hospitalProvider
                //             .updateFilteredHospitalsDropdown(filteredHospitals);
                //         //hospitalProvider.filterHospitals(_selectedFilter);
                //       });
                //     });
                //   },
                //   items: <String>[
                //     'View All',
                //     'Emergency Room',
                //     'Laboratory',
                //     'Radiology',
                //     'Pharmacy',
                //     'Intensive Care Unit',
                //     'Operating Room',
                //     'Blood Bank',
                //   ].map<DropdownMenuItem<String>>((String value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(
                //         value,
                //         style: const TextStyle(
                //           color: AppColors.primaryColor,
                //         ),
                //       ),
                //     );
                //   }).toList(),
                // ),
                const SizedBox(height: 16.0),
                // Second dropdown
                DropdownMenu(
                    inputDecorationTheme: const InputDecorationTheme(
                      filled: true,
                      fillColor: AppColors.navbarColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    width: 380.0,
                    enableFilter: true,
                    menuStyle: const MenuStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                          AppColors.navbarColor),
                    ),
                    label: const Text('Filter'),
                    leadingIcon: const Icon(Icons.filter_list_outlined),
                    trailingIcon:
                        const Icon(Icons.keyboard_arrow_down_outlined),
                    selectedTrailingIcon:
                        const Icon(Icons.keyboard_arrow_up_outlined),
                    dropdownMenuEntries: [
                      'View All',
                      'Emergency Room',
                      'Laboratory',
                      'Radiology',
                      'Pharmacy',
                      'Intensive Care Unit',
                      'Operating Room',
                      'Blood Bank',
                    ].map<DropdownMenuEntry>((String value) {
                      return DropdownMenuEntry<String>(
                        value: value,
                        label: value,
                      );
                    }).toList()),
                const SizedBox(height: 16.0),
                // Hospitals list
                Expanded(
                  child: StreamBuilder<List<HospitalData>>(
                    stream: hospitalProvider.getHospitalsStream(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        // Apply filtering based on selected filter tab and search query
                        filteredHospitals = hospitalProvider.applyFilters(
                          snapshot.data!,
                          _searchController.text,
                          _selectedFilter,
                        );

                        // Update the _filteredHospitals list with the latest data
                        //hospitalProvider.updateFilteredHospitals(filteredHospitals);

                        return ListView.builder(
                          itemCount: hospitalProvider.filteredHospitals.length,
                          itemBuilder: (context, index) {
                            // var hospital = hospitalProvider.hospitals[index];
                            // devtools.log(hospital.hospitalImageUrl);
                            return Card(
                              elevation: 5.0,
                              margin: const EdgeInsets.symmetric(
                                vertical: 16.0,
                                horizontal: 5.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                side: const BorderSide(
                                  width: 0.1,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              color: Colors.white,
                              shadowColor: AppColors.primaryColor,
                              surfaceTintColor: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // Hospital Image
                                  SizedBox(
                                    height: 250.0,
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: hospitalProvider
                                                      .filteredHospitals[index]
                                                      .hospitalImageUrl !=
                                                  ''
                                              ? Image(
                                                  image: NetworkImage(
                                                      hospitalProvider
                                                          .filteredHospitals[
                                                              index]
                                                          .hospitalImageUrl),
                                                  fit: BoxFit.cover,
                                                )
                                              : const Image(
                                                  image: AssetImage(
                                                      'lib/assests/images/placeholder_image.png'),
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                        Positioned(
                                          right: 2,
                                          top: 2,
                                          child: IconButton(
                                            style: ButtonStyle(
                                              // backgroundColor:
                                              //     MaterialStateProperty.all(
                                              //   Colors.white,
                                              // ),
                                              fixedSize:
                                                  MaterialStateProperty.all(
                                                const Size(2.0, 10.0),
                                              ),
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                              ),
                                              side: MaterialStateProperty.all(
                                                const BorderSide(
                                                  width: 2.0,
                                                  color: AppColors.primaryColor,
                                                ),
                                              ),
                                            ),
                                            onPressed: null,
                                            icon: const Icon(
                                              Icons.star_border_rounded,
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  // Hospital Image
                                  // Container(
                                  //   height:
                                  //       MediaQuery.sizeOf(context).height *
                                  //           .15,
                                  //   decoration: BoxDecoration(
                                  //     borderRadius: const BorderRadius.all(
                                  //       Radius.circular(16.0),
                                  //     ),
                                  //     image: hospitalProvider
                                  //                 .filteredHospitals[index]
                                  //                 .hospitalImageUrl !=
                                  //             ''
                                  //         ? DecorationImage(
                                  //             fit: BoxFit.cover,
                                  //             image: NetworkImage(
                                  //                 hospitalProvider
                                  //                     .filteredHospitals[
                                  //                         index]
                                  //                     .hospitalImageUrl),
                                  //           )
                                  //         : const DecorationImage(
                                  //             fit: BoxFit.cover,
                                  //             image: AssetImage(
                                  //                 'lib/assests/images/placeholder_image.png'),
                                  //           ),
                                  //   ),
                                  // ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),

                                  // Display Hospital Name with Right Arrow Button
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 14.0),
                                        child: Text(
                                          hospitalProvider
                                              .filteredHospitals[index]
                                              .hospitalName,
                                          // .toUpperCase(),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textColor2,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  HospitalDetailsPage(
                                                hospital: hospitalProvider
                                                    .filteredHospitals[index],
                                              ),
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          size: 20.0,
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                        ),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  AppColors.buttonColor),
                                          fixedSize: MaterialStateProperty.all(
                                            const Size(2.0, 10.0),
                                          ),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  // Display Hospital Address
                                  Padding(
                                    padding: const EdgeInsets.only(left: 14.0),
                                    child: Text(
                                      hospitalProvider.filteredHospitals[index]
                                          .hospitalAddress,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: AppColors.textColor2,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 8.0),
                                  // Display Hospital Specialities as Colorful Boxes
                                  hospitalProvider.filteredHospitals[index]
                                              .hospitalSpecialities ==
                                          ''
                                      ? const Padding(
                                          padding: EdgeInsets.only(
                                              left: 12.0, bottom: 8.0),
                                          child: Text(
                                            'This facility has no specialties',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.red,
                                              fontFamily: 'Inter',
                                            ),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, bottom: 8.0),
                                          child: Wrap(
                                            spacing: 5.0,
                                            runSpacing: 5.0,
                                            children: hospitalProvider
                                                .filteredHospitals[index]
                                                .hospitalSpecialities
                                                .split(',')
                                                .map(
                                                  (speciality) =>
                                                      ChipWidget(speciality),
                                                )
                                                .toList(),
                                          ),
                                        ),
                                  // ... Add any other hospital information here ...
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterTab(String filterOption) {
    final hospitalProvider = Provider.of<HospitalProvider>(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = filterOption;
          hospitalProvider.setSelectedFilter(filterOption);
          Future.delayed(const Duration(milliseconds: 500)).then((_) {
            hospitalProvider.updateFilteredHospitals(filteredHospitals);
          });
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          filterOption,
          style: TextStyle(
            fontSize: 16,
            color: _selectedFilter == filterOption
                ? AppColors.primaryColor
                : Colors.black26,
            fontWeight: _selectedFilter == filterOption
                ? FontWeight.w600
                : FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
