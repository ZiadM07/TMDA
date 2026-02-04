import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tmda/features/search/domain/entities/search_result.dart';

import '../../../../core/state/app_state.dart';
import '../../../../core/utils/enums.dart';
import '../../domain/usecases/search_usecase.dart';

@injectable
class SearchCubit extends Cubit<AppState<SearchState>> {
  final SearchUsecase _search;

  Timer? _debounce;

  SearchCubit(this._search)
    : super(AppState(status: StateStatus.initial, data: SearchState.initial()));

  // ============================
  // SEARCH (DEBOUNCED)
  // ============================
  void search(String query) {
    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 400), () {
      _performSearch(query);
    });
  }

  Future<void> _performSearch(String query) async {
    if (query.trim().isEmpty) {
      clear();
      return;
    }

    emit(
      state.copyWith(
        status: StateStatus.loading,
        data: SearchState.initial().copyWith(query: query),
      ),
    );

    try {
      final result = await _search(query: query, page: 1);

      emit(
        state.copyWith(
          status: StateStatus.success,
          data: state.data!.copyWith(
            query: query,
            result: result,
            page: 1,
            isLoadingMore: false,
          ),
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: StateStatus.error, message: e.toString()));
    }
  }

  // ============================
  // FILTER
  // ============================
  void changeFilter(SearchFilter filter) {
    emit(
      state.copyWith(
        status: StateStatus.success,
        data: state.data?.copyWith(filter: filter),
      ),
    );
  }

  // ============================
  // PAGINATION
  // ============================
  Future<void> loadMore() async {
    final current = state.data;
    if (current == null || current.isLoadingMore || current.query.isEmpty) {
      return;
    }

    emit(
      state.copyWith(
        status: StateStatus.loadingOverlay,
        data: current.copyWith(isLoadingMore: true),
      ),
    );

    try {
      final nextPage = current.page + 1;
      final result = await _search(query: current.query, page: nextPage);

      emit(
        state.copyWith(
          status: StateStatus.success,
          data: current.copyWith(
            page: nextPage,
            isLoadingMore: false,
            result: current.result.copyWith(
              movies: [...current.result.movies, ...result.movies],
              tvShows: [...current.result.tvShows, ...result.tvShows],
              people: [...current.result.people, ...result.people],
            ),
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: StateStatus.error,
          message: e.toString(),
          data: current.copyWith(isLoadingMore: false),
        ),
      );
    }
  }

  // ============================
  // CLEAR
  // ============================
  void clear() {
    _debounce?.cancel();
    emit(
      state.copyWith(status: StateStatus.success, data: SearchState.initial()),
    );
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}

// ============================
// STATE
// ============================

class SearchState {
  final String query;
  final SearchResult result;
  final bool isLoadingMore;
  final int page;
  final SearchFilter filter;
  final bool isListening;

  const SearchState({
    required this.query,
    required this.result,
    required this.isLoadingMore,
    required this.page,
    required this.filter,
    required this.isListening,
  });

  factory SearchState.initial() => SearchState(
    query: '',
    result: SearchResult.empty(),
    isLoadingMore: false,
    page: 1,
    filter: SearchFilter.movies,
    isListening: false,
  );

  SearchState copyWith({
    String? query,
    SearchResult? result,
    bool? isLoadingMore,
    int? page,
    SearchFilter? filter,
    bool? isListening,
  }) {
    return SearchState(
      query: query ?? this.query,
      result: result ?? this.result,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      page: page ?? this.page,
      filter: filter ?? this.filter,
      isListening: isListening ?? this.isListening,
    );
  }
}
