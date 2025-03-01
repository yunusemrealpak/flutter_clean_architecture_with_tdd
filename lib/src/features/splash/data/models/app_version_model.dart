import 'package:equatable/equatable.dart';

import '../../../../core/network/model/base_model.dart';
import '../../domain/entities/app_version.dart';

class AppVersionModel extends Equatable with BaseModel<AppVersion> {
  final String currentVersion;
  final String minimumVersion;
  final bool forceUpdate;

  const AppVersionModel({
    required this.currentVersion,
    required this.minimumVersion,
    required this.forceUpdate,
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

  @override
  List<Object?> get props => [currentVersion, minimumVersion, forceUpdate];

  @override
  AppVersion toEntity() {
    return AppVersion(
      currentVersion: currentVersion,
      minimumVersion: minimumVersion,
      forceUpdate: forceUpdate,
    );
  }
}
