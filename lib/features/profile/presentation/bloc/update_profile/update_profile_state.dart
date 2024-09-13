import 'package:equatable/equatable.dart';
import 'package:shop_mobile/features/profile/domain/entities/profile.dart';

class UpdateProfileState extends Equatable {
  const UpdateProfileState();

  @override
  List<Object> get props => [];
}

class UpdateProfileInitial extends UpdateProfileState {
  const UpdateProfileInitial();
}

class UpdateProfileLoading extends UpdateProfileState {
  const UpdateProfileLoading();
}

class UpdateProfileLoaded extends UpdateProfileState {
  final ProfileEntity profile;
  const UpdateProfileLoaded(this.profile);

  @override
  List<Object> get props => [profile];
}

class UpdateProfileFailed extends UpdateProfileState {
  final List<String> errors;
  const UpdateProfileFailed(this.errors);

  @override
  List<Object> get props => [errors];
}
