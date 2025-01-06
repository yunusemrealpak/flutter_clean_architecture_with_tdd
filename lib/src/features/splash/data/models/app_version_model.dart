import '../../domain/entities/app_version.dart';

class AppVersionModel extends AppVersion {
  const AppVersionModel({
    required super.currentVersion,
    required super.minimumVersion,
    required super.forceUpdate,
  });

  factory AppVersionModel.fromJson(Map<String, dynamic> json) {
    return AppVersionModel(
      currentVersion: json['currentVersion'] as String,
      minimumVersion: json['minimumVersion'] as String,
      forceUpdate: json['forceUpdate'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentVersion': currentVersion,
      'minimumVersion': minimumVersion,
      'forceUpdate': forceUpdate,
    };
  }
}
