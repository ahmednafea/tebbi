part of 'update_user_profile_bloc.dart';

abstract class UpdateUserProfileState extends Equatable {
  const UpdateUserProfileState();

  @override
  List<Object> get props => <Object>[];
}

class UpdateUserProfileInitial extends UpdateUserProfileState {
  const UpdateUserProfileInitial();
}

class UpdateUserProfileLoading extends UpdateUserProfileState {
  const UpdateUserProfileLoading();
}

class UpdateUserProfileSuccess extends UpdateUserProfileState {
  final ProfileDataResponse data;
  const UpdateUserProfileSuccess({required this.data});
}

class UserProfileFailure extends UpdateUserProfileState {
  const UserProfileFailure();
}
