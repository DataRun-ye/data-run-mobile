// party_dao.dart

import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/tables/parties.table.dart';
import 'package:drift/drift.dart';

part 'party_dao.g.dart';

@DriftAccessor(tables: [Parties])
class PartyDao extends DatabaseAccessor<AppDatabase> with _$PartyDaoMixin {
  PartyDao(AppDatabase db) : super(db);

  // ---------- helpers ----------
  /// Build "(:p0,:p1,...)" placeholders and a list of Variable objects for Drift.
  /// Returns pair: (placeholdersString, variablesList)
  MapEntry<String, List<Variable>> _buildInClauseAndVariables(
      List<String> items, String varPrefix) {
    if (items.isEmpty) return MapEntry('()', <Variable>[]);
    final placeholders = <String>[];
    final vars = <Variable>[];
    for (var i = 0; i < items.length; i++) {
      placeholders.add(':${varPrefix}_$i');
      vars.add(Variable.withString(items[i]));
    }
    return MapEntry('(${placeholders.join(',')})', vars);
  }

  /// Map a QueryRow to map
  Map<String, dynamic> _rowToMap(QueryRow row) =>
      Map<String, dynamic>.from(row.data);

  // ---------- A: findBindings ----------
  /// returns list of binding rows with precedence column
  Future<List<Map<String, dynamic>>> findBindings({
    required String assignmentId,
    String? templateUid,
    required String roleName,
    String? userId,
    List<String> principalIds = const [],
    List<String> userRoles = const [],
  }) async {
    // Build IN clauses for principalIds and userRoles
    final principalIn = _buildInClauseAndVariables(principalIds, 'p');
    final roleIn = _buildInClauseAndVariables(userRoles, 'r');

    final sql = StringBuffer()..write('''
        SELECT b.*,
               CASE
                 WHEN b.principal_id = :userId THEN 0
                 WHEN b.principal_id IN ${principalIn.key} THEN 1
                 WHEN b.principal_role IS NOT NULL AND b.principal_role IN ${roleIn.key} THEN 2
                 ELSE 3
               END AS precedence
        FROM assignment_party_binding b
        WHERE b.assignment_id = :assignmentId
          AND b.name = :roleName
          AND (:templateUid IS NULL OR b.vocabulary_id IS NULL OR b.vocabulary_id = (SELECT id FROM data_template WHERE uid = :templateUid))
        ORDER BY precedence, b.created_at ASC
      ''');

    final variables = <Variable>[
      Variable.withString(assignmentId),
      Variable.withString(roleName),
      Variable.withString(userId ?? ''),
      Variable.withString(templateUid ?? ''),
    ];
    // Drift customSelect only takes List<Variable> matched to named tokens in SQL.
    // We'll provide the named variables as a map below via `substitutionValues` where available.
    // To keep it straightforward, we will pass variables in `variables:` and use the same order
    // as Drift substitutes named params — but Drift expects explicit Variable.with... for each named param.
    // So build a variables map of common params, then append IN variables.
    final namedVars = <String, Variable>{
      'assignmentId': Variable.withString(assignmentId),
      'roleName': Variable.withString(roleName),
      'userId': Variable.withString(userId ?? ''),
      'templateUid': Variable.withString(templateUid ?? ''),
    };

    // Add IN variables
    for (var i = 0; i < principalIds.length; i++) {
      namedVars['p_$i'] = Variable.withString(principalIds[i]);
    }
    for (var i = 0; i < userRoles.length; i++) {
      namedVars['r_$i'] = Variable.withString(userRoles[i]);
    }

    final res = await db
        .customSelect(sql.toString(), variables: namedVars.values.toList())
        .get();
    return res.map(_rowToMap).toList();
  }

  // ---------- B: getPartySetMembers ----------
  Future<List<Map<String, dynamic>>> getPartySetMembers({
    required String partySetId,
    String? q,
    required int limit,
    required int offset,
  }) async {
    final sql = '''
      SELECT p.*
      FROM party_set_member m
      JOIN party p ON p.id = m.party_id
      WHERE m.party_set_id = :partySetId
        AND (:q IS NULL OR p.name ILIKE '%' || :q || '%')
      ORDER BY p.name
      LIMIT :limit OFFSET :offset;
    ''';

    final rows = await db.customSelect(
      sql,
      variables: [
        Variable.withString(partySetId),
        Variable.withString(q ?? ''),
        Variable.withInt(limit),
        Variable.withInt(offset),
      ],
    ).get();

    return rows.map(_rowToMap).toList();
  }

