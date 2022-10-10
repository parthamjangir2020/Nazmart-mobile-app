import 'dart:io';

import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/create_ticket_service.dart';
import 'package:no_name_ecommerce/view/support_ticket/components/textarea_field.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
import 'package:no_name_ecommerce/view/utils/custom_input.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:provider/provider.dart';

class CreateTicketPage extends StatefulWidget {
  const CreateTicketPage({Key? key}) : super(key: key);

  @override
  _CreateTicketPageState createState() => _CreateTicketPageState();
}

class _CreateTicketPageState extends State<CreateTicketPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Provider.of<CreateTicketService>(context, listen: false)
        .fetchDepartment(context);
  }

  TextEditingController descController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController subjectController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonHelper().appbarCommon('Create ticket', context, () {
          Navigator.pop(context);
        }),
        body: Listener(
          onPointerDown: (_) {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.focusedChild?.unfocus();
            }
          },
          child: SingleChildScrollView(
            child: Consumer<CreateTicketService>(
              builder: (context, provider, child) => Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenPadHorizontal, vertical: 20),
                  child: Column(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Priority dropdown ======>
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonHelper().labelCommon("Priority"),
                            Container(
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                border: Border.all(color: cc.greyFive),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  // menuMaxHeight: 200,
                                  // isExpanded: true,
                                  value: provider.selectedPriority,
                                  icon: Icon(Icons.keyboard_arrow_down_rounded,
                                      color: cc.greyFour),
                                  iconSize: 26,
                                  elevation: 17,
                                  style: TextStyle(color: cc.greyFour),
                                  onChanged: (newValue) {
                                    provider.setPriorityValue(newValue);

                                    //setting the id of selected value
                                    provider.setSelectedPriorityId(
                                        provider.priorityDropdownIndexList[
                                            provider.priorityDropdownList
                                                .indexOf(newValue!)]);
                                  },
                                  items: provider.priorityDropdownList
                                      .map<DropdownMenuItem<String>>((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                            color:
                                                cc.greyPrimary.withOpacity(.8)),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            )
                          ],
                        ),

                        //Department dropdown =======>
                        provider.hasError == false
                            ? provider.departmentDropdownList.isNotEmpty
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      sizedboxCustom(22),
                                      CommonHelper().labelCommon("Department"),
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: cc.greyFive),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            // menuMaxHeight: 200,
                                            // isExpanded: true,
                                            value: provider.selectedDepartment
                                                .toString(),
                                            icon: Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                color: cc.greyFour),
                                            iconSize: 26,
                                            elevation: 17,
                                            style:
                                                TextStyle(color: cc.greyFour),
                                            onChanged: (newValue) {
                                              provider
                                                  .setDepartmentValue(newValue);

                                              //setting the id of selected value
                                              provider.setSelectedDepartmentId(
                                                  provider.departmentDropdownIndexList[
                                                      provider
                                                          .departmentDropdownList
                                                          .indexOf(newValue!)]);
                                            },
                                            items: provider
                                                .departmentDropdownList
                                                .map<DropdownMenuItem<String>>(
                                                    (value) {
                                              return DropdownMenuItem(
                                                value: value.toString(),
                                                child: Text(
                                                  value.toString(),
                                                  style: TextStyle(
                                                      color: cc.greyPrimary
                                                          .withOpacity(.8)),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OthersHelper()
                                            .showLoading(cc.primaryColor)
                                      ],
                                    ),
                                  )
                            : Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: Text(
                                  'Failed loading department list',
                                  style: TextStyle(color: cc.warningColor),
                                )),

                        sizedboxCustom(20),

                        //================>
                        CommonHelper().labelCommon("Title"),
                        CustomInput(
                          controller: titleController,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter ticket title';
                            }
                            return null;
                          },
                          hintText: "Ticket title",
                          // icon: 'assets/icons/user.png',
                          paddingHorizontal: 18,
                          textInputAction: TextInputAction.next,
                        ),

                        //================>
                        CommonHelper().labelCommon("Subject"),
                        CustomInput(
                          controller: subjectController,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter ticket subject';
                            }
                            return null;
                          },
                          hintText: "Subject",
                          // icon: 'assets/icons/user.png',
                          paddingHorizontal: 18,
                          textInputAction: TextInputAction.next,
                        ),

                        const SizedBox(
                          height: 7,
                        ),
                        CommonHelper().labelCommon("Description"),
                        TextareaField(
                          hintText: 'Describe your problem',
                          notesController: descController,
                        ),

                        //Save button =========>

                        const SizedBox(
                          height: 30,
                        ),
                        CommonHelper().buttonPrimary('Create ticket', () {
                          if (provider.departmentDropdownList.isEmpty) {
                            OthersHelper().showToast(
                                'Error fetching department. Please try again later',
                                Colors.black);
                          } else if (_formKey.currentState!.validate()) {
                            if (provider.isLoading == false &&
                                provider.hasError == false) {
                              provider.createTicket(
                                titleController.text,
                                subjectController.text,
                                provider.selectedPriorityId,
                                descController.text,
                                provider.selectedDepartmentId,
                                context,
                              );
                            }
                          }
                        },
                            isloading:
                                provider.isLoading == false ? false : true)
                      ],
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ));
  }
}
