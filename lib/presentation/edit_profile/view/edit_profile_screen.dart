import 'package:fitness_app/presentation/edit_profile/view/widgets/custom_profile_field.dart' show CustomProfileField;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/utils/widget/custom_button.dart';
import '../../../../core/utils/widget/custom_text_form_field.dart';
import '../../../../core/utils/widget/custom scaffold.dart';
import '../../../core/styles/images/app_images.dart' show AppImages;

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _goalController = TextEditingController();
  final TextEditingController _activityLevelController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _weightController.dispose();
    _goalController.dispose();
    _activityLevelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundImage: "assets/images/auth_background.png",
      enableBlur: false,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(AppImages.back),
                  SizedBox(width: 85.w,),
                  Text(
                    "Edit Profile",
                    style: AppFonts.font24WhiteWeight600,
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Center(
                child: Column(
                  children: [
                    ClipOval(child: Image.asset(AppImages.person)),
                    Text(
                      "user name",
                      style: AppFonts.font20WhiteWeight800,
                    )
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: _firstNameController,
                      hintText: "First Name",
                      prefixIcon: Icon(Icons.person_outline),
                      backgroundColor: Colors.white.withOpacity(0.1),
                    ),
                    SizedBox(height: 16.h),
                    CustomTextFormField(
                      controller: _lastNameController,
                      hintText: "Last Name",
                      prefixIcon: Icon(Icons.person_outline),
                      backgroundColor: Colors.white.withOpacity(0.1),
                    ),
                    SizedBox(height: 16.h),
                    CustomTextFormField(
                      controller: _emailController,
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email_outlined),
                      backgroundColor: Colors.white.withOpacity(0.1),
                    ),
                    SizedBox(height: 50.h),
                    CustomProfileField(
                      title: 'Your Weight',
                      value: '90 KG',
                      onTap: () {
                        // Handle weight edit
                      },
                    ),
                    SizedBox(height: 8.h),
                    CustomProfileField(
                      title: 'Your Goal',
                      value: 'Gain Weight',
                      onTap: () {
                        // Handle weight edit
                      },
                    ),
                    SizedBox(height: 8.h),
                    CustomProfileField(
                      title: 'Your activity level',
                      value: 'Rookie',
                      onTap: () {
                        // Handle activity level edit
                      },
                    ),
                    SizedBox(height: 10.h),
                    CustomButton(
                      width: 60,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Handle save profile logic
                        }
                      },
                      text: "Save",
                      textStyle: AppFonts.font16WhiteWeight500,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}