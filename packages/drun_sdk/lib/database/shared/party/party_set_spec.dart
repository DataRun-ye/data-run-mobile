import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class PartySetSpec with EquatableMixin {
  /// For `ORG_TREE`
  final String rootId;

  /// nullable For `ORG_TREE`
  final int? depth;

  /// For `ORG_TREE`
  final bool includeSelf;

  /// For `TAG_FILTER`
  final IList<String> tags;

  /// `ORG_UNIT`, `TEAM`, `USER`. Nullable For Specific `TAG_FILTER`
  final IList<String> types;

  /// For `QUERY`
  final String sqlKey;

  /// For `QUERY`
  final IMap<String, dynamic> params;

  PartySetSpec({
    required this.rootId,
    this.depth,
    required this.sqlKey,
    bool? includeSelf,
    List<String>? tags,
    List<String>? types,
    Map<String, dynamic>? params,
  })  : this.includeSelf = includeSelf ?? false,
        this.tags = IList.orNull(tags) ?? const IList<String>.empty(),
        this.types = IList.orNull(types) ?? const IList<String>.empty(),
        this.params =
            IMap.orNull(params) ?? const IMap<String, dynamic>.empty();

  @override
  List<Object?> get props =>
      [rootId, depth, includeSelf, tags, types, sqlKey, params];

  Map<String, dynamic> toJson() {
    return {
      'rootId': this.rootId,
      'depth': this.depth,
      'includeSelf': this.includeSelf,
      'tags': jsonEncode(tags.unlockView),
      'types': jsonEncode(types.unlockView),
      'sqlKey': this.sqlKey,
      'params': jsonEncode(params.unlock),
    };
  }

  factory PartySetSpec.fromJson(Map<String, dynamic> json) {
    // final valueType = ValueType.getValueType(json['type']);
    final tags = json['tags'] != null
        ? json['tags'].runtimeType == String
            ? jsonDecode(json['tags']).cast<String>()
            : json['tags'].cast<String>()
        : null;

    final types = json['types'] != null
        ? json['types'].runtimeType == String
            ? jsonDecode(json['types']).cast<String>()
            : json['types'].cast<String>()
        : null;

    final params = json['params'] != null
        ? Map<String, dynamic>.from(json['params'] is String
            ? jsonDecode(json['params'])
            : json['params'])
        : <String, dynamic>{};

    return PartySetSpec(
      rootId: json['rootId'],
      depth: json['depth'],
      includeSelf: json['includeSelf'] ?? false,
      tags: tags,
      types: types,
      sqlKey: json['sqlKey'],
      params: params,
    );
  }
}
