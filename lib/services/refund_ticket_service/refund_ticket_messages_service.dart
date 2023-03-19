import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:no_name_ecommerce/model/ticket_messages_model.dart';
import 'package:no_name_ecommerce/services/common_service.dart';
import 'package:no_name_ecommerce/view/utils/api_url.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RefundTicketMessagesService with ChangeNotifier {
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

  final ImagePicker _picker = ImagePicker();
  Future pickImage() async {
    final XFile? imageFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      return imageFile;
    } else {
      return null;
    }
  }

  fetchMessages(ticketId) async {
    var connection = await checkConnection();
    if (connection) {
      messagesList = [];

      setLoadingTrue();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var header = {
        "Accept": "application/json",
        // "Content-Type": "application/json"
        "Authorization": "Bearer $token",
      };
      var response = await http.get(
          Uri.parse('${ApiUrl.refundTicketMessageUri}/$ticketId'),
          headers: header);
      setLoadingFalse();

      if (response.statusCode == 200 &&
          jsonDecode(response.body)['all_messages'].isNotEmpty) {
        var data = TicketMessagesModel.fromJson(jsonDecode(response.body));

        setMessageList(data.allMessages);

        notifyListeners();
      } else {
        //Something went wrong
        print(response.body);
      }
    } else {
      showToast('Please check your internet connection', Colors.black);
    }
  }

  setMessageList(dataList) {
    for (int i = 0; i < dataList.length; i++) {
      messagesList.add({
        'id': dataList[i].id,
        'message': dataList[i].message,
        'attachment': dataList[i].attachment,
        'type': dataList[i].type,
        'imagePicked':
            false //check if this image is just got picked from device in that case we will show it from device location
      });
    }
    notifyListeners();
  }

//Send new message ======>

  sendMessage({required ticketId, required message, required filePath}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var dio = Dio();
    dio.options.headers['Content-Type'] = 'multipart/form-data';
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] = "Bearer $token";
    FormData formData;

    formData = FormData.fromMap({
      'user_type': 'customer',
      'message': message,
      'send_notify_mail': 'on',
      'file': filePath != null
          ? await MultipartFile.fromFile(filePath, filename: 'ticket$filePath')
          : null
    });

    var connection = await checkConnection();
    if (connection) {
      setSendLoadingTrue();
      //if connection is ok

      var response = await dio.post(
        '${ApiUrl.refundTicketMessageSendUri}/$ticketId',
        data: formData,
      );
      setSendLoadingFalse();

      if (response.statusCode == 200) {
        print(response.data);
        addNewMessage(message, filePath);
        return true;
      } else {
        showToast('Something went wrong', Colors.black);
        print(response.data);
        return false;
      }
    } else {
      showToast('Please check your internet connection', Colors.black);
      return false;
    }
  }

  addNewMessage(newMessage, filePath) {
    messagesList.add({
      'id': '',
      'message': newMessage,
      'attachment': filePath,
      'type': 'customer',
      'imagePicked':
          true //check if this image is just got picked from device in that case we will show it from device location
    });
    notifyListeners();
  }
}
