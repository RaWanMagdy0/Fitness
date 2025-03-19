import 'package:fitness_app/core/routes/page_route_name.dart';
import 'package:fitness_app/core/styles/colors/app_colors.dart';
import 'package:fitness_app/core/utils/widget/custom%20scaffold.dart';
import 'package:fitness_app/core/utils/widget/shimmer_loading_widget.dart';
import 'package:fitness_app/presentation/profile/view_model/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../../core/styles/fonts/app_fonts.dart';
import '../../../core/styles/images/app_images.dart';
import '../../../core/utils/widget/custom_arrow.dart';
import '../../profile/view_model/profile_state.dart';
import '../view_model/smart_coach_cubit.dart';
import '../view_model/smart_coach_state.dart';
import '../widget/object_box.dart';

class ChatScreen extends StatefulWidget {
  final String? title;

  const ChatScreen({super.key, this.title});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  List<String> previousConversations = [];
  late GeminiCubit viewModel;
  bool showWelcomeMessage = true;

  @override
  void initState() {
    super.initState();
    viewModel = context.read<GeminiCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.title != null && widget.title!.isNotEmpty) {
        context.read<GeminiCubit>().loadChatByTitle(widget.title!);
      } else {}
      updateChatTitles();
    });
  }

  void updateChatTitles() {
    final objectBox = context.read<ObjectBox>();
    setState(() {
      previousConversations = objectBox.getChatTitles();
    });
  }

  void openPreviousChats() {
    showDialog(
      context: context,
      builder: (context) {
        return Align(
          alignment: Alignment.centerRight,
          child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.kMainColor.withOpacity(0.8),
                  borderRadius:
                  BorderRadius.only(topLeft: Radius.circular(15.r))),
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
                              Navigator.pop(context);
                              setState(() {
                                showWelcomeMessage = false;
                              });
                              viewModel.loadChatByTitle(
                                  previousConversations[index]);
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<GeminiCubit>(context),
      child: BlocBuilder<GeminiCubit, GeminiState>(
        builder: (context, state) {
          GeminiCubit cubit = BlocProvider.of<GeminiCubit>(context);
          List<Map<String, String>> chatMessages = state is GeminiSuccessState
              ? state.messages
              : List.from(cubit.messages);
          bool isLoading = state is GeminiLoadingState;

          return CustomScaffold(
            backgroundImage: AppImages.backgroundRobot,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, PageRouteName.robotScreen);
                          },
                          child: CustomArrow()),
                      Text(
                        "Search Coach",
                        style: AppFonts.font16WhiteWeight500
                            .copyWith(fontSize: 18),
                      ),
                      GestureDetector(
                        onTap: openPreviousChats,
                        child: Image.asset(AppImages.menuIcon),
                      ),
                    ],
                  ),
                  50.verticalSpace,
                  if (showWelcomeMessage && chatMessages.isEmpty && !isLoading)
                    Expanded(
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Lottie.asset(
                                AppImages.geminiAnimi,
                                height: 260.h,
                              ),
                              Text(
                                "Hi How Can I Help You Today!",
                                style: TextStyle(
                                    color: AppColors.kWhite,
                                    fontSize: 21.sp,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: chatMessages.length + (isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (isLoading && index == chatMessages.length) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 24.r,
                                  backgroundColor: Colors.transparent,
                                  child: ClipOval(
                                    child: Image.asset(
                                      AppImages.geminiImage,
                                      fit: BoxFit.cover,
                                      width: 48.w,
                                      height: 48.h,
                                    ),
                                  ),
                                ),
                                16.horizontalSpace,
                                _buildLoadingIndicator(),
                              ],
                            ),
                          );
                        }

                        final message = chatMessages[index];
                        final isSender = message['sender'] == "user";
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: isSender
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              if (!isSender)
                                CircleAvatar(
                                  radius: 24.r,
                                  backgroundColor: Colors.transparent,
                                  child: ClipOval(
                                    child: Image.asset(
                                      AppImages.geminiImage,
                                      fit: BoxFit.cover,
                                      width: 48.w,
                                      height: 48.h,
                                    ),
                                  ),
                                ),
                              8.horizontalSpace,
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: isSender
                                        ? AppColors.brownColor.withOpacity(0.5)
                                        : AppColors.bottomNavColor
                                        .withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Text(
                                    message['text'] ?? '',
                                    style: const TextStyle(color: Colors.white),
                                    softWrap: true,
                                  ),
                                ),
                              ),
                              8.horizontalSpace,
                              if (isSender)
                                BlocBuilder<ProfileCubit, ProfileState>(
                                  builder: (context, state) {
                                    final userImage =
                                        context.watch<ProfileCubit>().userImage;
                                    return CircleAvatar(
                                      radius: 24,
                                      backgroundColor: Colors.transparent,
                                      child: ClipOval(
                                        child: userImage != null &&
                                            userImage.isNotEmpty
                                            ? Image.network(
                                          userImage,
                                          fit: BoxFit.cover,
                                          width: 48,
                                          height: 48,
                                          errorBuilder: (context, error,
                                              stackTrace) {
                                            return Image.asset(
                                              AppImages.person,
                                              fit: BoxFit.cover,
                                              width: 48,
                                              height: 48,
                                            );
                                          },
                                        )
                                            : Image.asset(
                                          AppImages.person,
                                          fit: BoxFit.cover,
                                          width: 48,
                                          height: 48,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,

                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: "Write your message...",
                              hintStyle: AppFonts.font14WhiteWeight400,
                              filled: true,
                              fillColor:
                              AppColors.bottomNavColor.withOpacity(0.5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: AppColors.kOrange,
                            style: AppFonts.font14WhiteWeight400,
                          ),
                        ),
                        8.horizontalSpace,
                        IconButton(
                          icon: Icon(
                            cubit.isListening ? Icons.stop_circle : Icons.mic,
                            color: cubit.isListening
                                ? Colors.red
                                : AppColors.kWhite,
                            size: 28,
                          ),
                          onPressed: () {
                            if (!cubit.isListening) {
                              cubit.startListening();
                            } else {
                              cubit.stopListening();
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.send, color: AppColors.kWhite),
                          onPressed: () {
                            if (_controller.text.trim().isNotEmpty) {
                              cubit.sendMessage(_controller.text);
                              _controller.clear();
                              setState(() {
                                showWelcomeMessage = false;
                              });
                              updateChatTitles();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return SizedBox(
      height: 100.h,
      child: Lottie.asset(
        AppImages.loadingMess,
        fit: BoxFit.cover,
      ),
    );
  }
}
  Widget _buildLoadingShimmer() {
    return ListView.builder(
      itemCount: 5, // Show 5 shimmer placeholders
      itemBuilder: (context, index) {
        // Alternate between user and AI messages
        final isUserMessage = index % 2 == 0;

        return Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!isUserMessage)
                ShimmerLoadingWidget(
                  width: 48.w,
                  height: 48.h,
                  borderRadius: 24.r, // Circle
                ),

              8.horizontalSpace,

              // Message bubble shimmer
              Flexible(
                child: ShimmerLoadingWidget(
                  width: (200 + (index * 20) % 100).w, // Varied width for more natural look
                  height: (40 + (index * 10) % 30).h, // Varied height
                  borderRadius: 12.r,
                ),
              ),

              8.horizontalSpace,

              if (isUserMessage)
                ShimmerLoadingWidget(
                  width: 48.w,
                  height: 48.h,
                  borderRadius: 24.r, // Circle
                ),
            ],
          ),
        );
      },
    );
  }
