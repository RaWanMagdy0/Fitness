import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../../domain/entity/meal/exercise_by_muscle_and_level_entity.dart';
import 'custom_video_card.dart';


class ExerciseList extends StatefulWidget {
  final List<ExerciseByMuscleAndLevelEntity?> exercises;

  const ExerciseList({super.key, required this.exercises});

  @override
  State<ExerciseList> createState() => _ExerciseListState();
}

class _ExerciseListState extends State<ExerciseList> {
  YoutubePlayerController? _controller;
  bool _isVideoPlaying = false;
  String? _currentVideoUrl;
  String? _currentVideoTitle;

  void _playVideo(ExerciseByMuscleAndLevelEntity? exercise) {
    if (exercise?.shortYoutubeDemonstrationLink == null ||
        exercise!.shortYoutubeDemonstrationLink!.isEmpty) {
      return;
    }

    final videoUrl = exercise.shortYoutubeDemonstrationLink!;
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);

    if (videoId == null) return;

    setState(() {
      _isVideoPlaying = true;
      _currentVideoUrl = videoUrl;
      _currentVideoTitle = exercise.exercise;
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          enableCaption: true,
        ),
      );
    });
  }

  void _closeVideo() {
    setState(() {
      _isVideoPlaying = false;
      _controller?.dispose();
      _controller = null;
    });
  }

  void _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Video player at the top
        if (_isVideoPlaying && _controller != null)
          Container(
            color: Colors.black,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                YoutubePlayer(
                  controller: _controller!,
                  showVideoProgressIndicator: true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          _currentVideoTitle ?? "Exercise Video",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.open_in_new, color: Colors.white),
                            onPressed: () {
                              if (_currentVideoUrl != null) {
                                _launchURL(_currentVideoUrl!);
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.white),
                            onPressed: _closeVideo,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.exercises.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => _playVideo(widget.exercises[index]),
                child: CustomVideoCard(
                  exercise: widget.exercises[index],
                  onPlayPressed: () => _playVideo(widget.exercises[index]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

