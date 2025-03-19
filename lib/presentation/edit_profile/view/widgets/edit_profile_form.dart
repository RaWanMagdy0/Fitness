import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routes/page_route_name.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/utils/widget/custom_button.dart';
import '../../../../core/utils/widget/custom_text_form_field.dart';
import 'custom_profile_field.dart';

class EditProfileForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final String weight;
  final String goal;
  final String activityLevel;
  final Function() onSaveCurrentValues;
  final Function() onLoadUserPreferences;
  final Function() onSubmit;

  const EditProfileForm({
    super.key,
    required this.formKey,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.weight,
    required this.goal,
    required this.activityLevel,
    required this.onSaveCurrentValues,
    required this.onLoadUserPreferences,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: firstNameController,
            hintText: "First Name",
            prefixIcon: const Icon(Icons.person_outline),
            backgroundColor: Colors.white.withOpacity(0.1),
          ),
          SizedBox(height: 16.h),
          CustomTextFormField(
            controller: lastNameController,
            hintText: "Last Name",
            prefixIcon: const Icon(Icons.person_outline),
            backgroundColor: Colors.white.withOpacity(0.1),
          ),
          SizedBox(height: 16.h),
          CustomTextFormField(
            controller: emailController,
            hintText: "Email",
            prefixIcon: const Icon(Icons.email_outlined),
            backgroundColor: Colors.white.withOpacity(0.1),
          ),
          SizedBox(height: 50.h),
          CustomProfileField(
            title: 'Your Weight',
            value: weight,
            onTap: () async {
              await onSaveCurrentValues();

              Navigator.pushNamed(
                  context,
                  PageRouteName.weightScreen,
                  arguments: {'isFromEdit': true}
              ).then((_) async {
                await onLoadUserPreferences();
              });
            },
          ),
          SizedBox(height: 8.h),
          CustomProfileField(
            title: 'Your Goal',
            value: goal,
            onTap: () async {
              await onSaveCurrentValues();

              Navigator.pushNamed(
                  context,
                  PageRouteName.goalScreen,
                  arguments: {'isFromEdit': true}
              ).then((_) async {
                await onLoadUserPreferences();
              });
            },
          ),
          SizedBox(height: 8.h),
          CustomProfileField(
            title: 'Your activity level',
            value: activityLevel,
            onTap: () async {
              await onSaveCurrentValues();

              Navigator.pushNamed(
                  context,
                  PageRouteName.activityScreen,
                  arguments: {'isFromEdit': true}
              ).then((_) async {
                await onLoadUserPreferences();
              });
            },
          ),
          SizedBox(height: 32.h),
          CustomButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                onSubmit();
              }
            },
            text: "Save",
            textStyle: AppFonts.font16WhiteWeight500,
          ),
        ],
      ),
    );
  }
}