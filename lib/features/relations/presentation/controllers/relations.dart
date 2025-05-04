import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/core/controllers/controller.dart';
import 'package:test_app/core/utils/providers.dart';
import 'package:test_app/features/relations/data/models/relation.dart';
import 'package:test_app/features/relations/data/models/relation_type.dart';
import 'package:test_app/features/relations/data/source/realtions_remote_source.dart';
import 'package:test_app/features/relations/presentation/events/RelationUpdated.dart';

class RelationControllerArg extends Equatable {
  final String person;
  final RelationType relationType;

  const RelationControllerArg(this.person, this.relationType);

  @override
  List<Object?> get props => [person, relationType];
}

class RelationsController extends Controller<List<Relation>> {
  static var provider = StateNotifierProvider.autoDispose.family((
    ref,
    RelationControllerArg args,
  ) {
    return RelationsController(
      args,
      ref.watch(RelationsRemoteSource.provider),
      ref.watch(AppProviders.eventBus),
    );
  });

  final RelationControllerArg _args;
  final RelationsRemoteSource _relationsRemoteSource;
  final EventBus _eventBus;
  late final StreamSubscription _sub;

  RelationsController(this._args, this._relationsRemoteSource, this._eventBus)
    : super() {
    _sub = _eventBus.on<RelationUpdated>().listen(_onUpdateEvent);
  }

  @override
  dispose() {
    super.dispose();
    _sub.cancel();
  }

  Future<void> loadRelations() async {
    await fetch(
      fetchOperation: _relationsRemoteSource.getRelations(
        _args.person,
        _args.relationType,
      ),
    );
  }

  Future<void> add(Relation relation, RelationType from) async {
    if (!state.isLoaded) return;
    state = state.updateData([...state.data!, relation]);
    _eventBus.fire(
      RelationUpdated(relation: relation, from: from, to: _args.relationType),
    );
    await operate(
      operation: _relationsRemoteSource.updateRelation(
        relation,
        _args.relationType,
      ),
      onFailure: () {
        if (state.isLoaded) {
          var data = [...state.data!];
          data.remove(relation);
          state = state.updateData(data);
        }
        _eventBus.fire(
          RelationUpdated(
            relation: relation,
            from: _args.relationType,
            to: from,
          ),
        );
      },
    );
  }

  void _onUpdateEvent(RelationUpdated event) {
    if (event.from == _args.relationType) {
      var data = [...state.data!];
      data.remove(event.relation);
      state = state.updateData(data);
    }
  }
}
