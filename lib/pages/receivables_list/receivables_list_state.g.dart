// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receivables_list_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension ReceivablesStateStatusMatch on ReceivablesStateStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() error}) {
    final v = this;
    if (v == ReceivablesStateStatus.initial) {
      return initial();
    }

    if (v == ReceivablesStateStatus.loading) {
      return loading();
    }

    if (v == ReceivablesStateStatus.loaded) {
      return loaded();
    }

    if (v == ReceivablesStateStatus.error) {
      return error();
    }

    throw Exception(
        'ReceivablesStateStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? error}) {
    final v = this;
    if (v == ReceivablesStateStatus.initial && initial != null) {
      return initial();
    }

    if (v == ReceivablesStateStatus.loading && loading != null) {
      return loading();
    }

    if (v == ReceivablesStateStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == ReceivablesStateStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
