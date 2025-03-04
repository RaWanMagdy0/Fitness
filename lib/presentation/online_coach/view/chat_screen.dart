import 'package:fitness_app/core/styles/colors/app_colors.dart';
import 'package:fitness_app/core/utils/widget/custom%20scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/styles/fonts/app_fonts.dart';
import '../../../core/styles/images/app_images.dart';
import '../../../core/utils/widget/custom_arrow.dart';
import '../view_model/smart_coach_cubit.dart';
import '../view_model/smart_coach_state.dart';
import '../widget/object_box.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  List<String> previousConversations = [];
late GeminiCubit viewModel;
  @override
  void initState() {
    super.initState();
    viewModel = context.read<GeminiCubit>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
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
                  borderRadius: BorderRadius.only(topLeft:Radius.circular(15.r) )
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
                      separatorBuilder: (context, index) => Divider(color: Colors.white24, thickness: 1),
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(Icons.arrow_back_ios, color: AppColors.kOrange),
                          title: Text(
                            previousConversations[index],
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            viewModel.loadChatByTitle(previousConversations[index]);
                            Future.delayed(Duration(milliseconds: 100), () {
                              setState(() {});
                            });
                          },

                        );
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
          List<Map<String, String>> chatMessages = state is GeminiSuccessState ? state.messages : List.from(cubit.messages);

          return CustomScaffold(
            backgroundImage: AppImages.backgroundRobot,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomArrow(),
                      Text(
                        "Search Coach",
                        style: AppFonts.font16WhiteWeight500.copyWith(fontSize: 18),
                      ),
                      GestureDetector(
                        onTap: openPreviousChats,
                        child: Image.asset(AppImages.menuIcon),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: chatMessages.length,
                      itemBuilder: (context, index) {
                        final message = chatMessages[index];
                        final isSender = message['sender'] == "user";
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
                            children: [
                              if (!isSender)
                                const CircleAvatar(
                                  backgroundImage: AssetImage(AppImages.geminiImage),
                                ),
                              8.horizontalSpace,
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: isSender ? AppColors.brownColor.withOpacity(0.5) : AppColors.bottomNavColor.withOpacity(0.9),
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
                                const CircleAvatar(
                                  backgroundImage: AssetImage(AppImages.person),
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
                        IconButton(
                          icon: Icon(Icons.emoji_emotions, color: AppColors.kWhite),
                          onPressed: () {},
                        ),
                        8.horizontalSpace,
                        Expanded(
                          child: TextField(
                            keyboardAppearance: Brightness.dark,
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: "Write your message...",
                              hintStyle: AppFonts.font14WhiteWeight400,
                            ),
                            style: AppFonts.font14WhiteWeight400,
                          ),
                        ),
                        8.horizontalSpace,
                        IconButton(
                          icon: Icon(Icons.mic, color: AppColors.kWhite, size: 28),
                          onPressed: cubit.startListening,
                        ),
                        IconButton(
                          icon: Icon(Icons.send, color: AppColors.kWhite),
                          onPressed: () {
                            cubit.sendMessage(_controller.text);
                            _controller.clear();
                            updateChatTitles();
                            setState(() {});
                          }
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
}
