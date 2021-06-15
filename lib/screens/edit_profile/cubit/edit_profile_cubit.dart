import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:instagram_clone/models/models.dart';
import 'package:instagram_clone/repositories/repositories.dart';
import 'package:instagram_clone/screens/profile/bloc/profile_bloc.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final UserRepository _userRepository;
  final StorageRepository _storageRepository;
  final ProfileBloc _profileBloc;

  EditProfileCubit({
    @required UserRepository userRepository,
    @required StorageRepository storageRepository,
    @required ProfileBloc profileBloc,
  })  : _userRepository = userRepository,
        _storageRepository = storageRepository,
        _profileBloc = profileBloc,
        super(EditProfileState.initial()) {
    final user = _profileBloc.state.user;
    emit(
      state.copyWith(username: user.username, bio: user.bio),
    );
  }

  void profileImageChanged(File image) {
    emit(
      state.copyWith(
        profileImage: image,
        status: EditProfileStatus.initial,
      ),
    );
  }

  void usernameChanged(String username) {
    emit(
      state.copyWith(
        username: username,
        status: EditProfileStatus.initial,
      ),
    );
  }

  void bioChanged(String bio) {
    emit(
      state.copyWith(
        bio: bio,
        status: EditProfileStatus.initial,
      ),
    );
  }

  void submit() async {
    emit(state.copyWith(status: EditProfileStatus.submitting));
    try {
      final user = _profileBloc.state.user; // initial user

      var profileImageUrl = user.profileImageUrl;
      if (state.profileImage != null) {
        profileImageUrl = await _storageRepository.uploadProfileImage(
          url: profileImageUrl,
          image: state.profileImage,
        );
      }

      final updatedUser = user.copyWith(
        username: state.username,
        bio: state.bio,
        profileImageUrl: profileImageUrl,
      );

      await _userRepository.updateUser(user: updatedUser);

      _profileBloc.add(ProfileLoadUser(userId: user.id));

      emit(
        state.copyWith(status: EditProfileStatus.success),
      );
    } catch (err) {
      emit(
        state.copyWith(
          status: EditProfileStatus.error,
          failure:
              const Failure(message: 'We are unable to update your profile.'),
        ),
      );
    }
  }
}
