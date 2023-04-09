// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:no_name_ecommerce/services/dropdowns_services/country_dropdown_service.dart';
import 'package:no_name_ecommerce/services/dropdowns_services/state_dropdown_services.dart';
import 'package:no_name_ecommerce/services/profile_service.dart';
import 'package:no_name_ecommerce/view/utils/api_url.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileEditService with ChangeNotifier {
  XFile? imageFile;

  bool isloading = false;

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  final ImagePicker _picker = ImagePicker();
  Future pickImage() async {
    imageFile = await _picker.pickImage(source: ImageSource.gallery);
    notifyListeners();
    if (imageFile != null) {
      return imageFile;
    } else {
      return null;
    }
  }

  setDefault() {
    imageFile = null;
    notifyListeners();
  }

  String countryCode = 'BD';

  setCountryCode(code) {
    countryCode = code;
    notifyListeners();
  }

  updateProfile(context,
      {required name,
      required email,
      required phone,
      required zip,
      required address,
      required city}) async {
    setLoadingTrue();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var countryName =
        Provider.of<CountryDropdownService>(context, listen: false)
            .selectedCountry;

    var stateName =
        Provider.of<StateDropdownService>(context, listen: false).selectedState;

    var dio = Dio();
    // dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Content-Type'] = 'multipart/form-data';
    dio.options.headers["Authorization"] = "Bearer $token";

    FormData formData;

    formData = FormData.fromMap({
      'name': name,
      'email': email,
      'phone': phone,
      'file': imageFile != null
          ? await MultipartFile.fromFile(imageFile!.path,
              filename: 'profileImage$name$zip${imageFile!.path}.jpg')
          : null,
      'country': countryName,
      'state': stateName,
      'address': address,
      'city': city,
      'zip_code': zip,
      'user_type': 'api'
    });

    var response = await dio.post(
      ApiUrl.updateProfileUri,
      data: formData,
    );

    if (response.statusCode == 200) {
      setLoadingFalse();
      showToast('Profile updated successfully', Colors.black);
      print(response.data);

      //re fetch profile data again
      await Provider.of<ProfileService>(context, listen: false)
          .getProfileDetails(isFromProfileupdatePage: true);

      // Future.delayed(const Duration(microseconds: 1600), () {
      Navigator.pop(context);
      // });

      return true;
    } else {
      setLoadingFalse();
      print('error updating profile' + response.data);
      showToast('Something went wrong', Colors.black);
      return false;
    }
  }

  // Future submitSubscription(name, email, phone, cityId, areaId, countryId,
  //     postCode, address, about, context, File file, String filename) async {
  //   setLoadingTrue();

  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var token = prefs.getString('token');

  //   ///MultiPart request
  //   var request = http.MultipartRequest(
  //     'POST',
  //     Uri.parse(
  //         "https://nazmul.xgenious.com/qixer_with_api/api/v1/user/update-profile"),
  //   );
  //   Map<String, String> headers = {
  //     "Accept": "application/json",
  //     "Authorization": "Bearer $token",
  //     // "Content-type": "multipart/form-data"
  //   };
  //   request.files.add(
  //     http.MultipartFile(
  //       'file',
  //       file.readAsBytes().asStream(),
  //       file.lengthSync(),
  //       filename: filename,
  //       // contentType: MediaType('image','jpeg'),
  //     ),
  //   );
  //   request.headers.addAll(headers);
  //   request.fields.addAll({
  //     'name': 'ccc',
  //     'email': 'c@c',
  //     'phone': '554',
  //     'service_city': '2',
  //     'service_area': '2',
  //     'country_id': '2',
  //     'post_code': '222',
  //     'address': 'asdfa',
  //     'about': 'asdsfd'
  //   });
  //   print("request: " + request.toString());
  //   var res = await request.send();
  //   print("This is response:" + res.toString());
  //   print(res.statusCode);
  //   setLoadingFalse();
  //   if (res.statusCode == 201) {
  //     Navigator.pop(context);
  //     Provider.of<ProfileService>(context, listen: false).getProfileDetails();
  //   } else {
  //     showToast(
  //         'Something went wrong. status code ${res.statusCode}', Colors.black);
  //   }
  //   return true;
  // }
}
