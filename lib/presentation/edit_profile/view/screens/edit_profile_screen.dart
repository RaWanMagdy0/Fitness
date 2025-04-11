import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fitness_app/core/styles/images/app_images.dart';
import 'package:fitness_app/core/utils/functions/dialogs/app_dialogs.dart';
import 'package:fitness_app/presentation/edit_profile/view/widgets/custom_pic.dart';
import 'package:fitness_app/presentation/edit_profile/view/widgets/custom_profile_field.dart';
import 'package:fitness_app/presentation/edit_profile/view_model/edit_profile_cubit.dart';
import 'package:fitness_app/presentation/profile/view_model/profile_cubit.dart';
import 'package:fitness_app/presentation/profile/view_model/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/utils/widget/custom_button.dart';
import '../../../../core/utils/widget/custom_text_form_field.dart';
import '../../../../core/utils/widget/custom scaffold.dart';
import '../../../../core/utils/widget/shimmer_loading_widget.dart';
import '../../../../core/routes/page_route_name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  String _weight = '70 KG';
  String _goal = 'Gain Weight';
  String _activityLevel = 'Rookie';
  bool _dataLoaded = false;
  String _profileImageUrl = '';
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  late EditProfileCubit editProfileCubit;

  @override
  void initState() {
    super.initState();
    editProfileCubit = context.read<EditProfileCubit>();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final profileCubit = context.read<ProfileCubit>();
    final state = profileCubit.state;

    if (state is GetUserDataSuccessState && state.user != null) {
      _updateUIWithUserData(state.user);
    } else {
      await profileCubit.getUserData();

      if (mounted) {
        final newState = profileCubit.state;
        if (newState is GetUserDataSuccessState && newState.user != null) {
          _updateUIWithUserData(newState.user);
        } else {
          setState(() {
            _dataLoaded = true;
          });
        }
      }
    }

    await _loadUserPreferences();
  }

  void _updateUIWithUserData(user) {
    if (mounted) {
      _firstNameController.text = user?.firstName ?? '';
      _lastNameController.text = user?.lastName ?? '';
      _emailController.text = user?.email ?? '';
      _profileImageUrl = user?.photo ?? '';

      setState(() {
        _weight = '${user?.weight ?? 70} KG';
        _goal = _mapGoalToDisplay(user?.goal);
        _activityLevel = _mapActivityToDisplay(user?.activityLevel);
        _dataLoaded = true;
      });
    }
  }

  String _mapGoalToDisplay(String? goal) {
    final goalMap = {
      'gain_weight': 'Gain Weight',
      'lose_weight': 'Lose Weight',
      'get_fitter': 'Get Fitter',
      'gain_flexible': 'Gain More Flexible',
      'learn_basic': 'Learn The Basics'
    };

    return goalMap[goal] ?? 'Gain Weight';
  }

  String _mapActivityToDisplay(String? activity) {
    final activityMap = {
      'level1': 'Rookie',
      'level2': 'Beginner',
      'level3': 'Intermediate',
      'level4': 'Advanced',
      'level5': 'Expert'
    };

    return activityMap[activity] ?? 'Rookie';
  }

  Future<void> _loadUserPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    if (mounted) {
      setState(() {
        if (prefs.getString('edit_profile_weight') != null) {
          _weight = prefs.getString('edit_profile_weight') ?? _weight;
        }
        if (prefs.getString('edit_profile_goal') != null) {
          _goal = prefs.getString('edit_profile_goal') ?? _goal;
        }
        if (prefs.getString('edit_profile_activity') != null) {
          _activityLevel =
              prefs.getString('edit_profile_activity') ?? _activityLevel;
        }
      });
    }
  }

  Future<void> _saveCurrentValues() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_weight', _weight.replaceAll(' KG', ''));
    await prefs.setString('current_goal', _goal);
    await prefs.setString('current_activity', _activityLevel);
  }

  void _submitEditProfile() async {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final email = _emailController.text.trim();

    final weightValue = int.tryParse(_weight.replaceAll('KG', '').trim());

    String? formattedGoal = _convertGoalToApiFormat(_goal);
    String? formattedActivity = _convertActivityToApiFormat(_activityLevel);

    context.read<EditProfileCubit>().editProfile(
          firstName: firstName.isNotEmpty ? firstName : null,
          lastName: lastName.isNotEmpty ? lastName : null,
          email: email.isNotEmpty ? email : null,
          weight: weightValue,
          goal: formattedGoal,
          activityLevel: formattedActivity,
        );
  }

  String? _convertGoalToApiFormat(String displayGoal) {
    final reverseGoalMap = {
      'Gain Weight': 'gain_weight',
      'Lose Weight': 'lose_weight',
      'Get Fitter': 'get_fitter',
      'Gain More Flexible': 'gain_flexible',
      'Learn The Basics': 'learn_basic'
    };

    return reverseGoalMap[displayGoal];
  }

  String? _convertActivityToApiFormat(String displayActivity) {
    final reverseActivityMap = {
      'Rookie': 'level1',
      'Beginner': 'level2',
      'Intermediate': 'level3',
      'Advanced': 'level4',
      'Expert': 'level5'
    };

    return reverseActivityMap[displayActivity];
  }

  Future<void> _clearSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('edit_profile_weight');
    await prefs.remove('edit_profile_goal');
    await prefs.remove('edit_profile_activity');
    await prefs.remove('current_weight');
    await prefs.remove('current_goal');
    await prefs.remove('current_activity');
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
              _clearSavedData();
              final profileCubit = context.read<ProfileCubit>();
              profileCubit.getUserData();
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
        return WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: CustomScaffold(
            backgroundImage: AppImages.authBackground,
            enableBlur: false,
            child: _dataLoaded
                ? SingleChildScrollView(
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
                                CustomProfilePic(
                                  userImage: _profileImageUrl,
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  "${_firstNameController.text} ${_lastNameController.text}",
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
                                  backgroundColor:
                                      Colors.white.withOpacity(0.1),
                                ),
                                SizedBox(height: 16.h),
                                CustomTextFormField(
                                  controller: _lastNameController,
                                  hintText: "Last Name",
                                  prefixIcon: Icon(Icons.person_outline),
                                  backgroundColor:
                                      Colors.white.withOpacity(0.1),
                                ),
                                SizedBox(height: 16.h),
                                CustomTextFormField(
                                  controller: _emailController,
                                  hintText: "Email",
                                  prefixIcon: Icon(Icons.email_outlined),
                                  backgroundColor:
                                      Colors.white.withOpacity(0.1),
                                ),
                                SizedBox(height: 50.h),
                                CustomProfileField(
                                  title: 'Your Weight',
                                  value: _weight,
                                  onTap: () async {
                                    await _saveCurrentValues();

                                    // Changed to use the dedicated EditProfileWeightScreen
                                    Navigator.pushNamed(
                                            context,
                                            PageRouteName
                                                .editProfileWeightScreen)
                                        .then((_) async {
                                      await _loadUserPreferences();
                                    });
                                  },
                                ),
                                SizedBox(height: 8.h),
                                CustomProfileField(
                                  title: 'Your Goal',
                                  value: _goal,
                                  onTap: () async {
                                    await _saveCurrentValues();

                                    // Changed to use the dedicated EditProfileGoalScreen
                                    Navigator.pushNamed(context,
                                            PageRouteName.editProfileGoalScreen)
                                        .then((_) async {
                                      await _loadUserPreferences();
                                    });
                                  },
                                ),
                                SizedBox(height: 8.h),
                                CustomProfileField(
                                  title: 'Your activity level',
                                  value: _activityLevel,
                                  onTap: () async {
                                    await _saveCurrentValues();

                                    // Changed to use the new EditProfileActivityScreen
                                    Navigator.pushNamed(
                                            context,
                                            PageRouteName
                                                .editProfileActivityScreen)
                                        .then((_) async {
                                      await _loadUserPreferences();
                                    });
                                  },
                                ),
                                SizedBox(height: 32.h),
                                CustomButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _submitEditProfile();
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
                  )
                : _buildShimmerLoading(),
          ),
        );
      },
    );
  }

  Widget _buildShimmerLoading() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(AppImages.back),
              SizedBox(width: 85.w),
              ShimmerLoadingWidget(
                width: 120.w,
                height: 30.h,
                borderRadius: 4.r,
              ),
            ],
          ),

          SizedBox(height: 30.h),
          Center(
            child: Column(
              children: [
                ShimmerLoadingWidget(
                  width: 100.w,
                  height: 100.h,
                  borderRadius: 50.r, // Circle shape
                ),
                SizedBox(height: 10.h),
                ShimmerLoadingWidget(
                  width: 150.w,
                  height: 24.h,
                  borderRadius: 4.r,
                ),
              ],
            ),
          ),

          SizedBox(height: 30.h),

          // Form fields shimmer
          Column(
            children: [
              // First Name field
              ShimmerLoadingWidget(
                width: double.infinity,
                height: 50.h,
                borderRadius: 25.r,
              ),
              SizedBox(height: 16.h),

              // Last Name field
              ShimmerLoadingWidget(
                width: double.infinity,
                height: 50.h,
                borderRadius: 25.r,
              ),
              SizedBox(height: 16.h),

              // Email field
              ShimmerLoadingWidget(
                width: double.infinity,
                height: 50.h,
                borderRadius: 25.r,
              ),
              SizedBox(height: 50.h),

              // Custom fields (Weight, Goal, Activity)
              _buildCustomFieldShimmer(),
              SizedBox(height: 8.h),
              _buildCustomFieldShimmer(),
              SizedBox(height: 8.h),
              _buildCustomFieldShimmer(),
              SizedBox(height: 32.h),

              // Save button
              ShimmerLoadingWidget(
                width: double.infinity,
                height: 45.h,
                borderRadius: 50.r,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCustomFieldShimmer() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ShimmerLoadingWidget(
            width: 120.w,
            height: 18.h,
            borderRadius: 4.r,
          ),
          ShimmerLoadingWidget(
            width: 80.w,
            height: 18.h,
            borderRadius: 4.r,
          ),
        ],
      ),
    );
  }

  Future<void> _pickAndUploadImage() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (pickedFile != null) {
        final fileExtension = pickedFile.path.split('.').last.toLowerCase();
        if (fileExtension != 'jpg' &&
            fileExtension != 'jpeg' &&
            fileExtension != 'png' &&
            fileExtension != 'webp') {
          AppDialogs.showErrorDialog(
            context: context,
            errorMassage: 'Only JPG, JPEG,webp, and PNG images are allowed.',
          );
          return;
        }
        final compressedImage = await _compressImage(File(pickedFile.path));
        setState(() {
          _selectedImage = compressedImage;
        });
        await editProfileCubit.uploadPhoto(compressedImage);
        if (mounted) {
          Navigator.pop(context);
        }
      }
    } catch (e) {
      if (mounted) {
        AppDialogs.showErrorDialog(
          context: context,
          errorMassage: e is DioException
              ? e.response?.data['error'] ?? 'Upload failed'
              : 'Image processing failed',
        );
      }
    }
  }

  Future<File> _compressImage(File image) async {
    final result = await FlutterImageCompress.compressAndGetFile(
      image.absolute.path,
      '${(await getTemporaryDirectory()).path}/compressed_image.jpg',
      quality: 85,
      minWidth: 1024,
      minHeight: 1024,
    );

    if (result == null) throw Exception('Image compression failed');
    return File(result.path);
  }
}