  // ---------- C: resolvePartiesByTags (dynamic JOINs) ----------
  /// tagFilters: list of maps: [{'key':'assigned_to_team','value':'TEAM_A'}, ...]
  Future<List<Map<String, dynamic>>> resolvePartiesByTags({
    required List<Map<String, String>> tagFilters,
    String? q,
    String? type,
    required int limit,
    required int offset,
  }) async {
    // Build dynamic JOINs for N tags
    final sb = StringBuffer();
    sb.write('SELECT p.* FROM party p ');
    final variables = <Variable>[];
    for (var i = 0; i < tagFilters.length; i++) {
      final alias = 'pt$i';
      sb.write(
          ' JOIN party_tag $alias ON $alias.party_id = p.id AND $alias.tag_key = :tk$i AND $alias.tag_value = :tv$i ');
      variables.add(Variable.withString(tagFilters[i]['key']!));
      variables.add(Variable.withString(tagFilters[i]['value']!));
    }
    sb.write(' WHERE 1=1 ');
    // q
    if (q != null && q.isNotEmpty) {
      sb.write(" AND p.name ILIKE '%' || :q || '%' ");
      variables.add(Variable.withString(q));
    } else {
      // still add placeholder (empty)
      sb.write(' ');
      variables.add(Variable.withString(''));
    }
    // type
    if (type != null && type.isNotEmpty) {
      sb.write(' AND p.type = :type ');
      variables.add(Variable.withString(type));
    } else {
      variables.add(Variable.withString(''));
    }

    sb.write(' ORDER BY p.name LIMIT :limit OFFSET :offset;');
    variables.add(Variable.withInt(limit));
    variables.add(Variable.withInt(offset));

    final rows =
        await db.customSelect(sb.toString(), variables: variables).get();
    return rows.map(_rowToMap).toList();
  }

  // ---------- D: getOrgTreeMembers (simple stub) ----------
  Future<List<Map<String, dynamic>>> getOrgTreeMembers({
    required String partySetId,
    required int limit,
    required int offset,
  }) async {
    // Implementation depends on how you store ORG_TREE spec (rootId, depth).
    // This stub assumes you materialized the tree members into party_set_member for ORG_TREE.
    final sql = '''
      SELECT p.* FROM party_set_member m
      JOIN party p ON p.id = m.party_id
      WHERE m.party_set_id = :partySetId
      ORDER BY p.name
      LIMIT :limit OFFSET :offset;
    ''';
    final rows = await db.customSelect(sql, variables: [
      Variable.withString(partySetId),
      Variable.withInt(limit),
      Variable.withInt(offset),
    ]).get();
    return rows.map(_rowToMap).toList();
  }

  // ---------- E: getPartiesByIds ----------
  Future<List<Map<String, dynamic>>> getPartiesByIds(List<String> ids,
      {String? q, required int limit, required int offset}) async {
    if (ids.isEmpty) return [];
    final inClause = _buildInClauseAndVariables(ids, 'id');
    final sql = '''
      SELECT p.*
      FROM party p
      WHERE p.id IN ${inClause.key}
        AND (:q IS NULL OR p.name ILIKE '%' || :q || '%')
      ORDER BY p.name
      LIMIT :limit OFFSET :offset;
    ''';
    // combine variables: inClause.vars + q + limit + offset
    final vars = <Variable>[];
    vars.addAll(inClause.value);
    vars.add(Variable.withString(q ?? ''));
    vars.add(Variable.withInt(limit));
    vars.add(Variable.withInt(offset));

    final rows = await db.customSelect(sql, variables: vars).get();
    return rows.map(_rowToMap).toList();
  }

  // ---------- F: getAssignmentMemberRoles ----------
  Future<List<Map<String, dynamic>>> getAssignmentMemberRoles({
    required String assignmentId,
    List<String> principalIds = const [],
  }) async {
    final inClause = _buildInClauseAndVariables(principalIds, 'pr');
    final sql = '''
      SELECT am.member_type, am.member_id, am.role
      FROM assignment_member am
      WHERE am.assignment_id = :assignmentId
        AND (am.member_id IN ${inClause.key})
    ''';
    final vars = <Variable>[
      Variable.withString(assignmentId),
      ...inClause.value
    ];
    final rows = await db.customSelect(sql, variables: vars).get();
    return rows.map(_rowToMap).toList();
  }
}
