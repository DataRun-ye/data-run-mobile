import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_org_units.provider.g.dart';

@riverpod
Future<List<OrgUnit>> userOrgUnits(Ref ref, String activity) {
  final db = DSdk.db;
  final path = db.managers.orgUnits.computedField((a) => a.path);
  return DSdk.db.managers.orgUnits
      .filter((f) => f.ouAssignments((a) => a.activity.id(activity)))
      .get();
}
