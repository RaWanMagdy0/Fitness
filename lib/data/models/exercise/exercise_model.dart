import '../../../domain/entity/exercise/exercise_entity.dart';

class ExerciseModel {
  ExerciseModel({
      this.id, 
      this.exercise, 
      this.shortYoutubeDemonstration, 
      this.inDepthYoutubeExplanation, 
      this.difficultyLevel, 
      this.targetMuscleGroup, 
      this.primeMoverMuscle, 
      this.secondaryMuscle, 
      this.tertiaryMuscle, 
      this.primaryEquipment, 
      this.primaryItems, 
      this.secondaryEquipment, 
      this.secondaryItems, 
      this.posture, 
      this.singleOrDoubleArm, 
      this.continuousOrAlternatingArms, 
      this.grip, 
      this.loadPositionEnding, 
      this.continuousOrAlternatingLegs, 
      this.footElevation, 
      this.combinationExercises, 
      this.movementPattern1, 
      this.movementPattern2, 
      this.movementPattern3, 
      this.planeOfMotion1, 
      this.planeOfMotion2, 
      this.planeOfMotion3, 
      this.bodyRegion, 
      this.forceType, 
      this.mechanics, 
      this.laterality, 
      this.primaryExerciseClassification, 
      this.shortYoutubeDemonstrationLink, 
      this.inDepthYoutubeExplanationLink,});

