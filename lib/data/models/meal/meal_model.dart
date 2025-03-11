class MealResponse {
  final List<Meal>? meals;

  MealResponse({this.meals});

  factory MealResponse.fromJson(Map<String, dynamic> json) {
    return MealResponse(
      meals: json['meals'] != null
          ? List<Meal>.from(json['meals'].map((x) => Meal.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meals': meals?.map((x) => x.toJson()).toList(),
    };
  }
}

class Meal {
  final String? idMeal;
  final String? strMeal;
  final String? strCategory;
  final String? strArea;
  final String? strInstructions;
  final String? strMealThumb;
  final String? strTags;
  final String? strYoutube;
  final Map<String, String?> ingredients = {};
  final Map<String, String?> measures = {};
  final String? strSource;

  Meal({
    this.idMeal,
    this.strMeal,
    this.strCategory,
    this.strArea,
    this.strInstructions,
    this.strMealThumb,
    this.strTags,
    this.strYoutube,
    this.strSource,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    Meal meal = Meal(
      idMeal: json['idMeal'],
      strMeal: json['strMeal'],
      strCategory: json['strCategory'],
      strArea: json['strArea'],
      strInstructions: json['strInstructions'],
      strMealThumb: json['strMealThumb'],
      strTags: json['strTags'],
      strYoutube: json['strYoutube'],
      strSource: json['strSource'],
    );

    for (int i = 1; i <= 20; i++) {
      String ingredientKey = 'strIngredient$i';
      String measureKey = 'strMeasure$i';

      String? ingredient = json[ingredientKey];
      String? measure = json[measureKey];

      if (ingredient != null && ingredient.trim().isNotEmpty) {
        meal.ingredients[ingredientKey] = ingredient;
        meal.measures[measureKey] = measure;
      }
    }

    return meal;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'idMeal': idMeal,
      'strMeal': strMeal,
      'strCategory': strCategory,
      'strArea': strArea,
      'strInstructions': strInstructions,
      'strMealThumb': strMealThumb,
      'strTags': strTags,
      'strYoutube': strYoutube,
      'strSource': strSource,
    };


    ingredients.forEach((key, value) {
      json[key] = value;
    });

    measures.forEach((key, value) {
      json[key] = value;
    });

    return json;
  }

  List<IngredientWithMeasure> getIngredientsWithMeasures() {
    List<IngredientWithMeasure> result = [];

    for (int i = 1; i <= 20; i++) {
      String ingredientKey = 'strIngredient$i';
      String measureKey = 'strMeasure$i';

      if (ingredients.containsKey(ingredientKey) &&
          ingredients[ingredientKey] != null &&
          ingredients[ingredientKey]!.trim().isNotEmpty) {
        result.add(IngredientWithMeasure(
          ingredient: ingredients[ingredientKey]!,
          measure: measures[measureKey] ?? '',
        ));
      }
    }

    return result;
  }

  NutritionalInfo getNutritionalInfo() {

    return NutritionalInfo(
      energy: 100,
      protein: 15,
      carbs: 58,
      fat: 20,
    );
  }
}

class IngredientWithMeasure {
  final String ingredient;
  final String measure;

  IngredientWithMeasure({
    required this.ingredient,
    required this.measure,
  });
}

class NutritionalInfo {
  final int energy;
  final int protein;
  final int carbs;
  final int fat;

  NutritionalInfo({
    required this.energy,
    required this.protein,
    required this.carbs,
    required this.fat,
  });
}