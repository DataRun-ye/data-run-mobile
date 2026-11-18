import 'dart:io';

import 'package:datarunmobile/core/util/user_file_manager.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Directory appDirectory;

  setUp(() async {
    appDirectory = await Directory.systemTemp.createTemp('user-files-test');
  });

  tearDown(() async {
    if (await appDirectory.exists()) {
      await appDirectory.delete(recursive: true);
    }
  });

  UserFileManager manager(String userId) =>
      UserFileManager(userId, appDirectory: () async => appDirectory);

  test('deletes the files it wrote, such as a session database', () async {
    final practice = manager('worker__practice');
    final database = await practice.getUserFile('datarun_worker__practice.db');
    await database.writeAsString('practice rows');

    expect(await practice.deleteUserFiles(), isTrue);

    expect(await database.exists(), isFalse);
    expect(await database.parent.exists(), isFalse);
  });

  test('deleting one session leaves the other session of the account alone',
      () async {
    final real = await manager('worker').getUserFile('datarun_worker.db');
    await real.writeAsString('real rows');
    final practice = manager('worker__practice');
    await (await practice.getUserFile('datarun_worker__practice.db'))
        .writeAsString('practice rows');

    await practice.deleteUserFiles();

    expect(await real.readAsString(), 'real rows');
  });

  test('reports nothing deleted when the session never stored files', () async {
    expect(await manager('nobody__practice').deleteUserFiles(), isFalse);
  });
}
