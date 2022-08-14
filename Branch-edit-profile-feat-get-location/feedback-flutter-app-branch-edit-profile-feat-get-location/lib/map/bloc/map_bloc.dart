import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:feedback24_app/map/data/model/placemark_model.dart';

import '../data/repository/placemark_repository.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final MapRepository mapRepository;

  MapBloc({
    required this.mapRepository,
  }) : super(MapInitial()) {
    on<MapFetchEvent>(_fetchAudits);
  }

  FutureOr<void> _fetchAudits(
      MapFetchEvent event, Emitter<MapState> emit) async {
    try {
      emit(MapLoading());
      final coords = await mapRepository.getMaps();
      emit(MapLoaded(coords: coords));
      print(_fetchAudits);
    } catch (e) {
      emit(MapError(message: e.toString()));
    }
  }
}
