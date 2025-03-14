import 'package:flutter/cupertino.dart';
import '../../../core/styles/images/app_images.dart';
import 'custom_video_card.dart';


class ExerciseList extends StatelessWidget {
  final List<Map<String, String>> exercises = List.generate(4, (index) => {
    "image": AppImages.videoImage,
    "title": "Bench Press",
    "sets": "3 Groups * 15 Times",
    "description": "Lorem Ipsum Dolor Sit Amet Consectetur. Tempus"
  });

  ExerciseList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        return CustomVideoCard(exercise: exercises[index]);
      },
    );
  }
}