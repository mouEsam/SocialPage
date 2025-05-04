import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/core/controllers/controller.dart';
import 'package:test_app/features/common/data/models/person.dart';
import 'package:test_app/features/common/data/source/people_remote_source.dart';

class PeopleController extends Controller<List<Person>> {
  static var provider = StateNotifierProvider.autoDispose((ref) {
    return PeopleController(ref.watch(PeopleRemoteSource.provider));
  });

  static var selectedPersonProvider = Provider.autoDispose((ref) {
    var controller = ref.watch(provider.notifier);
    listener() {
      ref.state = controller.selectedPerson.value;
    }

    controller.selectedPerson.addListener(listener);
    ref.onDispose(() {
      controller.selectedPerson.removeListener(listener);
    });
    return controller.selectedPerson.value;
  });

  final PeopleRemoteSource _peopleRemoteSource;
  final ValueNotifier<Person?> _selectedPerson = ValueNotifier(null);

  ValueListenable<Person?> get selectedPerson => _selectedPerson;

  PeopleController(this._peopleRemoteSource) : super();

  @override
  void dispose() {
    super.dispose();
    _selectedPerson.dispose();
  }

  Future<void> loadPeople() async {
    await fetch(fetchOperation: _peopleRemoteSource.getPeople());
    if (state.data?.contains(_selectedPerson.value) == false) {
      _selectedPerson.value = null;
    }
  }

  void select(Person person) {
    if (state.data?.contains(person) == true &&
        _selectedPerson.value != person) {
      _selectedPerson.value = person;
    }
  }
}
