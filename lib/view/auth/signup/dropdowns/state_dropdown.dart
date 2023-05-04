import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/dropdown_services/state_dropdown_services.dart';
import 'package:no_name_ecommerce/view/auth/signup/dropdowns/country_states_dropdowns.dart';
import 'package:no_name_ecommerce/view/auth/signup/dropdowns/state_dropdown_popup.dart';
import 'package:provider/provider.dart';

class StateDropdown extends StatelessWidget {
  const StateDropdown({Key? key, this.isFromDeliveryPage = false})
      : super(key: key);
  final bool isFromDeliveryPage;

  @override
  Widget build(BuildContext context) {
    return Consumer<StateDropdownService>(
      builder: (context, p, child) => InkWell(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return StateDropdownPopup(
                  isFromDeliveryPage: isFromDeliveryPage,
                );
              });
        },
        child: dropdownPlaceholder(hintText: p.selectedState),
      ),
    );
  }
}
