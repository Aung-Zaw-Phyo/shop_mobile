import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shop_mobile/features/profile/domain/usecases/update_profile.dart';
import 'package:shop_mobile/features/profile/presentation/bloc/update_profile/update_profile_event.dart';
import 'package:shop_mobile/features/profile/presentation/bloc/update_profile/update_profile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final UpdateProfileUseCase _updateProfileUseCase;

  UpdateProfileBloc(this._updateProfileUseCase)
      : super(const UpdateProfileInitial()) {
    on<UpdateProfile>(
      onUpdateProfile,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  void onUpdateProfile(
    UpdateProfile event,
    Emitter<UpdateProfileState> emit,
  ) async {
    emit(const UpdateProfileLoading());
    final result = await _updateProfileUseCase.execute(
      name: event.name,
      email: event.email,
      image: event.image,
    );
    result.fold((failure) {
      emit(UpdateProfileFailed(failure.messages));
    }, (result) {
      emit(UpdateProfileLoaded(result));
    });
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
