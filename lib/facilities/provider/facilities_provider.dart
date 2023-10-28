import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mboacare/facilities/model/facilities_model.dart';
import 'package:mboacare/facilities/model/geometry_model.dart';
import 'package:mboacare/facilities/model/place_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class FacilitiesProvider with ChangeNotifier {
  List<FacilitiesModel> _facilities = [];

  List<FacilitiesModel> get facilities => _facilities;
  List<PlaceModel> _place = [];

  List<PlaceModel> get place => _place;
  List<GeometryModel> _geometry = [];

  List<GeometryModel> get geometry => _geometry;
  final Dio _dio = Dio();

  Future<void> getFacilities() async {
    final response = await _dio.get(
        'https://us-central1-mboacare-api-v1.cloudfunctions.net/api/hospital/all-hospital');
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      _facilities = data.map((json) => FacilitiesModel.fromJson(json)).toList();

      notifyListeners();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> addFacilities(
      {required String name,
      required String email,
      required String website,
      required String phoneno,
      required String latitude,
      required String longitude,
      required List<String> serviceType,
      required List<String> facilitiesType,
      required String hospitalType,
      required String hospitalOwner,
      required String hospitalSize,
      required File hospitalImage,
      required String hospitalAddress}) async {
    final body = {
      'userEmail': '',
      'name': name,
      'phoneNumber': phoneno,
      'email': email,
      'website': website,
      'latitude': latitude,
      'serviceType': serviceType,
      'facilitiesType': facilitiesType,
      'hospitalType': hospitalType,
      'hospitalOwner': hospitalOwner,
      'hospitalSize': hospitalSize,
      'placeAddress': hospitalAddress,
      'hospitalImage': hospitalImage == null
          ? null
          : await MultipartFile.fromFile(
              hospitalImage.path,
              filename: hospitalImage.path.split('/').last,
              contentType: MediaType(
                'hospitalImage',
                hospitalImage.path.split('/').last.split('.').last,
              ),
            ),
    };
    try {
      final response = await _dio.post(
        'https://us-central1-mboacare-api-v1.cloudfunctions.net/api/hospital/add-hospital',
        data: FormData.fromMap(body),
        options: Options(headers: {}, contentType: 'multipart/form-data'),
      );
      if (response.statusCode == 200) {
        log(response.data);
      } else {
        print('Failed to post data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> editFacilities({
    required String userEmail,
    required String name,
    required String email,
    required String website,
    required String phoneno,
    required String latitude,
    required String longitude,
    required String serviceType,
    required String facilitiesType,
    required String hospitalType,
    required String hospitalOwner,
    required String hospitalSize,
    required File hospitalImage,
  }) async {
    final body = {
      'idToken': userEmail,
      'name': name,
      'phoneNumber': phoneno,
      'email': email,
      'website': website,
      'latitude': latitude,
      'serviceType': serviceType,
      'facilitiesType': facilitiesType,
      'hospitalType': hospitalType,
      'hospitalOwner': hospitalOwner,
      'hospitalSize': hospitalSize,
      'hospitalImage': hospitalImage == null
          ? null
          : await MultipartFile.fromFile(
              hospitalImage.path,
              filename: hospitalImage.path.split('/').last,
              contentType: MediaType(
                'hospitalImage',
                hospitalImage.path.split('/').last.split('.').last,
              ),
            ),
    };
    try {
      final response = await _dio.patch(
          'https://us-central1-mboacare-api-v1.cloudfunctions.net/api/hospital/update-hospital',
          data: FormData.fromMap(body),
          options: Options(headers: {
            'Authorization': 'Bearer ${''}',
          }, contentType: 'multipart/form-data'));
      if (response.statusCode == 200) {
        // Handle a successful response, if needed
      } else {
        throw Exception('Failed to post data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> deleteFacilities({required String website}) async {
    try {
      final response = await _dio.delete(
        'https://us-central1-mboacare-api-v1.cloudfunctions.net/api/hospital/delete-hospital/$website',
      );

      if (response.statusCode == 200) {
        print(response.data);
      } else {
        throw Exception('Failed to post data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  

  Future<void> getPlace({required String query}) async {
    final Uuid uuid = Uuid();
    final sessionToken = uuid.v4();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('sessiontoken', sessionToken);
    try {
      final response = await _dio.get(
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=AIzaSyBbi0oN09TuCD9-YAGL9SfP1KPv4BUZFbg&sessiontoken=$sessionToken');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['predictions'];
        _place = data.map((location) => PlaceModel.fromJson(location)).toList();
        print(_place);

        notifyListeners();
      } else {
        throw Exception('Failed to post data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> getGeometry({required String placeId}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final sessionToken = await prefs.getString(
      'sessiontoken',
    );
    try {
      final response = await _dio.get(
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?place_id=$placeId&key=AIzaSyBbi0oN09TuCD9-YAGL9SfP1KPv4BUZFbg&sessiontoken=$sessionToken');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['result'];
        _geometry =
            data.map((location) => GeometryModel.fromJson(location)).toList();
        print(_geometry);
        notifyListeners();
      } else {
        throw Exception('Failed to post data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
