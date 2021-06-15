part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileLoadUser extends ProfileEvent {
  final String userId;
  ProfileLoadUser({
    @required this.userId,
  });

  @override
  List<Object> get props => [userId];
}
