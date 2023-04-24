// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people_list_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension PeopleListStateStatusMatch on PeopleListStateStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() error}) {
    final v = this;
    if (v == PeopleListStateStatus.initial) {
      return initial();
    }

    if (v == PeopleListStateStatus.loading) {
      return loading();
    }

    if (v == PeopleListStateStatus.loaded) {
      return loaded();
    }

    if (v == PeopleListStateStatus.error) {
      return error();
    }

    throw Exception(
        'PeopleListStateStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? error}) {
    final v = this;
    if (v == PeopleListStateStatus.initial && initial != null) {
      return initial();
    }

    if (v == PeopleListStateStatus.loading && loading != null) {
      return loading();
    }

    if (v == PeopleListStateStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == PeopleListStateStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
