import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reforzamiento/config/config.dart';

part 'badge_state.dart';

class BadgeCubit extends Cubit<BadgeState> {
  BadgeCubit() : super(BadgeState(count: 0));

  void increment() {
    emit(BadgeState(count: state.count + 1));
    AppBadgePlugin.updateBadge(state.count);
  }

  void decrement() {
    if (state.count <= 0) return;
    emit(BadgeState(count: state.count - 1));
    AppBadgePlugin.updateBadge(state.count);
  }

  void reset() {
    emit(BadgeState(count: 0));
    AppBadgePlugin.removeBadge();
  }
}
