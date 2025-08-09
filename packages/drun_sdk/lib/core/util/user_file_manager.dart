import 'dart:io';

import 'package:d_sdk/core/exception/d_error_code.dart';
import 'package:d_sdk/core/exception/user_file_exception.dart';
import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

@injectable
class UserFileManager {
  UserFileManager(@factoryParam this.userId);

  final String userId;

  /// Ensures the base 'user_data' directory exists
  Future<Directory> _getBaseUserDirectory() async {
    try {
      // final baseDir = await getApplicationDocumentsDirectory();
      final baseDir = await getApplicationSupportDirectory();
      final userDataDir = Directory(p.join(baseDir.path, 'user_data'));

      if (!await userDataDir.exists()) {
        await userDataDir.create(
            recursive:
                true); // This recursive is for safety, but main goal is userDataDir
        logDebug('Created base user data directory: ${userDataDir.path}');
      } else {
        logDebug(
            'Base user data directory already exists: ${userDataDir.path}');
      }
      return userDataDir;
    } on FileSystemException catch (e, st) {
      logDebug('FileSystemException in _getBaseUserDirectory',
          source: e, stackTrace: st);
      throw UserFileException(
          'Failed to access or create base user data directory. Check permissions or disk space.',
          cause: e,
          stackTrace: st);
    } catch (e, st) {
      logDebug('Unexpected error in _getBaseUserDirectory',
          source: e, stackTrace: st);
      throw UserFileException(
          'An unexpected error occurred accessing base user data directory.',
          cause: e,
          stackTrace: st);
    }
  }

  /// Gets or creates the user-specific directory.
  /// Throws [UserFileException] on failure.
  Future<Directory> _getUserDirectory() async {
    try {
      // First, ensure the base 'user_data' directory exists
      final baseUserDir = await _getBaseUserDirectory();

      // Now, create the user-specific subdirectory within the base directory
      final userDirPath = p.join(baseUserDir.path, userId);
      final userDir = Directory(userDirPath);

      logDebug(
          'Attempting to create user-specific directory: $userDirPath (for user: $userId)');

      if (!await userDir.exists()) {
        // recursive: true is still good here, though less critical now
        // that baseUserDir is guaranteed to exist.
        await userDir.create(recursive: true);
        logDebug(
            'Created user-specific directory: ${userDir.path} for user: $userId');
      } else {
        logDebug(
            'User-specific directory already exists: ${userDir.path} for user: $userId');
      }
      return userDir;
    } on UserFileException {
      rethrow; // Re-throw exceptions from _getBaseUserDirectory
    } on FileSystemException catch (e, st) {
      logDebug('FileSystemException in _getUserDirectory for user: $userId',
          source: e, stackTrace: st);
      throw UserFileException(
          'Failed to access or create user directory for $userId. Check permissions or disk space.',
          cause: e,
          stackTrace: st);
    } catch (e, st) {
      logDebug('Unexpected error in _getUserDirectory for user: $userId',
          source: e, stackTrace: st);
      throw UserFileException(
          'An unexpected error occurred accessing user directory for $userId.',
          cause: e,
          stackTrace: st);
    }
  }

  /// Returns a [File] object for a given filename within the user's directory.
  /// Note: This only creates the [File] object, actual I/O (read/write)
  /// will happen when methods on the [File] object are called, and those
  /// should also be wrapped in try-catch where used.
  /// Throws [UserFileException] if the user directory cannot be accessed.
  Future<File> getUserFile(String filename) async {
    final Directory userDir;
    try {
      userDir = await _getUserDirectory();
    } on UserFileException {
      rethrow; // Re-throw if _getUserDirectory already threw a specific error
    } catch (e, st) {
      // Catch any other unexpected errors from _getUserDirectory if it wasn't a UserFileException
      logDebug(
          'Unexpected error getting user directory for file "$filename" for user: $userId',
          source: e,
          stackTrace: st);
      throw UserFileException(
          'Could not access user directory to get file "$filename" for $userId.',
          cause: e,
          errorCode: DRunErrorCode.unexpected,
          stackTrace: st);
    }

    return File(p.join(userDir.path, filename));
  }

  /// Deletes all files within the user-specific directory.
  /// Returns `true` if deletion was attempted and successful or directory didn't exist.
  /// Throws [UserFileException] on failure to delete.
  Future<bool> deleteUserFiles() async {
    final userDir = Directory(p.join(
        (await getApplicationDocumentsDirectory()).path, 'user_data', userId));

    if (!await userDir.exists()) {
      logDebug(
          'User directory for $userId does not exist, no files to delete.');
      return false; // Nothing to delete
    }

    try {
      await userDir.delete(recursive: true);
      logDebug('Deleted all files for user: $userId at ${userDir.path}');
      return true;
    } on FileSystemException catch (e, st) {
      logDebug('FileSystemException in deleteUserFiles for user: $userId',
          source: e, stackTrace: st);
      throw UserFileException(
          'Failed to delete user files for $userId. Check permissions or if files are in use.',
          cause: e,
          stackTrace: st);
    } catch (e, st) {
      logDebug('Unexpected error in deleteUserFiles for user: $userId',
          source: e, stackTrace: st);
      throw UserFileException(
          'An unexpected error occurred while deleting user files for $userId.',
          cause: e,
          errorCode: DRunErrorCode.unexpected,
          stackTrace: st);
    }
  }
// UserFileManager(@factoryParam this.userId);
//
// final String userId;
//
// Future<Directory> _getUserDirectory() async {
//   try {
//     final baseDir = await getLibraryDirectory();
//     final userDir = Directory(p.join(baseDir.path, 'user_data', userId));
//     if (!await userDir.exists()) {
//       await userDir.create(recursive: true);
//     }
//     return userDir;
//   } catch (e, st) {
//     logDebug('Failed to get or create user directory for $userId',
//         source: e, stackTrace: st);
//     throw UserFileException('Could not access user directory for $userId', e);
//   }
// }
//
// Future<File> getUserFile(String filename) async {
//   try {
//     final userDir = await _getUserDirectory();
//     final file = File(p.join(userDir.path, filename));
//
//     return file;
//   } catch (e, st) {
//     logDebug('Failed to get user file "$filename" for $userId',
//         source: e, stackTrace: st);
//     throw UserFileException(
//         'Could not access user file "$filename" for $userId', e);
//   }
// }
//
// Future<bool> deleteUserFiles() async {
//   final userDir = Directory(p.join(
//       (await getApplicationDocumentsDirectory()).path, 'user_data', userId));
//   try {
//     if (await userDir.exists()) {
//       await userDir.delete(recursive: true);
//       logDebug('Deleted all files for user: $userId');
//       return true;
//     }
//     return false;
//   } catch (e, st) {
//     logDebug('Failed to delete user files for $userId',
//         source: e, stackTrace: st);
//     return false;
//   }
// }
}
