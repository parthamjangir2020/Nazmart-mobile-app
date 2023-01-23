import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/create_ticket_service.dart';
import 'package:no_name_ecommerce/view/support_ticket/components/textarea_field.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
import 'package:no_name_ecommerce/view/utils/custom_input.dart';
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
                            labelCommon("Priority"),
                            Container(
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                border: Border.all(color: greyFive),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  // menuMaxHeight: 200,
                                  // isExpanded: true,
                                  value: provider.selectedPriority,
                                  icon: Icon(Icons.keyboard_arrow_down_rounded,
                                      color: greyFour),
                                  iconSize: 26,
                                  elevation: 17,
                                  style: TextStyle(color: greyFour),
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
                                            color: greyPrimary.withOpacity(.8)),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            )
                          ],
                        ),

                        sizedboxCustom(20),

                        //================>
                        labelCommon("Title"),
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
                        labelCommon("Subject"),
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
                            if (provider.isLoading == false &&
                                provider.hasError == false) {
                              provider.createTicket(
                                titleController.text,
                                subjectController.text,
                                provider.selectedPriorityId,
                                descController.text,
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
