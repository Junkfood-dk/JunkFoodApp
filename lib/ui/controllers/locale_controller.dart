// ignore_for_file: prefer_single_quotes

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:junkfood/data/local_locale_storage_repository.dart';

part 'locale_controller.g.dart';

@riverpod
class LocaleController extends _$LocaleController {
  @override
  Future<Locale?> build() async {
    String? locale;
    var localStorageRepo = ref.watch(localLocaleStorageRepositoryProvider);
    switch (localStorageRepo) {
      case (AsyncData(:final value)):
        locale = value.getLocale('locale');
    }
    return locale != null ? Locale(locale) : null;
  }

  void set(Locale locale) async {
    var localStorageRepo = ref.watch(localLocaleStorageRepositoryProvider);
    switch (localStorageRepo) {
      case (AsyncData(:final value)):
        value.saveLocale(locale.languageCode);
    }

    state = AsyncData(locale);
  }
}
