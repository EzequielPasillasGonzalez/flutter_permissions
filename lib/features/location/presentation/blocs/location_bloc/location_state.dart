part of 'location_bloc.dart';

class LocationState extends Equatable {
  final bool loading;
  final bool serviceEnabled;
  final String message;
  final double lat;
  final double lng;

  const LocationState({
    this.loading = false,
    this.serviceEnabled = false,
    this.message = '',
    this.lat = 0,
    this.lng = 0,
  });

  @override
  List<Object> get props => [serviceEnabled, loading, message, lat, lng];

  LocationState copyWith({
    bool? serviceEnabled,
    bool? loading,
    String? message,
    double? lat,
    double? lng,
  }) {
    return LocationState(
      loading: loading ?? this.loading,
      serviceEnabled: serviceEnabled ?? this.serviceEnabled,
      message: message ?? this.message,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  @override
  String toString() {
    return 'lat=$lat, lng=$lng}';
  }
}