  ExerciseModel.fromJson(dynamic json) {
    id = json['_id'];
    exercise = json['exercise'];
    shortYoutubeDemonstration = json['short_youtube_demonstration'];
    inDepthYoutubeExplanation = json['in_depth_youtube_explanation'];
    difficultyLevel = json['difficulty_level'];
    targetMuscleGroup = json['target_muscle_group'];
    primeMoverMuscle = json['prime_mover_muscle'];
    secondaryMuscle = json['secondary_muscle'];
    tertiaryMuscle = json['tertiary_muscle'];
    primaryEquipment = json['primary_equipment'];
    primaryItems = json['_primary_items'];
    secondaryEquipment = json['secondary_equipment'];
    secondaryItems = json['_secondary_items'];
    posture = json['posture'];
    singleOrDoubleArm = json['single_or_double_arm'];
    continuousOrAlternatingArms = json['continuous_or_alternating_arms'];
    grip = json['grip'];
    loadPositionEnding = json['load_position_ending'];
    continuousOrAlternatingLegs = json['continuous_or_alternating_legs'];
    footElevation = json['foot_elevation'];
    combinationExercises = json['combination_exercises'];
    movementPattern1 = json['movement_pattern_1'];
    movementPattern2 = json['movement_pattern_2'];
    movementPattern3 = json['movement_pattern_3'];
    planeOfMotion1 = json['plane_of_motion_1'];
    planeOfMotion2 = json['plane_of_motion_2'];
    planeOfMotion3 = json['plane_of_motion_3'];
    bodyRegion = json['body_region'];
    forceType = json['force_type'];
    mechanics = json['mechanics'];
    laterality = json['laterality'];
    primaryExerciseClassification = json['primary_exercise_classification'];
    shortYoutubeDemonstrationLink = json['short_youtube_demonstration_link'];
    inDepthYoutubeExplanationLink = json['in_depth_youtube_explanation_link'];
  }
  String? id;
  String? exercise;
  String? shortYoutubeDemonstration;
  String? inDepthYoutubeExplanation;
  String? difficultyLevel;
  String? targetMuscleGroup;
  String? primeMoverMuscle;
  dynamic secondaryMuscle;
  dynamic tertiaryMuscle;
  String? primaryEquipment;
  int? primaryItems;
  dynamic secondaryEquipment;
  int? secondaryItems;
  String? posture;
  String? singleOrDoubleArm;
  String? continuousOrAlternatingArms;
  String? grip;
  String? loadPositionEnding;
  String? continuousOrAlternatingLegs;
  String? footElevation;
  String? combinationExercises;
  String? movementPattern1;
  dynamic movementPattern2;
  dynamic movementPattern3;
  String? planeOfMotion1;
  dynamic planeOfMotion2;
  dynamic planeOfMotion3;
  String? bodyRegion;
  String? forceType;
  String? mechanics;
  String? laterality;
  String? primaryExerciseClassification;
  String? shortYoutubeDemonstrationLink;
  String? inDepthYoutubeExplanationLink;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['exercise'] = exercise;
    map['short_youtube_demonstration'] = shortYoutubeDemonstration;
    map['in_depth_youtube_explanation'] = inDepthYoutubeExplanation;
    map['difficulty_level'] = difficultyLevel;
    map['target_muscle_group'] = targetMuscleGroup;
    map['prime_mover_muscle'] = primeMoverMuscle;
    map['secondary_muscle'] = secondaryMuscle;
    map['tertiary_muscle'] = tertiaryMuscle;
    map['primary_equipment'] = primaryEquipment;
    map['_primary_items'] = primaryItems;
    map['secondary_equipment'] = secondaryEquipment;
    map['_secondary_items'] = secondaryItems;
    map['posture'] = posture;
    map['single_or_double_arm'] = singleOrDoubleArm;
    map['continuous_or_alternating_arms'] = continuousOrAlternatingArms;
    map['grip'] = grip;
    map['load_position_ending'] = loadPositionEnding;
    map['continuous_or_alternating_legs'] = continuousOrAlternatingLegs;
    map['foot_elevation'] = footElevation;
    map['combination_exercises'] = combinationExercises;
    map['movement_pattern_1'] = movementPattern1;
    map['movement_pattern_2'] = movementPattern2;
    map['movement_pattern_3'] = movementPattern3;
    map['plane_of_motion_1'] = planeOfMotion1;
    map['plane_of_motion_2'] = planeOfMotion2;
    map['plane_of_motion_3'] = planeOfMotion3;
    map['body_region'] = bodyRegion;
    map['force_type'] = forceType;
    map['mechanics'] = mechanics;
    map['laterality'] = laterality;
    map['primary_exercise_classification'] = primaryExerciseClassification;
    map['short_youtube_demonstration_link'] = shortYoutubeDemonstrationLink;
    map['in_depth_youtube_explanation_link'] = inDepthYoutubeExplanationLink;
    return map;
  }

  Exercise toEntity() {
    return Exercise(
      id: id,
      exercise: exercise,
      shortYoutubeDemonstration: shortYoutubeDemonstration,
      inDepthYoutubeExplanation: inDepthYoutubeExplanation,
      difficultyLevel: difficultyLevel,
      targetMuscleGroup: targetMuscleGroup,
      primeMoverMuscle: primeMoverMuscle,
      secondaryMuscle: secondaryMuscle,
      tertiaryMuscle: tertiaryMuscle,
      primaryEquipment: primaryEquipment,
      primaryItems: primaryItems,
      secondaryEquipment: secondaryEquipment,
      secondaryItems: secondaryItems,
      posture: posture,
      singleOrDoubleArm: singleOrDoubleArm,
      continuousOrAlternatingArms: continuousOrAlternatingArms,
      grip: grip,
      loadPositionEnding: loadPositionEnding,
      continuousOrAlternatingLegs: continuousOrAlternatingLegs,
      footElevation: footElevation,
      combinationExercises: combinationExercises,
      movementPattern1: movementPattern1,
      movementPattern2: movementPattern2,
      movementPattern3: movementPattern3,
      planeOfMotion1: planeOfMotion1,
      planeOfMotion2: planeOfMotion2,
      planeOfMotion3: planeOfMotion3,
      bodyRegion: bodyRegion,
      forceType: forceType,
      mechanics: mechanics,
      laterality: laterality,
      primaryExerciseClassification: primaryExerciseClassification,
      shortYoutubeDemonstrationLink: shortYoutubeDemonstrationLink,
      inDepthYoutubeExplanationLink: inDepthYoutubeExplanationLink,
    );
  }

}