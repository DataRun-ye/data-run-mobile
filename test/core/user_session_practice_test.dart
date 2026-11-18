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

  test('practice lasts until midnight of the day it began', () {
    final practice = session.asPractice(DateTime(2026, 11, 20, 9, 30));

    expect(practice.practiceDayIsOver(DateTime(2026, 11, 20, 23, 59)), isFalse);
    expect(practice.practiceDayIsOver(DateTime(2026, 11, 21, 0, 1)), isTrue);
    expect(practice.practiceDayIsOver(DateTime(2026, 11, 19, 12)), isTrue,
        reason: 'a clock set back is not the day practice began');
    expect(session.practiceDayIsOver(DateTime(2026, 12, 1)), isFalse,
        reason: 'a real session never ends this way');
  });

  test('the practice start survives a restart; without one practice is over',
      () {
    final began = DateTime(2026, 11, 20, 9, 30);
    final restored =
        UserSession.fromJsonString(session.asPractice(began).toJsonString());
    final undated = UserSession.fromJson(
      session.asPractice(began).toJson()..remove('practiceStartedAt'),
    );

    expect(restored.practiceStartedAt, began.toUtc());
    expect(restored.practiceDayIsOver(DateTime(2026, 11, 20, 18)), isFalse);
    expect(undated.practiceDayIsOver(DateTime(2026, 11, 20, 18)), isTrue);
  });
}
