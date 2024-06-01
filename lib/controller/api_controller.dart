import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiController {
  final apiHeader = 'https://llabdemo.orell.com/api/';
  final academicYearEndpoint = 'masters/anonymous/getAcademicYear/32';
  final classDetailsEndpoint = 'masters/anonymous/getAllClassList';
  final saveUserEndpoint = 'userService/anonymous/saveUser';
  List<dynamic> academicYearData = [], classDetailsData = [];
  Map<String, dynamic> selectedAcademicYearData = {},
      selectedClassDetailsData = {};

  // get academic year
  getAcademicYear() async {
    try {
      final response =
          await http.get(Uri.parse(apiHeader + academicYearEndpoint));
      if (response.statusCode == 200) {
        academicYearData = json.decode(response.body) as List<dynamic>;
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      return false;
    }
  }

  // get class Details
  getClassDetails(String academicYear) async {
    for (var element in academicYearData) {
      if (element['academicYear'] == academicYear) {
        selectedAcademicYearData = element;
      }
    }
    try {
      final response = await http.post(
        Uri.parse(apiHeader + classDetailsEndpoint),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "institutionId": 32,
          "academicYearId":
              selectedAcademicYearData['academicYearId'].toString(),
        }),
      );
      if (response.statusCode == 200) {
        classDetailsData = json.decode(response.body) as List<dynamic>;
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      return false;
    }
  }

  // save student details
  saveUser(
    String classId,
    String name,
    String username,
    String address,
    String emailId,
    String mobileNo,
    String whatsappNo,
    String image,
    String password,
  ) async {
    try {
      for (var element in classDetailsData) {
        if (element['courseTreeId'] == classId) {
          selectedClassDetailsData = element;
        }
      }
      final response = await http.post(
        Uri.parse(apiHeader + saveUserEndpoint),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "userId": "0",
          "institutionId": 32,
          "name": name,
          "userCode": "$username.orell1",
          "address": address,
          "emailId": emailId,
          "mobileCode": "",
          "whatsappCode": "",
          "mobileNo": mobileNo,
          "whatsappNo": whatsappNo,
          "image": image,
          "password": password,
          "userType": "STUDENT",
          "academicYearId":
              selectedAcademicYearData['academicYearId'].toString(),
          "createdBy": "",
          "modifiedBy": "",
          "userClassDetailsList": [
            {
              "userClassId": 0,
              "userId": "0",
              "classId": selectedClassDetailsData['courseTreeId'],
            }
          ],
          "areaofintrest": "Test Orell",
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      return false;
    }
  }
}
