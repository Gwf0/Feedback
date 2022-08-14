part of 'map_bloc.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

class MapInitial extends MapState {}

class MapLoading extends MapState {}

class MapLoaded extends MapState {
  final Coords coords;
  const MapLoaded({
    required this.coords,
  });
}

class MapError extends MapState {
  final String message;
  const MapError({
    required this.message,
  });
}
