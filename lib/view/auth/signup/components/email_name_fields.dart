import 'package:flutter/cupertino.dart';
import 'package:no_name_ecommerce/services/translate_string_service.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/const_strings.dart';
import 'package:no_name_ecommerce/view/utils/custom_input.dart';
import 'package:provider/provider.dart';

class EmailNameFields extends StatelessWidget {
  const EmailNameFields({
    Key? key,
    required this.fullNameController,
    required this.userNameController,
    required this.emailController,
  }) : super(key: key);

  final fullNameController;
  final userNameController;
  final emailController;

  @override
  Widget build(BuildContext context) {
    return Consumer<TranslateStringService>(
      builder: (context, ln, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Name ============>
          labelCommon(ConstString.fullName),

          CustomInput(
            controller: fullNameController,
            paddingHorizontal: 20,
            validation: (value) {
              if (value == null || value.isEmpty) {
                return ln.getString(ConstString.plzEnterFullName);
              }
              return null;
            },
            hintText: ln.getString(ConstString.enterFullName),
            textInputAction: TextInputAction.next,
          ),

          //User name ============>
          labelCommon(ConstString.userName),

          CustomInput(
            controller: userNameController,
            paddingHorizontal: 20,
            validation: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
            hintText: "Enter your username",
            textInputAction: TextInputAction.next,
          ),

          //Email ============>
          labelCommon("Email"),

          CustomInput(
            controller: emailController,
            paddingHorizontal: 20,
            validation: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
            hintText: "Enter your email",
            textInputAction: TextInputAction.next,
          ),
        ],
      ),
    );
  }
}
