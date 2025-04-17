import 'package:fitness_app/core/routes/page_route_name.dart';
import 'package:fitness_app/core/styles/fonts/app_fonts.dart';
import 'package:fitness_app/core/styles/images/app_images.dart';
import 'package:fitness_app/core/utils/widget/custom%20scaffold.dart';
import 'package:fitness_app/core/utils/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/styles/colors/app_colors.dart';
import '../../../core/utils/widget/custom_arrow.dart';
import '../../../core/utils/widget/shimmer_loading_widget.dart';
import '../../profile/view_model/profile_cubit.dart';
import '../widget/object_box.dart';

class RobotScreen extends StatefulWidget {
  const RobotScreen({super.key});

  @override
  State<RobotScreen> createState() => _RobotScreenState();
}

class _RobotScreenState extends State<RobotScreen> {
  late Future<void> _loadDataFuture;
  bool _isDataLoaded = false;

  @override
  void initState() {
    super.initState();

    _loadDataFuture = _loadData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isDataLoaded) {
      _loadDataFuture = _loadData();
    }
    precacheImage(AssetImage(AppImages.robot), context);
    precacheImage(AssetImage(AppImages.backgroundRobot), context);
  }
  Future<void> _loadData() async {
    final cubit = context.read<ProfileCubit>();
    await cubit.getUserData();
    setState(() {
      _isDataLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundImage: AppImages.backgroundRobot,
      overlayOpacity: 0.1,
      enableBlur: false,
      blurStrength: 6.0,
      blurHeight: 140.0.h,
      blurWidth: 350.0.w,
      borderRadius: 30.0.r,
      blurStartPosition: MediaQuery.of(context).size.height * 0.62,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomArrow(),
                Column(
                  children: [
                    FutureBuilder(
                      future: _loadDataFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return _buildShimmerTabs();
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}",
                              style: AppFonts.font16WhiteWeight500);
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          final cubit = context.watch<ProfileCubit>();
                          final userName = cubit.userName;
                          return Row(
                            children: [
                              Text("Hi", style: AppFonts.font16WhiteWeight500),
                              2.horizontalSpace,
                              Text(userName ?? "Rowan",
                                  style: AppFonts.font16WhiteWeight500),
                              Text(",", style: AppFonts.font16WhiteWeight500),
                            ],
                          );
                        } else {
                          return Text("Unexpected state",
                              style: AppFonts.font16WhiteWeight500);
                        }
                      },
                    ),
                    Text("I Am Your Smart Coach",
                        style: AppFonts.font16WhiteWeight500
                            .copyWith(fontSize: 18.sp)),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    openPreviousChats(context);
                  },
                  child: Image.asset(AppImages.menuIcon),
                ),
              ],
            ),
            20.verticalSpace,
            Image.asset(
              AppImages.robot,
              fit: BoxFit.cover,
              height: 500.h,
            ),
            Center(
              child: Text(
                "How Can I Assist You Today?",
                style: AppFonts.font24WhiteWeight800,
                textAlign: TextAlign.center,
              ),
            ),
            CustomButton(
              width: 300.w,
              onPressed: () {
                Navigator.pushReplacementNamed(
                    context, PageRouteName.chatScreen);
              },
              text: "Get Started",
              textStyle: AppFonts.font14WhiteWeight800,
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerTabs() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: ShimmerLoadingWidget(
        width: 80.w,
        height: 25.h,
        borderRadius: 25.r,
      ),
    );
  }

  void openPreviousChats(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        final objectBox = context.read<ObjectBox>();
        List<String> previousConversations = objectBox.getChatTitles();
        return Align(
          alignment: Alignment.centerRight,
          child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.kMainColor.withOpacity(0.8),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15.r)),
              ),
              width: MediaQuery.of(context).size.width * 0.7,
              height: double.infinity,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Previous Conversations",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  10.verticalSpace,
                  Expanded(
                    child: ListView.separated(
                      itemCount: previousConversations.length,
                      separatorBuilder: (context, index) =>
                          Divider(color: Colors.white24, thickness: 1),
                      itemBuilder: (context, index) {
                        return ListTile(
                            leading: Icon(Icons.arrow_back_ios,
                                color: AppColors.kOrange),
                            title: Text(
                              previousConversations[index],
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                PageRouteName.chatScreen,
                                arguments: previousConversations[index],
                              );
                            });
                      },
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
}
