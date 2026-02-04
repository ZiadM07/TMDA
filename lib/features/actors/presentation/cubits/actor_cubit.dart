import 'package:tmda/core/constants/exports.dart';
import 'package:tmda/core/state/app_state.dart';
import 'package:tmda/core/utils/enums.dart';
import 'package:tmda/features/actors/domain/entities/actor_credit.dart';
import 'package:tmda/features/actors/domain/entities/actor_details.dart';
import 'package:tmda/features/actors/domain/usecases/get_actor_credits.dart';
import 'package:tmda/features/actors/domain/usecases/get_actor_details.dart';

@injectable
class ActorDetailsCubit extends Cubit<AppState<ActorDetails>> {
  final GetActorDetails _getDetails;
  final GetActorCredits _getCredits;

  ActorDetailsCubit(this._getDetails, this._getCredits)
    : super(const AppState());

  // ===============================
  // LOCAL FEATURE STATE (CACHED)
  // ===============================
  List<ActorCredit> _credits = [];

  List<ActorCredit> get credits => _credits;

  // Optional helpers
  List<ActorCredit> get movieCredits =>
      _credits.where((c) => c.type == ActorCreditType.movie).toList();

  List<ActorCredit> get tvCredits =>
      _credits.where((c) => c.type == ActorCreditType.tv).toList();

  int get totalCredits => _credits.length;

  int get moviesCount =>
      _credits.where((c) => c.type == ActorCreditType.movie).length;

  int get tvShowsCount =>
      _credits.where((c) => c.type == ActorCreditType.tv).length;

  // ===============================
  // LOAD ACTOR
  // ===============================
  Future<void> loadActor(int actorId) async {
    emit(state.copyWith(status: StateStatus.loading));

    try {
      final detailsFuture = _getDetails(actorId);
      final creditsFuture = _getCredits(actorId);

      final details = await detailsFuture;
      _credits = await creditsFuture;

      emit(state.copyWith(status: StateStatus.success, data: details));
    } catch (e) {
      emit(state.copyWith(status: StateStatus.error, message: e.toString()));
    }
  }
}
