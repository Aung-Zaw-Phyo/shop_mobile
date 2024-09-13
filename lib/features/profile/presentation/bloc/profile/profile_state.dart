import 'package:equatable/equatable.dart';
import 'package:shop_mobile/features/profile/domain/entities/profile.dart';

class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileState {
  final ProfileEntity profile;
  const ProfileLoaded(this.profile);

  @override
  List<Object> get props => [profile];
}

class ProfileFailed extends ProfileState {
  final List<String> errors;
  const ProfileFailed(this.errors);

  @override
  List<Object> get props => [errors];
}
