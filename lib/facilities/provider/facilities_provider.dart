import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mboacare/facilities/model/facilities_model.dart';

class FacilitiesProvider with ChangeNotifier {
  List<FacilitiesModel> _facilities = [];

  List<FacilitiesModel> get facilities => _facilities;
  final Dio _dio = Dio();

  Future<void> getFacilities() async {
    final response = await _dio.get(
        'https://us-central1-mboacare-api-v1.cloudfunctions.net/api/hospital/all-hospital');
    if (response.statusCode == 200) {
      // log(response.data);
      // print('hhh${_facilities.toString()}');
      // // _facilities =  FacilitiesModel.fromJson(response.data['favouriteStores']);
      // for (int i = 0; i < response.data.length; i++) {
      //   FacilitiesModel model = FacilitiesModel.fromJson(response.data[i]);
      //   _facilities.add(model);
      // }
      final List<dynamic> data = response.data;
      _facilities = data.map((json) => FacilitiesModel.fromJson(json)).toList();
      // final List<dynamic> data = json.decode(response.body);
      // _posts = data.map((json) => Post.fromJson(json)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> addFacilities({
    required String name,
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
  }) async {
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
        options: Options(headers: {
          // 'Authorization': 'Bearer ${''}',
        }, contentType: 'multipart/form-data'),
      );
      if (response.statusCode == 200) {
        log(response.data);
      } else {
        throw Exception('Failed to post data');
      }
    } catch (e) {
      throw Exception('Error: $e');
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

  Future<String> getPlaces(Uri uri, {Map<String, String>? headers}) async {
    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
             
        return response.body;
      } else {
        throw Exception('Failed to post data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
