import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mboacare/colors.dart';
import 'package:mboacare/facilities/model/autocomplete_prediction.dart';
import 'package:mboacare/facilities/model/place_autocomplete.dart';
import 'package:mboacare/facilities/provider/facilities_provider.dart';
import 'package:mboacare/facilities/view/screens/search_facilties_page.dart';
import 'package:provider/provider.dart';

class PickAddressPage extends StatefulWidget {
  const PickAddressPage({super.key});

  @override
  State<PickAddressPage> createState() => _PickAddressPageState();
}

class _PickAddressPageState extends State<PickAddressPage> {
  List<AutocompletePrediction> placePrediction = [];
  void placeAutoComplete(String query) async {
    final placeProvider =
        Provider.of<FacilitiesProvider>(context, listen: false);
    Uri uri =
        Uri.https('maps.googleapis.com', 'maps/api/place/autocomplete/json', {
      'input': query,
      'key': 'AIzaSyBbi0oN09TuCD9-YAGL9SfP1KPv4BUZFbg',
      'location': '37.76999%2C-122.44696',
      'radius': '500',
      'types': 'establishment'
    });
    String response = await placeProvider.getPlaces(
      uri,
    );
    if (response != null) {
      PlaceAutocompleteResponse result =
          PlaceAutocompleteResponse.parseAutocompleteResult(response);
      if (result.predictions != null) {
        setState(() {
          placePrediction = result.predictions!;
        });
      }
    }
  }

  String _previousQuery = '';
  final placeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          'Hospital address',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.grey),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) {
                placeAutoComplete(value);
                placeController.text = value;
              },
              onTap: () {
                if (placeController.text.isEmpty) {
                  placeController.text =
                      _previousQuery; // Restore previous query on click
                }
              },
              controller: placeController,
              decoration: const InputDecoration(
                hintText: 'Search location.......',
                hintStyle: TextStyle(color: AppColors.grey300),
                contentPadding: EdgeInsets.only(left: 40),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey300),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey300),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey300),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                placeAutoComplete('Dubai');
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const SearchFacilitiesPage()));
              },
              child: Row(
                children: [
                  SvgPicture.asset('lib/assests/icons/location_search.svg'),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    'Choose current location',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey300),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: placePrediction.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(placePrediction[index].description ?? ''),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
