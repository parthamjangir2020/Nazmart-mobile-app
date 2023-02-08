import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/app_string_service.dart';
import 'package:no_name_ecommerce/services/dropdown_services/priority_and_department_dropdown_service.dart';
import 'package:no_name_ecommerce/services/dropdown_services/ticket_status_dropdown_service.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
import 'package:no_name_ecommerce/view/widgets/custom_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SupportTicketHelper {
  //
  changePriorityPopup(BuildContext context) {
    return Alert(
        context: context,
        style: AlertStyle(
            alertElevation: 0,
            overlayColor: Colors.black.withOpacity(.6),
            alertPadding: const EdgeInsets.all(25),
            isButtonVisible: false,
            alertBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            titleStyle: const TextStyle(),
            animationType: AnimationType.grow,
            animationDuration: const Duration(milliseconds: 500)),
        content: Container(
          margin: const EdgeInsets.only(top: 22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.01),
                  spreadRadius: -2,
                  blurRadius: 13,
                  offset: const Offset(0, 13)),
            ],
          ),
          child: Consumer<AppStringService>(
            builder: (context, asProvider, child) =>
                Consumer<PriorityAndDepartmentDropdownService>(
              builder: (context, pProvider, child) => Column(
                children: [
                  //Priority dropdown ======>
                  CustomDropDown(
                    items: pProvider.priorityDropdownList,
                    labelText: 'Priority',
                    value: pProvider.selectedPriority,
                    onChange: (v) {
                      pProvider.setPriorityValue(v);

                      // setting the id of selected value
                      pProvider.setSelectedPriorityId(
                          pProvider.priorityDropdownIndexList[
                              pProvider.priorityDropdownList.indexOf(v!)]);
                    },
                  ),

                  sizedboxCustom(25),
                  Row(
                    children: [
                      Expanded(
                          child: borderButtonPrimary(
                              asProvider.getString('Cancel'), () {
                        Navigator.pop(context);
                      })),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          child: buttonPrimary(
                        asProvider.getString('Save'),
                        () {},
                      )),
                    ],
                  )
                ],
              ),
            ),
          ),
        )).show();
  }

  //
  changeStatusPopup(BuildContext context) {
    return Alert(
        context: context,
        style: AlertStyle(
            alertElevation: 0,
            overlayColor: Colors.black.withOpacity(.6),
            alertPadding: const EdgeInsets.all(25),
            isButtonVisible: false,
            alertBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            titleStyle: const TextStyle(),
            animationType: AnimationType.grow,
            animationDuration: const Duration(milliseconds: 500)),
        content: Container(
          margin: const EdgeInsets.only(top: 22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.01),
                  spreadRadius: -2,
                  blurRadius: 13,
                  offset: const Offset(0, 13)),
            ],
          ),
          child: Consumer<AppStringService>(
            builder: (context, asProvider, child) =>
                Consumer<TicketStatusDropdownService>(
              builder: (context, pProvider, child) => Column(
                children: [
                  //status dropdown ======>
                  CustomDropDown(
                    items: pProvider.statusDropdownList,
                    labelText: 'Status',
                    value: pProvider.selectedstatus,
                    onChange: (v) {
                      pProvider.setstatusValue(v);

                      // setting the id of selected value
                      pProvider.setSelectedstatusId(
                          pProvider.statusDropdownIndexList[
                              pProvider.statusDropdownList.indexOf(v!)]);
                    },
                  ),

                  sizedboxCustom(25),
                  Row(
                    children: [
                      Expanded(
                          child: borderButtonPrimary(
                              asProvider.getString('Cancel'), () {
                        Navigator.pop(context);
                      })),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          child: buttonPrimary(
                        asProvider.getString('Save'),
                        () {},
                      )),
                    ],
                  )
                ],
              ),
            ),
          ),
        )).show();
  }
}
