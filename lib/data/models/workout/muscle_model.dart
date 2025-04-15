class MuscleGroupResponse {
  final String? message;
  final List<MuscleGroup>? musclesGroup;

  MuscleGroupResponse({this.message, this.musclesGroup});

  factory MuscleGroupResponse.fromJson(Map<String, dynamic> json) {
    return MuscleGroupResponse(
      message: json['message'],
      musclesGroup: json['musclesGroup'] != null
          ? List<MuscleGroup>.from(
          json['musclesGroup'].map((x) => MuscleGroup.fromJson(x)))
          : null,
    );
  }
}

class MuscleGroup {
  final String? id;
  final String? name;

  MuscleGroup({this.id, this.name});

  factory MuscleGroup.fromJson(Map<String, dynamic> json) {
    return MuscleGroup(
      id: json['_id'],
      name: json['name'],
    );
  }

  String getEnglishName() {
    final translations = {
      'العضلات المقربة': 'Adductors',
      'عضلة البايسبس': 'Biceps',
      'عضلة الفخذ الأمامية': 'Quadriceps',
      'عضلات الفخذ الخلفية': 'Hamstrings',
      'عضلات مثنية الورك': 'Hip Flexors',
      'عضلة شبه المنحرفة': 'Trapezius',
      'عضلات الصدر': 'Chest',
      'العضلات المُبعِدة': 'Abductors',
      'عضلات البطن': 'Abs',
      'عضلات الأرداف': 'Glutes',
      'عضلات الكتف': 'Shoulder',
      'عضلات الظهر': 'Back',
      'عضلات الساعد': 'Forearms',
      'عضلات الساق الأمامية': 'Shin',
      'عضلة الترايسبس': 'Triceps',
      'عضلات الذراع': 'Arm',
      'عضلات الساق': 'Legs',
    };

    return translations[name] ?? name ?? 'Unknown';
  }
}

class MuscleDetailResponse {
  final String? message;
  final MuscleGroup? muscleGroup;
  final List<Muscle>? muscles;

  MuscleDetailResponse({this.message, this.muscleGroup, this.muscles});

  factory MuscleDetailResponse.fromJson(Map<String, dynamic> json) {
    return MuscleDetailResponse(
      message: json['message'],
      muscleGroup: json['muscleGroup'] != null
          ? MuscleGroup.fromJson(json['muscleGroup'])
          : null,
      muscles: json['muscles'] != null
          ? List<Muscle>.from(json['muscles'].map((x) => Muscle.fromJson(x)))
          : null,
    );
  }
}

class Muscle {
  final String? id;
  final String? name;
  final String? image;

  Muscle({this.id, this.name, this.image});

  factory Muscle.fromJson(Map<String, dynamic> json) {
    return Muscle(
      id: json['_id'],
      name: json['name'],
      image: json['image'],
    );
  }

  String getEnglishName() {
    final translations = {
      'العضلة الصدرية الكبرى': 'Pectoralis Major',
      'العضلة المقربة الكبيرة': 'Adductor Magnus',
      'العضلة ذات الرأسين العضدية (البايسبس)': 'Biceps Brachii',
      'العضلة الرباعية الرؤوس الفخذية': 'Quadriceps',
      'العضلة ذات الرأسين الفخذية': 'Hamstrings',
      'عضلات الحرقفية القطنية': 'Iliopsoas',
      'العضلة الألوية الوسطى': 'Gluteus Medius',
      'عضلة الساق التوأمية': 'Gastrocnemius',
      'العضلة النعلية': 'Soleus',
      'عضلة البطن المستقيمة': 'Rectus Abdominis',
      'العضلات المائلة': 'Obliques',
      'العضلة الدالية الوسطى': 'Middle Deltoid',
      'العضلة تحت الكتف': 'Subscapularis',
      'العضلة المنشارية الأمامية': 'Serratus Anterior',
      'العضلة الدالية الخلفية': 'Posterior Deltoid',
      'العضلة الدالية الأمامية': 'Anterior Deltoid',
      'العضلة تحت الشوكة': 'Infraspinatus',
      'عضلات الناصبة الفقرية': 'Erector Spinae',
      'العضلة الظهرية العريضة': 'Latissimus Dorsi',
      'العضلة شبه المنحرفة العلوية': 'Upper Trapezius',
      'العضلة العضدية الكعبرية': 'Brachioradialis',
      'العضلة الظنبوبية الأمامية': 'Tibialis Anterior',
      'العضلة ثلاثية الرؤوس العضدية (الترايسبس)': 'Triceps Brachii'
    };

    return translations[name] ?? name ?? 'Unknown';
  }
}