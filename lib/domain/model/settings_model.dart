/// Settings model representing app configuration from Supabase.
class SettingsModel {
  final int id;
  final bool showNoDishMessage;

  SettingsModel({
    required this.id,
    required this.showNoDishMessage,
  });

  /// Creates a SettingsModel from JSON data.
  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      id: json['id'] as int,
      showNoDishMessage: json['show_no_dish_message'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'show_no_dish_message': showNoDishMessage,
    };
  }
}
