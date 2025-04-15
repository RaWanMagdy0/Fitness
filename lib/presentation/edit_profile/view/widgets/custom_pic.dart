import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/styles/images/app_images.dart';
import '../../../../core/utils/functions/dialogs/app_dialogs.dart';
import '../../view_model/edit_profile_cubit.dart';

class CustomProfilePic extends StatefulWidget {
  const CustomProfilePic({super.key, required this.userImage});

  final String userImage;

  @override
  State<CustomProfilePic> createState() => _CustomProfilePicState();
}

class _CustomProfilePicState extends State<CustomProfilePic> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  late EditProfileCubit editProfileCubit;

  @override
  void initState() {
    super.initState();
    editProfileCubit = context.read<EditProfileCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BlocProvider(
        create: (context) => editProfileCubit,
        child: BlocListener<EditProfileCubit, EditProfileState>(
          listener: (context, state) {
            switch (state) {
              case UploadPhotoLoadingState():
                AppDialogs.showLoading(context: context);
              case UploadPhotoSuccessState():
               // context.read<ProfileCubit>().getUserData();
                AppDialogs.showSuccessDialog(
                  context: context,
                  message: "Photo uploaded successfully",
                );

              case UploadPhotoErrorState():
                Navigator.pop(context);
                AppDialogs.showErrorDialog(
                  context: context,
                  errorMassage: state.errorMessage.toString(),
                );
              default:
            }
          },
          child: Stack(children: [
            ClipOval(
              child: _selectedImage != null
                  ? Image.file(
                      _selectedImage!,
                      height: 100.h,
                      width: 100.w,
                      fit: BoxFit.cover,
                    )
                  : (widget.userImage.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: widget.userImage,
                          fit: BoxFit.cover,
                          height: 100.h,
                          width: 100.w,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Image.asset(
                            AppImages.person,
                            height: 100.h,
                            width: 100.w,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.asset(
                          AppImages.person,
                          height: 100.h,
                          width: 100.w,
                          fit: BoxFit.cover,
                        )),
            ),
            Positioned(
                right: 20,
                bottom: 1,
                child: GestureDetector(
                  onTap: () => _pickAndUploadImage(),
                  child: Icon(
                    size: 30.sp,
                    Icons.edit_outlined,
                    color: AppColors.kOrange,
                  ),
                )),
          ]),
        ),
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
