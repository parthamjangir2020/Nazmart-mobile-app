import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/common_service.dart';
import 'package:no_name_ecommerce/services/refund_ticket_service/create_refund_ticket_service.dart';
import 'package:no_name_ecommerce/view/utils/textarea_field.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
import 'package:no_name_ecommerce/view/utils/custom_input.dart';
import 'package:provider/provider.dart';

class CreateRefundTicketPage extends StatefulWidget {
  const CreateRefundTicketPage({Key? key}) : super(key: key);

  @override
  _CreateRefundTicketPageState createState() => _CreateRefundTicketPageState();
}

class _CreateRefundTicketPageState extends State<CreateRefundTicketPage> {
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
            hideKeyboard(context);
          },
          child: SingleChildScrollView(
            child: Consumer<CreateRefundTicketService>(
              builder: (context, provider, child) => Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenPadHorizontal, vertical: 20),
                  child: Column(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
        ));
  }
}
