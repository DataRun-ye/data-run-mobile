// import 'dart:convert';
// import 'package:datarunmobile/app/app_environment.dart';
// import 'package:datarunmobile/core/sync/model/sync_interval.dart';
// import 'package:datarunmobile/core/sync/sync_metadata_repository.dart';
// import 'package:injectable/injectable.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// @injectable
// class UserSessionService {
//   UserSessionService(this.prefs);
//
//   static const IS_AUTHENTICATED = 'IS_AUTHENTICATED';
//   static const SECURE_SESSION = 'SECURE_SESSION';
//
//   // PREFERENCES
//   static const PREFS_LangKey = 'lang_key';
//   static const PREFS_URLS = 'pref_urls';
//   static const PREFS_USERS = 'pref_users';
//
//   final SharedPreferences
//       prefs; // = PreferenceProvider.sharedPreferencesSync();
//
//   bool get isFirstSession {
//     // final session = sessionData;
//     return sessionData == null;
//   }
//
//   String? get databaseName {
//     if (sessionData == null) {
//       return null;
//     }
//     final uri = Uri.parse(sessionData!.serverUrl!).host;
//     return '${sessionData!.username!}_$uri';
//   }
//
//   /// After successful login, save user data
//   Future<void> saveUserCredentials(
//       {required String serverUrl,
//       required String username,
//       required String userId,
//       String? langKey}) async {
//     await prefs.setBool(IS_AUTHENTICATED, true);
//     final sessionData = SessionData(
//         username: username,
//         userId: userId,
//         langKey: langKey,
//         serverUrl: serverUrl);
//     await prefs.setString(SECURE_SESSION, jsonEncode(sessionData.toJson()));
//     // Add the database name to the set of known databases
//     final urls = prefs.getStringList(PREFS_URLS) ?? [];
//     if (!urls.contains(serverUrl)) {
//       urls.add(serverUrl);
//       await prefs.setStringList(PREFS_URLS, urls);
//     }
//
//     // Add the username to the set of known usernames
//     final usernames = prefs.getStringList(PREFS_USERS) ?? [];
//     if (!usernames.contains(username)) {
//       usernames.add(username);
//       await prefs.setStringList(PREFS_USERS, usernames);
//     }
//   }
//
//   Future<List<String>> getKnownUserNames() async {
//     return prefs.getStringList(PREFS_USERS) ?? [];
//   }
//
//   bool get isAuthenticated {
//     final isAuthenticated = prefs.getBool(IS_AUTHENTICATED) ?? false;
//     return isAuthenticated;
//   }
//
//   SessionData? get sessionData {
//     SessionData? sessionData;
//     final sessionDataPrefs = prefs.getString(SECURE_SESSION) ?? '';
//     if (sessionDataPrefs.isNotEmpty) {
//       sessionData = SessionData.fromJson(jsonDecode(sessionDataPrefs));
//     }
//     return sessionData;
//   }
//
//   ////////////////////////////////////////////////////
//   /////////////////////////////////////////////////////
//   DateTime? get lastSyncTime => DateTime.fromMillisecondsSinceEpoch(
//       prefs.getInt(SyncMetadataRepository.LAST_SYNC_TIME) ?? 0);
//
//   bool get syncDone => prefs.getBool(SyncMetadataRepository.SYNC_DONE) ?? false;
//
//   Future<bool> setSyncInterval(SyncInterval interval) async {
//     return prefs.setInt(SyncMetadataRepository.SYNC_INTERVAL, interval.milliseconds);
//   }
//
//   SyncInterval getSyncInterval() {
//     // final prefs = ref.watch(sharedPreferencesProvider);
//     final intervalMs = prefs.getInt(SyncMetadataRepository.SYNC_INTERVAL) ??
//         SyncInterval.biweekly.milliseconds;
//     return SyncInterval.values.firstWhere(
//         (interval) => interval.milliseconds == intervalMs,
//         orElse: () => SyncInterval.biweekly);
//   }
//
//   // bool needsSync() {
//   //   final lastSyncTime = prefs.getInt(SyncService.LAST_SYNC_TIME) ?? 0;
//   //   final syncInterval = getSyncInterval();
//   //   final syncDone = prefs.getBool(SyncService.SYNC_DONE) ?? false;
//   //   if (!syncDone) return true;
//   //
//   //   final currentTime = DateTime.now().millisecondsSinceEpoch;
//   //   return (currentTime - lastSyncTime) > syncInterval.milliseconds;
//   // }
//
//   // Clear user data from SharedPreferences
//   Future<void> clearSessionFromPreferences() async {
//     prefs.clear();
//     // prefs.remove(D2Remote.currentDatabaseNameKey);
//     // prefs.remove(IS_AUTHENTICATED);
//     // prefs.remove(SECURE_SESSION);
//     // prefs.
//   }
//
//   Future<void> clearAllPreferences() async {
//     prefs.clear();
//     // prefs.remove(SyncService.LAST_SYNC_TIME);
//     // prefs.remove(SyncService.SYNC_INTERVAL);
//     // // prefs.remove(INITIAL_SYNC);
//     // prefs.remove(SyncService.SYNC_DONE);
//     // prefs.remove(D2Remote.currentDatabaseNameKey);
//     // prefs.remove(IS_AUTHENTICATED);
//     // prefs.remove(SECURE_SESSION);
//   }
// }
//
// class SessionData {
//   SessionData({
//     required this.username,
//     required this.userId,
//     required this.serverUrl,
//     String? langKey,
//     this.token,
//     this.expirationDate,
//   }) : this.langKey = langKey ?? AppEnvironment.defaultLocale;
//
//   factory SessionData.fromJson(Map<String, dynamic> json) {
//     return SessionData(
//       username: json['username'],
//       userId: json['userId'],
//       serverUrl: json['serverUrl'],
//       langKey: json['langKey'],
//       token: json['token'],
//       expirationDate: json['expirationDate'] != null
//           ? DateTime.parse(json['expirationDate'])
//           : null,
//     );
//   }
//
//   final String? username;
//   final String? userId;
//
//   // final String? password;
//   final String? serverUrl;
//   final String langKey;
//   final String? token;
//   final DateTime? expirationDate;
//
//   Map<String, dynamic> toJson() {
//     return {
//       'username': username,
//       'userId': userId,
//       'serverUrl': serverUrl,
//       'langKey': langKey,
//       'token': token,
//       'expirationDate': expirationDate?.toIso8601String(),
//     };
//   }
// }
