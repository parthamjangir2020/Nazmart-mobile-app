import 'package:flutter/cupertino.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/custom_input.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Name ============>
        labelCommon("Full name"),

        CustomInput(
          controller: fullNameController,
          validation: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your full name';
            }
            return null;
          },
          hintText: "Enter your full name",
          icon: 'assets/icons/user.png',
          textInputAction: TextInputAction.next,
        ),

        //User name ============>
        labelCommon("Username"),

        CustomInput(
          controller: userNameController,
          validation: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your username';
            }
            return null;
          },
          hintText: "Enter your username",
          icon: 'assets/icons/user.png',
          textInputAction: TextInputAction.next,
        ),

        //Email ============>
        labelCommon("Email"),

        CustomInput(
          controller: emailController,
          validation: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            return null;
          },
          hintText: "Enter your email",
          icon: 'assets/icons/email-grey.png',
          textInputAction: TextInputAction.next,
        ),
      ],
    );
  }
}
