// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receivable_form_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension ReceivableFormStateStatusMatch on ReceivableFormStateStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loaded,
      required T Function() register,
      required T Function() success,
      required T Function() deletedSuccess,
      required T Function() error}) {
    final v = this;
    if (v == ReceivableFormStateStatus.initial) {
      return initial();
    }

    if (v == ReceivableFormStateStatus.loaded) {
      return loaded();
    }

    if (v == ReceivableFormStateStatus.register) {
      return register();
    }

    if (v == ReceivableFormStateStatus.success) {
      return success();
    }

    if (v == ReceivableFormStateStatus.deletedSuccess) {
      return deletedSuccess();
    }

    if (v == ReceivableFormStateStatus.error) {
      return error();
    }

    throw Exception(
        'ReceivableFormStateStatus.match failed, found no match for: $this');
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
    if (v == ReceivableFormStateStatus.initial && initial != null) {
      return initial();
    }

    if (v == ReceivableFormStateStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == ReceivableFormStateStatus.register && register != null) {
      return register();
    }

    if (v == ReceivableFormStateStatus.success && success != null) {
      return success();
    }

    if (v == ReceivableFormStateStatus.deletedSuccess &&
        deletedSuccess != null) {
      return deletedSuccess();
    }

    if (v == ReceivableFormStateStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
