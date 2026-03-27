import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_status_event.dart';
part 'app_status_state.dart';

class AppStatusBloc extends Bloc<AppStatusEvent, AppStatusState> {
  AppStatusBloc() : super(AppResumed()) {
    on<OnAppResumed>(_onAppResumed);

    on<OnAppInactive>(_onAppInactive);

    on<OnAppPaused>(_onAppPaused);

    on<OnAppDetached>(_onAppDetached);
    on<OnAppHiden>(_onAppHiden);
  }

  void onAppResumed() {
    add(OnAppResumed());
  }

  void onAppInactive() {
    add(OnAppInactive());
  }

  void onAppPaused() {
    add(OnAppPaused());
  }

  void onAppDetached() {
    add(OnAppDetached());
  }

  void onAppHiden() {
    add(OnAppHiden());
  }

  void _onAppDetached(OnAppDetached event, Emitter<AppStatusState> emit) {
    emit(const AppDetached());
  }

  void _onAppResumed(OnAppResumed event, Emitter<AppStatusState> emit) {
    emit(const AppResumed());
  }

  void _onAppInactive(OnAppInactive event, Emitter<AppStatusState> emit) {
    emit(const AppInactive());
  }

  void _onAppPaused(OnAppPaused event, Emitter<AppStatusState> emit) {
    emit(const AppPaused());
  }

  void _onAppHiden(OnAppHiden event, Emitter<AppStatusState> emit) {
    emit(const AppHiden());
  }
}
