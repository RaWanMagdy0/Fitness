import 'package:fitness_app/core/styles/colors/app_colors.dart';
import 'package:fitness_app/core/styles/images/app_images.dart';
import 'package:flutter/material.dart';
import '../../../../../domain/entity/meal/exercise_by_muscle_and_level_entity.dart';


class CustomVideoCard extends StatelessWidget {
  final ExerciseByMuscleAndLevelEntity? exercise;
  final VoidCallback onPlayPressed;

  const CustomVideoCard({
    super.key,
    required this.exercise,
    required this.onPlayPressed,
  });

  String? getYoutubeThumbnail(String? url) {
    if (url == null) return null;
    String? videoId;
    if (url.contains("youtube.com/watch?v=")) {
      videoId = Uri.parse(url).queryParameters['v'];
    } else if (url.contains("youtu.be/")) {
      videoId = url.split("youtu.be/")[1].split("?")[0];
    } else if (url.contains("youtube.com/embed/")) {
      videoId = url.split("embed/")[1].split("?")[0];
    }
    if (videoId == null || videoId.isEmpty) return null;
    return 'https://img.youtube.com/vi/$videoId/0.jpg';
  }

  @override
  Widget build(BuildContext context) {
    String? thumbnailUrl = getYoutubeThumbnail(exercise?.shortYoutubeDemonstrationLink);

    return Card(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                thumbnailUrl ?? "",
                width: 100,
                height: 120,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  AppImages.chestExerciseImage,
                  width: 100,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),

            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exercise?.exercise ?? "Exercise Name",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Body Region: ${exercise?.bodyRegion} ",
                    style: const TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                  Text(
                    "Primary equipment: ${exercise?.primaryEquipment} ",
                    style: const TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: onPlayPressed,
              borderRadius: BorderRadius.circular(25),
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: AppColors.kOrange,
                ),
                child: const Center(
                  child: Icon(Icons.play_arrow, color: Colors.black, size: 30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
