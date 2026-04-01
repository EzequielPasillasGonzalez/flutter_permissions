part of 'location_bloc.dart';

sealed class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class GetCurrentLocation extends LocationEvent {
  const GetCurrentLocation();
}

class WatchLocation extends LocationEvent {
  const WatchLocation();
}

class OnNewLocation extends LocationEvent {
  final double lat;
  final double lng;
  const OnNewLocation(this.lat, this.lng);
}
