
import 'package:fitness_app/presentation/edit_profile/view/widgets/edit_profile_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/styles/images/app_images.dart';
import '../../../core/styles/fonts/app_fonts.dart';
import '../../../core/utils/functions/dialogs/app_dialogs.dart';
import '../../../core/utils/widget/custom scaffold.dart';
import '../../profile/view_model/profile_cubit.dart';
import '../../profile/view_model/profile_state.dart';
import '../view_model/edit_profile_cubit.dart';
import 'widgets/edit_profile_form.dart';
import 'widgets/edit_profile_shimmer.dart';
import 'widgets/profile_image_widget.dart';

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

  @override
  void initState() {
    super.initState();
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
        _goal = EditProfileUtils.mapGoalToDisplay(user?.goal);
        _activityLevel = EditProfileUtils.mapActivityToDisplay(user?.activityLevel);
        _dataLoaded = true;
      });
    }
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
          _activityLevel = prefs.getString('edit_profile_activity') ?? _activityLevel;
        }
      });
    }
  }

  Future<void> _saveCurrentValues() async {
    await EditProfileUtils.saveCurrentValues(_weight, _goal, _activityLevel);
  }

  void _submitEditProfile() async {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final email = _emailController.text.trim();

    final weightValue = int.tryParse(_weight.replaceAll('KG', '').trim());

    String? formattedGoal = EditProfileUtils.convertGoalToApiFormat(_goal);
    String? formattedActivity = EditProfileUtils.convertActivityToApiFormat(_activityLevel);

    context.read<EditProfileCubit>().editProfile(
      firstName: firstName.isNotEmpty ? firstName : null,
      lastName: lastName.isNotEmpty ? lastName : null,
      email: email.isNotEmpty ? email : null,
      weight: weightValue,
      goal: formattedGoal,
      activityLevel: formattedActivity,
    );
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
              EditProfileUtils.clearSavedData();

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
                    ProfileImageWidget(
                      profileImageUrl: _profileImageUrl,
                      firstName: _firstNameController.text,
                      lastName: _lastNameController.text,
                    ),
                    SizedBox(height: 30.h),
                    EditProfileForm(
                      formKey: _formKey,
                      firstNameController: _firstNameController,
                      lastNameController: _lastNameController,
                      emailController: _emailController,
                      weight: _weight,
                      goal: _goal,
                      activityLevel: _activityLevel,
                      onSaveCurrentValues: _saveCurrentValues,
                      onLoadUserPreferences: _loadUserPreferences,
                      onSubmit: _submitEditProfile,
                    ),
                  ],
                ),
              ),
            )
                : const EditProfileShimmer(),
          ),
        );
      },
    );
  }
}