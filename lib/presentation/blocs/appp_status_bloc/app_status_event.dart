part of 'app_status_bloc.dart';

sealed class AppStatusEvent extends Equatable {
  const AppStatusEvent();

  @override
  List<Object?> get props => [];
}

class OnAppResumed extends AppStatusEvent {
  const OnAppResumed();
}

class OnAppPaused extends AppStatusEvent {
  const OnAppPaused();
}

class OnAppInactive extends AppStatusEvent {
  const OnAppInactive();
}

class OnAppDetached extends AppStatusEvent {
  const OnAppDetached();
}

class OnAppHiden extends AppStatusEvent {
  const OnAppHiden();
}
