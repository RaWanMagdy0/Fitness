import 'dart:io';

import 'package:fitness_app/presentation/edit_profile/view/widgets/custom_profile_field.dart' show CustomProfileField;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/utils/widget/custom_button.dart';
import '../../../../core/utils/widget/custom_text_form_field.dart';
import '../../../../core/utils/widget/custom scaffold.dart';
import '../../../core/styles/colors/app_colors.dart';
import '../../../core/styles/images/app_images.dart' show AppImages;
import 'package:fitness_app/presentation/edit_profile/view/widgets/custom_profile_field.dart';
import 'package:fitness_app/presentation/edit_profile/view_model/edit_profile_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/styles/images/app_images.dart';
import '../../../core/utils/functions/dialogs/app_dialogs.dart' show AppDialogs;
import 'package:fitness_app/presentation/profile/view_model/profile_cubit.dart';
import 'package:fitness_app/presentation/profile/view_model/profile_state.dart';
import '../../../../core/di/di.dart';
import '../../../../domain/entity/profile/user.dart';

import 'dart:io';

import 'package:fitness_app/presentation/edit_profile/view/widgets/custom_profile_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/di.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/styles/images/app_images.dart';
import '../../../../core/utils/functions/dialogs/app_dialogs.dart';
import '../../../../core/utils/widget/custom_button.dart';
import '../../../../core/utils/widget/custom_text_form_field.dart';
import '../../../../core/utils/widget/custom scaffold.dart';
import '../../../../domain/entity/profile/user.dart';
import '../view_model/edit_profile_cubit.dart';

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
  final ImagePicker _picker = ImagePicker();  // Add this
  File? _imageFile;  // Add this

  String _weight = '90 KG';
  String _goal = 'Gain Weight';
  String _activityLevel = 'level1';
  late ProfileCubit _profileCubit;
  User? _userData;

  @override
  void initState() {
    super.initState();
    _profileCubit = getIt<ProfileCubit>();
    _loadUserData();
  }

  void _loadUserData() {
    if (_profileCubit.state is GetUserDataSuccessState) {
      final userState = _profileCubit.state as GetUserDataSuccessState;
      _userData = userState.user;
      _populateFormFields();
    } else {
      _profileCubit.getUserData().then((_) {
        if (_profileCubit.state is GetUserDataSuccessState) {
          setState(() {
            final userState = _profileCubit.state as GetUserDataSuccessState;
            _userData = userState.user;
            _populateFormFields();
          });
        }
      });
    }
  }

  void _populateFormFields() {
    if (_userData != null) {
      _firstNameController.text = _userData!.firstName ?? '';
      _lastNameController.text = _userData!.lastName ?? '';
      _emailController.text = _userData!.email ?? '';
      setState(() {
        _weight = _userData!.weight != null ? '${_userData!.weight} KG' : '90 KG';
        _goal = _userData!.goal ?? 'Gain Weight';
        _activityLevel = _userData!.activityLevel ?? 'level1';
      });
    }
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_camera),
              title: Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 50, // Compress image to reduce size
      );

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });

        // Upload image immediately after picking
        await _uploadImage();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: $e')),
      );
    }
  }

  // Add this method
  Future<void> _uploadImage() async {
    if (_imageFile == null) return;

    AppDialogs.showLoading(context: context);

    try {
      await _profileCubit.uploadPhoto(_imageFile!);

      if (_profileCubit.state is UploadPhotoSuccessState) {
        AppDialogs.showHideDialog(context);
        AppDialogs.showSuccessDialog(
          context: context,
          message: "Profile picture updated successfully",
        );
      } else if (_profileCubit.state is UploadPhotoErrorState) {
        final errorState = _profileCubit.state as UploadPhotoErrorState;
        AppDialogs.showHideDialog(context);
        AppDialogs.showErrorDialog(
          context: context,
          errorMassage: errorState.errorMessage ?? "Failed to upload photo",
        );
      }
    } catch (e) {
      AppDialogs.showHideDialog(context);
      AppDialogs.showErrorDialog(
        context: context,
        errorMassage: "An error occurred: $e",
      );
    }
  }

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
              // Refresh user data after successful update
              _profileCubit.getUserData();
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
                  Stack(
                    children: [
                      // Profile Image
                      Container(
                        width: 100.w,
                        height: 100.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: _imageFile != null
                              ? Image.file(
                            _imageFile!,
                            width: 100.w,
                            height: 100.h,
                            fit: BoxFit.cover,
                          )
                              : (_userData?.photo != null && _userData!.photo!.isNotEmpty
                              ? Image.network(
                            _userData!.photo!,
                            width: 100.w,
                            height: 100.h,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Image.asset(
                                AppImages.person,
                                width: 100.w,
                                height: 100.h,
                                fit: BoxFit.cover),
                          )
                              : Image.asset(
                            AppImages.person,
                            width: 100.w,
                            height: 100.h,
                            fit: BoxFit.cover,
                          )),
                        ),
                      ),
                      // Edit button
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _showImagePickerOptions,
                          child: Container(
                            padding: EdgeInsets.all(8.r),
                            decoration: BoxDecoration(
                              color: AppColors.kOrange,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${_userData?.firstName ?? ''} ${_userData?.lastName ?? ''}",
                    style: AppFonts.font20WhiteWeight800,
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
                        CustomProfileField(
                          title: 'Your Goal',
                          value: _goal,
                          onTap: () {
                            _showGoalDialog(context);
                          },
                        ),
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
      activityLevel: _activityLevel,
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
    final activityLevels = ['level1', 'level2', 'level3', 'level4', 'level5'];

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