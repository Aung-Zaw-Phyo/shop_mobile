import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shop_mobile/features/profile/domain/usecases/get_profile.dart';
import 'package:shop_mobile/features/profile/presentation/bloc/profile/profile_event.dart';
import 'package:shop_mobile/features/profile/presentation/bloc/profile/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase _getProfileUseCase;

  ProfileBloc(this._getProfileUseCase) : super(const ProfileLoading()) {
    on<GetProfile>(
      onGetProfile,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  void onGetProfile(GetProfile event, Emitter<ProfileState> emit) async {
    final result = await _getProfileUseCase.execute();
    result.fold((failure) {
      emit(ProfileFailed(failure.messages));
    }, (result) {
      emit(ProfileLoaded(result));
    });
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
