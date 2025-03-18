import 'package:flutter/cupertino.dart';
import '../../../../../domain/entity/exercise/exercise_entity.dart';
import 'custom_video_card.dart';


class ExerciseList extends StatelessWidget {
  final List<Exercise?> exercises;

  const ExerciseList({super.key, required this.exercises});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        return CustomVideoCard(exercise: exercises[index]);
      },
    );
  }
}
