import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/dropdown_services/country_dropdown_service.dart';
import 'package:no_name_ecommerce/view/auth/signup/dropdowns/country_dropdown_popup.dart';
import 'package:no_name_ecommerce/view/auth/signup/dropdowns/country_states_dropdowns.dart';
import 'package:provider/provider.dart';

class CountryDropdown extends StatelessWidget {
  const CountryDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CountryDropdownService>(
      builder: (context, p, child) => InkWell(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return const CountryDropdownPopup();
              });
        },
        child: dropdownPlaceholder(hintText: p.selectedCountry),
      ),
    );
  }
}
