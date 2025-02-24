import 'package:fitness_app/presentation/edit_profile/view/widgets/custom_profile_field.dart' show CustomProfileField;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/utils/widget/custom_button.dart';
import '../../../../core/utils/widget/custom_text_form_field.dart';
import '../../../../core/utils/widget/custom scaffold.dart';
import '../../../core/styles/images/app_images.dart' show AppImages;
import 'package:fitness_app/presentation/edit_profile/view/widgets/custom_profile_field.dart';
import 'package:fitness_app/presentation/edit_profile/view_model/edit_profile_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/styles/images/app_images.dart';
import '../../../core/utils/functions/dialogs/app_dialogs.dart' show AppDialogs;

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

  String _weight = '90 KG';
  String _goal = 'Gain Weight';
  String _activityLevel = 'Rookie';

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileLoading) {
          AppDialogs.showLoading(context: context);
        } else if (state is EditProfileSuccess) {
          AppDialogs.showHideDialog(context);
          AppDialogs.showSuccessDialog(
            context: context,
            message: state.message,
            whenAnimationFinished: () {
              Navigator.pop(context);
            },
          );
        } else if (state is EditProfileError) {
          AppDialogs.showHideDialog(context);
          AppDialogs.showErrorDialog(
            context: context,
            errorMassage: state.errorMessage,
          );
        }
      },
      builder: (context, state) {
        return CustomScaffold(
          backgroundImage: AppImages.authBackground,
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
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Image.asset(AppImages.back),
                      ),
                      SizedBox(width: 85.w),
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
                          "User Name",
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
                          value: _weight,
                          onTap: () {
                            _showWeightDialog(context);
                          },
                        ),
                        SizedBox(height: 8.h),
                        CustomProfileField(
                          title: 'Your Goal',
                          value: _goal,
                          onTap: () {
                            _showGoalDialog(context);
                          },
                        ),
                        SizedBox(height: 8.h),
                        CustomProfileField(
                          title: 'Your activity level',
                          value: _activityLevel,
                          onTap: () {
                            _showActivityLevelDialog(context);
                          },
                        ),
                        SizedBox(height: 32.h),
                        CustomButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _submitEditProfile(context);
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
      },
    );
  }

  void _submitEditProfile(BuildContext context) {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final email = _emailController.text.trim();

    final weightValue = int.tryParse(_weight.replaceAll('KG', '').trim());

    context.read<EditProfileCubit>().editProfile(
      firstName: firstName.isNotEmpty ? firstName : null,
      lastName: lastName.isNotEmpty ? lastName : null,
      email: email.isNotEmpty ? email : null,
      weight: weightValue,
      goal: _goal != 'Gain Weight' ? _goal : null,
      activityLevel: _activityLevel != 'Rookie' ? _activityLevel : null,
    );
  }

  void _showWeightDialog(BuildContext context) {
    final controller = TextEditingController(text: _weight.replaceAll('KG', '').trim());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Weight', style: AppFonts.font18BlackWeight500),
        content: CustomTextFormField(
          controller: controller,
          hintText: "Weight in KG",
          keyBordType: TextInputType.number,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: AppFonts.font14GreyWeight500),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _weight = '${controller.text.trim()} KG';
              });
              Navigator.pop(context);
            },
            child: Text('Save', style: AppFonts.font14LightGreenWeight500),
          ),
        ],
      ),
    );
  }

  void _showGoalDialog(BuildContext context) {
    final goals = ['Gain Weight', 'Lose Weight', 'Maintain Weight', 'Build Muscle'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Goal', style: AppFonts.font18BlackWeight500),
        content: Container(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: goals.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(goals[index]),
                onTap: () {
                  setState(() {
                    _goal = goals[index];
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _showActivityLevelDialog(BuildContext context) {
    final activityLevels = ['Rookie', 'Beginner', 'Intermediate', 'Advanced', 'Expert'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Activity Level', style: AppFonts.font18BlackWeight500),
        content: Container(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: activityLevels.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(activityLevels[index]),
                onTap: () {
                  setState(() {
                    _activityLevel = activityLevels[index];
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}