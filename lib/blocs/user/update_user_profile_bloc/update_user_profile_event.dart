part of 'update_user_profile_bloc.dart';

abstract class UpdateUserProfileEvent extends Equatable {
  const UpdateUserProfileEvent();

  @override
  List<Object> get props => <Object>[];
}

final class UpdateUserProfileStarted extends UpdateUserProfileEvent {
  final UpdateProfileRequest request;
  const UpdateUserProfileStarted({required this.request});

  @override
  List<Object> get props => <Object>[request.toJson()];
}
