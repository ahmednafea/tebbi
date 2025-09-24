part of 'user_profile_bloc.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => <Object>[];
}

class UserProfileInitial extends UserProfileState {
  const UserProfileInitial();
}

class UserProfileLoading extends UserProfileState {
  const UserProfileLoading();
}

class UserProfileSuccess extends UserProfileState {
  final ProfileDataResponse data;
  const UserProfileSuccess({required this.data});
}

class UserProfileFailure extends UserProfileState {
  const UserProfileFailure();
}
