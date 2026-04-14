part of 'workmanager_cubit.dart';

class WorkmanagerState extends Equatable {
  final Map<String, bool> activeProcesses;

  const WorkmanagerState({this.activeProcesses = const {}});
  WorkmanagerState copyWith({Map<String, bool>? activeProcesses}) {
    return WorkmanagerState(
      activeProcesses: activeProcesses ?? this.activeProcesses,
    );
  }

  @override
  List<Object?> get props => [activeProcesses];
}
