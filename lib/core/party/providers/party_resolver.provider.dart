import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/dao/dao.dart';
import 'package:d_sdk/database/database.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:d_sdk/database/tables/tables.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'party_resolver.provider.g.dart';

@riverpod
class PartyResolver extends _$PartyResolver {
  // A helper method to get the DAO.
  // If you use get_it/injectable, this is a clean way to fetch it.
  PartyResolutionDao get _partyResolutionDao => DSdk.db.partyResolutionDao;

  // You will also need DAOs for Parties, PartySets, etc.
  // Example: PartiesDao get _partiesDao => getIt<AppDatabase>().partiesDao;

  @override
  Future<List<Party>> build(PartyResolutionParams params) async {
    // This build method is called automatically when the provider is first used
    // or when its parameters change.

    // 1. Get current user's principals (user ID, team IDs).
    // This would typically come from a session/auth provider.
    // For now, let's assume we have a function to get them.
    final currentUserPrincipals = await _getCurrentUserPrincipals();

    // 2. Resolve the effective PartySet IDs using our DAO.
    final partySetIds = await _partyResolutionDao.resolveEffectivePartySetIds(
      assignmentId: params.assignmentId,
      vocabularyId: params.vocabularyId,
      roleName: params.roleName,
      principalIds: currentUserPrincipals,
    );

    if (partySetIds.isEmpty) {
      return []; // No rules found, return empty list.
    }

    // 3. Expand the PartySets to get the actual Party IDs.
    // This is a simplified expansion. A full implementation would check the PartySet 'kind'.
    // For now, we'll assume STATIC sets.
    final partyIds = await _expandStaticPartySets(partySetIds);

    if (partyIds.isEmpty) {
      return [];
    }

    // 4. Fetch the final Party objects, applying security and search filters.
    // This single query is the final step.
    final finalParties = await _getFilteredParties(
        partyIds: partyIds,
        userId: _getCurrentUserId(),
        // Assume a function to get current user's ID
        searchQuery: params.searchQuery);

    return finalParties;
  }

  // Helper method to simulate getting user principals
  Future<Set<String>> _getCurrentUserPrincipals() async {
    // In a real app, this would query a session service or auth provider.
    // final session = ref.watch(sessionProvider);
    // return {session.user.id, ...session.user.teamIds};
    return {'user-id-123', 'team-id-abc'}; // Placeholder
  }

  String _getCurrentUserId() {
    return 'user-id-123'; // Placeholder
  }

  // Helper for step 3
  Future<Set<String>> _expandStaticPartySets(List<String> partySetIds) async {
    // final members = await (db.select(db.partySetMembers)..where((m) => m.partySetId.isIn(partySetIds))).get();
    // return members.map((m) => m.partyId).toSet();
    return {
      'party-uuid-001',
      'party-uuid-002',
      'party-uuid-003'
    }; // Placeholder
  }

  // Helper for step 4
  Future<List<Party>> _getFilteredParties(
      {required Set<String> partyIds,
      required String userId,
      String? searchQuery}) async {
    // This translates to a single, efficient query:
    // SELECT p.* FROM parties p
    // JOIN user_allowed_party uap ON p.id = uap.party_id
    // WHERE uap.user_id = ? AND p.id IN (...) AND p.name LIKE ?
    // ORDER BY p.name ASC;

    // final query = db.select(db.parties).join([...]);
    // query.where(...);
    // return await query.get();

    // Placeholder implementation
    final allParties = [
      Party(
        id: 'party-uuid-001',
        uid: 'party-uid-001',
        name: 'Warehouse A',
        type: PartyType.INTERNAL,
        sourceType: SourceType.ORG_UNIT,
        translations: [],
        sourceId: 'Warehouse A',
      ),
      Party(
        id: 'party-uuid-002',
        uid: 'party-uid-002',
        name: 'Warehouse B',
        type: PartyType.INTERNAL,
        sourceType: SourceType.ORG_UNIT,
        translations: [],
        sourceId: 'Warehouse B',
      ),
    ];

    if (searchQuery != null && searchQuery.isNotEmpty) {
      return allParties
          .where(
              (p) => p.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
    return allParties;
  }
}
