part of 'user_profile_bloc.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => <Object>[];
}

final class UserProfileStarted extends UserProfileEvent {
  const UserProfileStarted();

  @override
  List<Object> get props => <Object>[];
}
