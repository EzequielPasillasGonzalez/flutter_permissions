part of 'map_bloc.dart';

class MapState extends Equatable {
  const MapState({
    this.isReady = false,
    this.followUser = false,
    this.markers = const [],
    this.controller,
  });

  final bool isReady;
  final bool followUser;
  final List<Marker> markers;
  final GoogleMapController? controller;

  MapState copyWith({
    bool? isReady,
    bool? followUser,
    List<Marker>? markers,
    GoogleMapController? controller,
  }) {
    return MapState(
      isReady: isReady ?? this.isReady,
      followUser: followUser ?? this.followUser,
      markers: markers ?? this.markers,
      controller: controller ?? this.controller,
    );
  }

  @override
  List<Object?> get props => [isReady, followUser, markers, controller];
}
