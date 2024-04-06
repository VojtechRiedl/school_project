import 'package:band_app/features/plans/data/models/plan_update.dart';
import 'package:band_app/features/song/data/models/song_update.dart';
import 'package:band_app/features/user/data/models/user_update.dart';
import 'package:equatable/equatable.dart';

class UpdateSongParams extends Equatable {
  final int id;
  final SongUpdateModel song;

  const UpdateSongParams({required this.id, required this.song});
  @override
  List<Object?> get props => [song, id];
}


class UpdateUserParams extends Equatable {
  final int id;
  final UserUpdateModel userUpdate;

  const UpdateUserParams({required this.id, required this.userUpdate});
  @override
  List<Object?> get props => [userUpdate, id];
}

class UpdatePlanParams extends Equatable {
  final int id;
  final PlanUpdateModel planUpdate;

  const UpdatePlanParams({required this.id, required this.planUpdate});
  @override
  List<Object?> get props => [planUpdate, id];
}