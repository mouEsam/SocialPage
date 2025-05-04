import 'package:test_app/features/relations/data/models/relation.dart';
import 'package:test_app/features/relations/data/models/relation_type.dart';

class RelationUpdated {
  final Relation relation;
  final RelationType from;
  final RelationType to;

  const RelationUpdated({
    required this.relation,
    required this.from,
    required this.to,
  });
}
