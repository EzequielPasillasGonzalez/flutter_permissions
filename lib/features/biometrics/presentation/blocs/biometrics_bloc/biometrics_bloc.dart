import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'biometrics_event.dart';
part 'biometrics_state.dart';

class BiometricsBloc extends Bloc<BiometricsEvent, BiometricsState> {
  BiometricsBloc() : super(BiometricsInitial()) {
    on<BiometricsEvent>((event, emit) {});
  }
}
