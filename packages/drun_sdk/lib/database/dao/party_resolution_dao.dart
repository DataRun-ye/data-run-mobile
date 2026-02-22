import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/tables/assignment_party_bindings.table.dart';
import 'package:drift/drift.dart';

part 'party_resolution_dao.g.dart';

@DriftAccessor(tables: [AssignmentPartyBindings])
class PartyResolutionDao extends DatabaseAccessor<AppDatabase>
    with _$PartyResolutionDaoMixin {
  PartyResolutionDao(AppDatabase db) : super(db);

  /// Resolves the effective PartySet IDs based on the binding precedence rules.
  ///
  /// This method mimics the backend's BindingResolver logic.
  ///
  /// - [assignmentId]: The current assignment context.
  /// - [vocabularyId]: The current form/template ID (optional).
  /// - [roleName]: The role being resolved (e.g., "sender").
  /// - [principalIds]: A set of all IDs for the current user (user ID, team IDs, etc.).
  ///
  /// Returns a list of PartySet IDs to be used for resolution.
  Future<List<String>> resolveEffectivePartySetIds({
    required String assignmentId,
    String? vocabularyId,
    required String roleName,
    required Set<String> principalIds,
  }) async {
    // --- Precedence Level 1: Principal-Scoped Bindings ---
    // First, look for bindings specific to the user's principals (user, teams, groups)
    final principalScopedQuery = select(assignmentPartyBindings)
      ..where((b) =>
      b.assignmentId.equals(assignmentId) &
      b.roleName.equals(roleName) &
      b.principalId.isIn(principalIds));

    final List<AssignmentPartyBinding> principalBindings = await principalScopedQuery.get();

    if (principalBindings.isNotEmpty) {
      // If we found principal-scoped bindings, we must determine if any are
      // vocabulary-specific, as those take higher precedence.
      final vocabSpecificPrincipal = principalBindings
          .where((b) => b.vocabularyId == vocabularyId)
          .toList();

      if (vocabSpecificPrincipal.isNotEmpty) {
        return vocabSpecificPrincipal.map((b) => b.partySetId).toList(); // Highest precedence met
      }

      // If no vocab-specific ones, return the global-for-assignment principal bindings
      return principalBindings
          .where((b) => b.vocabularyId == null)
          .map((b) => b.partySetId)
          .toList();
    }


    // --- Precedence Level 2: Assignment-Global Bindings ---
    // If no principal-scoped bindings were found, look for global ones.
    final globalQuery = select(assignmentPartyBindings)
      ..where((b) =>
      b.assignmentId.equals(assignmentId) &
      b.roleName.equals(roleName) &
      b.principalId.isNull());

    final globalBindings = await globalQuery.get();

    if (globalBindings.isNotEmpty) {
      final vocabSpecificGlobal = globalBindings
          .where((b) => b.vocabularyId == vocabularyId)
          .toList();

      if (vocabSpecificGlobal.isNotEmpty) {
        return vocabSpecificGlobal.map((b) => b.partySetId).toList();
      }

      return globalBindings
          .where((b) => b.vocabularyId == null)
          .map((b) => b.partySetId)
          .toList();
    }

    // --- Precedence Levels 3 & 4 (Template/Assignment default) ---
    // This logic is often handled by ensuring the sync process always creates
    // an explicit binding. If not, we could add lookups here for the
    // template's defaultPartySetId or the assignment's defaultPartySetId.
    // For now, we assume explicit bindings cover these cases.

    return []; // No bindings found
  }
}