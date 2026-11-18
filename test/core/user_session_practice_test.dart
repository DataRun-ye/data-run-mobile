import 'package:datarunmobile/core/user_session/user_session.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const session = UserSession(
    id: 'user-1',
    username: 'field-user',
    activated: true,
    authorities: ['ROLE_USER'],
    activityUIDs: ['activity-1'],
    userTeamsUIDs: ['team-1'],
    managedTeamsUIDs: [],
    userGroupsUIDs: [],
    userFormsUIDs: ['form-1'],
  );

  test('a real session keeps its data under the username', () {
    expect(session.practice, isFalse);
    expect(session.localId, 'field-user');
  });

  test('a practice session uses the same account with its own local key', () {
    final practice = session.asPractice();

    expect(practice.practice, isTrue);
    expect(practice.username, 'field-user');
    expect(practice.localId, 'field-user${UserSession.practiceSuffix}');
    expect(practice.userTeamsUIDs, ['team-1']);
  });

  test('the practice flag survives a restart', () {
    final restored =
        UserSession.fromJsonString(session.asPractice().toJsonString());
    final legacy = UserSession.fromJson(
      session.toJson()..remove('practice'),
    );

    expect(restored.practice, isTrue);
    expect(restored.localId, 'field-user${UserSession.practiceSuffix}');
    expect(legacy.practice, isFalse);
  });
}
