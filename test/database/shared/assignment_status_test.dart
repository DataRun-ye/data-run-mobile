import 'package:datarunmobile/database/shared/assignment_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a Progress field offers the server statuses after planning', () {
    // The server's FlowStatus without PLANNED. The ITN form shows a detail
    // section for each of these names (DONE: completion_details, and so on).
    expect(AssignmentStatus.formProgressStatuses.map((s) => s.name), [
      'IN_PROGRESS',
      'DONE',
      'RESCHEDULED',
      'MERGED',
      'REASSIGNED',
      'CANCELLED',
    ]);
  });

  test('a Progress field never offers a status the server lacks', () {
    expect(AssignmentStatus.formProgressStatuses,
        isNot(contains(AssignmentStatus.Expired)));
    expect(AssignmentStatus.formProgressStatuses,
        isNot(anyElement((AssignmentStatus s) => s.isPlanned())));
  });
}
