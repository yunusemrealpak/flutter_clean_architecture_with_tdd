import 'package:equatable/equatable.dart';

class AppVersion extends Equatable {
  final String currentVersion;
  final String minimumVersion;
  final bool forceUpdate;

  const AppVersion({
    required this.currentVersion,
    required this.minimumVersion,
    required this.forceUpdate,
  });

  @override
  List<Object?> get props => [currentVersion, minimumVersion, forceUpdate];
}
