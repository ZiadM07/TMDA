import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/state/app_state.dart';
import '../../domain/entities/profile.dart';
import '../../domain/usecases/get_profile_usecase.dart';

@injectable
class ProfileCubit extends Cubit<AppState<Profile>> {
  final GetProfileUsecase _getProfile;

  ProfileCubit(this._getProfile)
    : super(const AppState(status: StateStatus.loading));

  Future<void> loadProfile() async {
    emit(state.copyWith(status: StateStatus.loading));
    try {
      final profile = await _getProfile();
      emit(state.copyWith(status: StateStatus.success, data: profile));
    } catch (e) {
      emit(state.copyWith(status: StateStatus.error, message: e.toString()));
    }
  }
}
