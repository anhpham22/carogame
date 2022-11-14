abstract class PlayProgressEvent {}

class ResetLevelPlayProgressEvent extends PlayProgressEvent {}

class SetLevelPlayProgressEvent extends PlayProgressEvent {
  int level;
  SetLevelPlayProgressEvent({required this.level});
}
