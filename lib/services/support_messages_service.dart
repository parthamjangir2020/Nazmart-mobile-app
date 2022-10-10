import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/model/ticket_messages_model.dart';
import 'package:no_name_ecommerce/services/common_service.dart';
import 'package:no_name_ecommerce/view/utils/config.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupportMessagesService with ChangeNotifier {
  List messagesList = [];

  bool isloading = false;
  bool sendLoading = false;

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  setSendLoadingTrue() {
    sendLoading = true;
    notifyListeners();
  }

  setSendLoadingFalse() {
    sendLoading = false;
    notifyListeners();
  }

  // final ImagePicker _picker = ImagePicker();
  Future pickFile() async {
    OthersHelper()
        .showToast('Only zip file is supported', ConstantColors().primaryColor);

    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['zip']);

    if (result != null) {
      return result;
    } else {
      return null;
    }
  }

  fetchMessages(ticketId) async {
    var connection = await checkConnection();
    if (connection) {
      messagesList = [];

      setLoadingTrue();

      //if connection is ok

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "Accept": "application/json",
        // "Content-Type": "application/json"
        "Authorization": "Bearer $token",
      };
      var response = await http.get(
          Uri.parse('$baseApi/user/ticket/chat/$ticketId'),
          headers: header);
      setLoadingFalse();

      if (response.statusCode == 201 && jsonDecode(response.body).isNotEmpty) {
        var data = parseOutWork(response.body);

        setMessageList(data);

        notifyListeners();
      } else {
        //Something went wrong
        print(response.body);
      }
    } else {
      OthersHelper()
          .showToast('Please check your internet connection', Colors.black);
    }
  }

  setMessageList(dataList) {
    for (int i = 0; i < dataList.length; i++) {
      messagesList.add({
        'id': dataList[i].id,
        'message': dataList[i].message,
        'attachment': dataList[i].attachment,
        'type': dataList[i].type,
        'filePicked':
            false //check if this image is just got picked from device in that case we will show it from device location
      });
    }
    notifyListeners();
  }

//Send new message ======>

  sendMessage(ticketId, message, filePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var dio = Dio();
    dio.options.headers['Content-Type'] = 'multipart/form-data';
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] = "Bearer $token";
    var formData;
    if (filePath != null) {
      formData = FormData.fromMap({
        'user_type': 'customer',
        'message': message,
        'send_notify_mail': 'on',
        'file':
            await MultipartFile.fromFile(filePath, filename: 'ticket$filePath')
      });
    } else {
      formData = FormData.fromMap({
        'user_type': 'customer',
        'message': message,
        'send_notify_mail': 'on'
      });
    }

    var connection = await checkConnection();
    if (connection) {
      setSendLoadingTrue();
      //if connection is ok

      var response = await dio.post(
        '$baseApi/user/ticket/chat/send/$ticketId',
        data: formData,
      );
      setSendLoadingFalse();

      if (response.statusCode == 201) {
        print(response.data);
        addNewMessage(message, filePath);
        return true;
      } else {
        OthersHelper().showToast('Something went wrong', Colors.black);
        print(response.data);
        return false;
      }
    } else {
      OthersHelper()
          .showToast('Please check your internet connection', Colors.black);
      return false;
    }
  }

  addNewMessage(newMessage, filePath) {
    messagesList.add({
      'id': '',
      'message': newMessage,
      'attachment': filePath,
      'type': 'customer',
      'filePicked':
          true //check if this image is just got picked from device in that case we will show it from device location
    });
    notifyListeners();
  }

  //===============>
  List<TicketMessagesModel> parseOutWork(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<TicketMessagesModel>((json) => TicketMessagesModel.fromJson(json))
        .toList();
  }
}
