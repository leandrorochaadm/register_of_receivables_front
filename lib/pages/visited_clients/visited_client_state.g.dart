// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visited_client_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension VisitedClientStateStatusMatch on VisitedClientStateStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() error}) {
    final v = this;
    if (v == VisitedClientStateStatus.initial) {
      return initial();
    }

    if (v == VisitedClientStateStatus.loading) {
      return loading();
    }

    if (v == VisitedClientStateStatus.loaded) {
      return loaded();
    }

    if (v == VisitedClientStateStatus.error) {
      return error();
    }

    throw Exception(
        'VisitedClientStateStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? error}) {
    final v = this;
    if (v == VisitedClientStateStatus.initial && initial != null) {
      return initial();
    }

    if (v == VisitedClientStateStatus.loading && loading != null) {
      return loading();
    }

    if (v == VisitedClientStateStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == VisitedClientStateStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
