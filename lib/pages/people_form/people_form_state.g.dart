// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people_form_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension PeopleFormStateStatusMatch on PeopleFormStateStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loaded,
      required T Function() register,
      required T Function() success,
      required T Function() deletedSuccess,
      required T Function() error}) {
    final v = this;
    if (v == PeopleFormStateStatus.initial) {
      return initial();
    }

    if (v == PeopleFormStateStatus.loaded) {
      return loaded();
    }

    if (v == PeopleFormStateStatus.register) {
      return register();
    }

    if (v == PeopleFormStateStatus.success) {
      return success();
    }

    if (v == PeopleFormStateStatus.deletedSuccess) {
      return deletedSuccess();
    }

    if (v == PeopleFormStateStatus.error) {
      return error();
    }

    throw Exception(
        'PeopleFormStateStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loaded,
      T Function()? register,
      T Function()? success,
      T Function()? deletedSuccess,
      T Function()? error}) {
    final v = this;
    if (v == PeopleFormStateStatus.initial && initial != null) {
      return initial();
    }

    if (v == PeopleFormStateStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == PeopleFormStateStatus.register && register != null) {
      return register();
    }

    if (v == PeopleFormStateStatus.success && success != null) {
      return success();
    }

    if (v == PeopleFormStateStatus.deletedSuccess && deletedSuccess != null) {
      return deletedSuccess();
    }

    if (v == PeopleFormStateStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
