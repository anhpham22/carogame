import 'package:carogame/viewmodel/play_progress_event.dart';
import 'package:carogame/viewmodel/play_progress_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayProgressBloc extends Bloc<PlayProgressEvent, PlayProgressState> {
  PlayProgressBloc()
      : super(PlayProgressState(initLeLevel: 1, levelHighestReached: 0)) {
    on<ResetLevelPlayProgressEvent>(_reset);
    on<SetLevelPlayProgressEvent>(_setLevelReached);
  }
  void _reset(ResetLevelPlayProgressEvent event, Emitter emit) {
    emit(
      state.copyWith(
        initLeLevel: 1,
        levelHighestReached: 0,
      ),
    );
  }

  void _setLevelReached(SetLevelPlayProgressEvent event, Emitter emit) {
    emit(state.copyWith(
      levelHighestReached: event.level,
    ));
  }
}
