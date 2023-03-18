import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/common_service.dart';
import 'package:no_name_ecommerce/services/dropdown_services/priority_and_department_dropdown_service.dart';
import 'package:no_name_ecommerce/services/ticket_services/create_ticket_service.dart';
import 'package:no_name_ecommerce/view/utils/textarea_field.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
import 'package:no_name_ecommerce/view/utils/custom_input.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:no_name_ecommerce/view/widgets/custom_dropdown.dart';
import 'package:provider/provider.dart';

class RefundCreateTicketPage extends StatefulWidget {
  const RefundCreateTicketPage({Key? key}) : super(key: key);

  @override
  _RefundCreateTicketPageState createState() => _RefundCreateTicketPageState();
}

class _RefundCreateTicketPageState extends State<RefundCreateTicketPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    Provider.of<PriorityAndDepartmentDropdownService>(context, listen: false)
        .fetchDepartment(context);
  }

  TextEditingController descController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController subjectController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appbarCommon('Create ticket', context, () {
          Navigator.pop(context);
        }),
        body: Listener(
          onPointerDown: (_) {
            hideKeyboard(context);
          },
          child: SingleChildScrollView(
            child: Consumer<PriorityAndDepartmentDropdownService>(
              builder: (context, pProvider, child) =>
                  Consumer<CreateTicketService>(
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
                          CustomDropDown(
                            items: pProvider.priorityDropdownList,
                            labelText: 'Priority',
                            value: pProvider.selectedPriority,
                            onChange: (v) {
                              pProvider.setPriorityValue(v);

                              // setting the id of selected value
                              pProvider.setSelectedPriorityId(pProvider
                                      .priorityDropdownIndexList[
                                  pProvider.priorityDropdownList.indexOf(v!)]);
                            },
                          ),

                          gapH(20),

                          //Department dropdown ======>
                          pProvider.departmentDropdownList.isNotEmpty
                              ? CustomDropDown(
                                  items: pProvider.departmentDropdownList,
                                  labelText: 'Department',
                                  value: pProvider.selectedDepartment,
                                  onChange: (v) {
                                    pProvider.setDepartmentValue(v);

                                    // setting the id of selected value
                                    pProvider.setSelectedDepartmentId(
                                        pProvider.departmentDropdownIndexList[
                                            pProvider.departmentDropdownList
                                                .indexOf(v!)]);
                                  },
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [showLoading(primaryColor)],
                                ),

                          gapH(20),

                          //================>
                          labelCommon("Title"),

                          CustomInput(
                            controller: titleController,
                            borderRadius: 8,
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
                          labelCommon("Subject"),
                          CustomInput(
                            controller: subjectController,
                            borderRadius: 8,
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

                          gapH(5),

                          labelCommon("Description"),
                          TextareaField(
                            hintText: 'Describe your problem',
                            notesController: descController,
                          ),

                          //Save button =========>

                          const SizedBox(
                            height: 30,
                          ),
                          buttonPrimary('Create ticket', () {
                            if (_formKey.currentState!.validate()) {
                              if (provider.isLoading == false) {
                                provider.createTicket(
                                  titleController.text,
                                  subjectController.text,
                                  descController.text,
                                  context,
                                );
                              }
                            }
                          }, isloading: provider.isLoading)
                        ],
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
