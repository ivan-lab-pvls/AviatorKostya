class PlanModel {
  final String title;
  final String description;

  PlanModel({
    required this.title,
    required this.description,
  });

  factory PlanModel.fromJson(Map<String, dynamic> json) {
    return PlanModel(
      title: json['title'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
    };
  }
}
