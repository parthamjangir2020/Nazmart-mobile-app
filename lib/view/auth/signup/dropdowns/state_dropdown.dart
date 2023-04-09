import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/dropdowns_services/state_dropdown_services.dart';
import 'package:no_name_ecommerce/view/auth/signup/dropdowns/country_states_dropdowns.dart';
import 'package:no_name_ecommerce/view/auth/signup/dropdowns/state_dropdown_popup.dart';
import 'package:provider/provider.dart';

class StateDropdown extends StatelessWidget {
  const StateDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<StateDropdownService>(
      builder: (context, p, child) => InkWell(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return const StateDropdownPopup();
              });
        },
        child: dropdownPlaceholder(hintText: p.selectedState),
      ),
    );
  }
}
