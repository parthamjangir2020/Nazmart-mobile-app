import 'package:flutter/widgets.dart';

class PriorityAndDepartmentDropdownService with ChangeNotifier {
  //priority dropdown
  var priorityDropdownList = ['Low', 'High', 'Medium', 'Urgent'];
  var priorityDropdownIndexList = ['Low', 'High', 'Medium', 'Urgent'];
  var selectedPriority = 'Low';
  var selectedPriorityId = 'Low';

  setPriorityValue(value) {
    selectedPriority = value;
    notifyListeners();
  }

  setSelectedPriorityId(value) {
    selectedPriorityId = value;
    notifyListeners();
  }

  //department dropdown
  var departmentDropdownList = ['Web', 'Mobile'];
  var departmentDropdownIndexList = ['Web', 'Mobile'];
  var selectedDepartment = 'Web';
  var selectedDepartmentId = 'Web';

  setDepartmentValue(value) {
    selectedDepartment = value;
    notifyListeners();
  }

  setSelectedDepartmentId(value) {
    selectedDepartmentId = value;
    notifyListeners();
  }

  // fetchDepartment(BuildContext context) async {
  //   if (departmentDropdownList.isEmpty) {
  //     var response = await http.get(Uri.parse('$baseApi/country'));

  //     if (response.statusCode == 200 &&
  //         jsonDecode(response.body)['data'].isNotEmpty) {
  //       print(response.body);

  //       var data = CountryDropdownModel.fromJson(jsonDecode(response.body));

  //       for (int i = 0; i < data.countries.length; i++) {
  //         departmentDropdownList.add(data.countries[i].name);
  //         departmentDropdownIndexList.add(data.countries[i].id);
  //       }

  //       selectedDepartment = departmentDropdownList[0];
  //       selectedDepartmentId = departmentDropdownIndexList[0];

  //       notifyListeners();
  //     } else {
  //       //error fetching data
  //       departmentDropdownList.add('Select Department');
  //       departmentDropdownIndexList.add('0');
  //       selectedDepartment = 'Select Department';
  //       selectedDepartmentId = '0';
  //       notifyListeners();
  //     }
  //   } else {
  //     //already loaded from api
  //   }
  // }
}
