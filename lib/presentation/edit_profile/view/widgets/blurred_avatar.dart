import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/styles/images/app_images.dart';
import '../../../../core/utils/functions/dialogs/app_dialogs.dart';
import '../../../../presentation/profile/view_model/profile_cubit.dart';
import '../../../../presentation/profile/view_model/profile_state.dart';

class BlurredAvatar extends StatefulWidget {
  final String imageUrl;

  const BlurredAvatar({super.key, required this.imageUrl});

  @override
  State<BlurredAvatar> createState() => _BlurredAvatarState();
}

class _BlurredAvatarState extends State<BlurredAvatar> {
  bool _isLoading = false;

  Future<void> _pickImage(BuildContext context) async {
    try {
      // Show options dialog
      final source = await showDialog<ImageSource>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppColors.kBlackBG,
            title: Text('Select Image Source', style: TextStyle(color: Colors.white)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.photo_library, color: AppColors.kOrange),
                  title: Text('Gallery', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.of(context).pop(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera, color: AppColors.kOrange),
                  title: Text('Camera', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.of(context).pop(ImageSource.camera);
                  },
                ),
              ],
            ),
          );
        },
      );

      if (source == null) return;

      // Pick image
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (image != null) {
        final File imageFile = File(image.path);

        // Check file size (limit is 4MB according to API)
        final fileSize = await imageFile.length();
        final fileSizeInMB = fileSize / (1024 * 1024);

        if (fileSizeInMB > 4) {
          if (context.mounted) {
            AppDialogs.showErrorDialog(
              context: context,
              errorMassage: "Image size exceeds the maximum limit of 4MB. Please select a smaller image.",
            );
          }
          return;
        }

        // Show loading state
        setState(() {
          _isLoading = true;
        });

        // Upload using the ProfileCubit
        if (context.mounted) {
          final profileCubit = context.read<ProfileCubit>();
          await profileCubit.uploadPhoto(imageFile);
        }
      }
    } catch (e) {
      print("Error picking image: $e");
      // Make sure to reset loading state
      setState(() {
        _isLoading = false;
      });

      if (context.mounted) {
        AppDialogs.showErrorDialog(
          context: context,
          errorMassage: "Failed to select or process image: ${e.toString()}",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        // Reset loading state when we get any response
        if (state is UploadPhotoSuccessState || state is UploadPhotoErrorState) {
          setState(() {
            _isLoading = false;
          });

          if (state is UploadPhotoSuccessState) {
            AppDialogs.showSuccessDialog(
              context: context,
              message: "Profile photo updated successfully",
            );
          } else if (state is UploadPhotoErrorState) {
            AppDialogs.showErrorDialog(
              context: context,
              errorMassage: state.errorMessage ?? "Failed to update profile photo",
            );
          }
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Circular Image
          ClipOval(
            child: SizedBox(
              width: 100.w,
              height: 100.w,
              child: widget.imageUrl.isNotEmpty
                  ? Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    AppImages.person,
                    fit: BoxFit.cover,
                  );
                },
              )
                  : Image.asset(
                AppImages.person,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Semi-transparent overlay
          ClipOval(
            child: Container(
              width: 100.w,
              height: 100.w,
              color: Colors.black.withOpacity(0.3),
            ),
          ),

          // Glowing effect using RadialGradient
          Container(
            width: 110.w,
            height: 110.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [AppColors.kOrange.withOpacity(0.4), Colors.transparent],
                stops: const [0.6, 1.0],
              ),
            ),
          ),

          // Loading indicator or edit icon
          if (_isLoading)
            CircularProgressIndicator(
              color: AppColors.kOrange,
              strokeWidth: 3.w,
            )
          else
            GestureDetector(
              onTap: () => _pickImage(context),
              child: Container(
                width: 100.w,
                height: 100.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 40.w,
                ),
              ),
            ),
        ],
      ),
    );
  }
}