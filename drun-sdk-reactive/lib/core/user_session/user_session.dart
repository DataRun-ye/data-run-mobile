import 'dart:convert';

typedef TokenPair = ({String accessToken, String refreshToken});

class UserSession {
  static const String activeSessionScope = 'activeSessionContext';

  final String id;
  final String username;
  final String? firstName;
  final String? lastName;
  final String? mobile;
  final String? email;
  final String? langKey;
  final bool activated;
  final String? imageUrl;
  final List<String> authorities;
  final int? submissionCount;
  final int? assignmentCount;
  final int? orgUnitCount;
  final List<String> activityUIDs;
  final List<String> userTeamsUIDs;
  final List<String> managedTeamsUIDs;
  final List<String> userGroupsUIDs;
  final List<String> userFormsUIDs;

  const UserSession({
    required this.id,
    required this.username,
    this.firstName,
    this.lastName,
    this.mobile,
    this.email,
    this.langKey,
    required this.activated,
    this.imageUrl,
    required this.authorities,
    this.submissionCount,
    this.assignmentCount,
    this.orgUnitCount,
    required this.activityUIDs,
    required this.userTeamsUIDs,
    required this.managedTeamsUIDs,
    required this.userGroupsUIDs,
    required this.userFormsUIDs,
  });

  factory UserSession.fromJson(Map<String, dynamic> json) {
    return UserSession(
      id: json['id'] as String,
      username: json['username'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      mobile: json['mobile'] as String?,
      email: json['email'] as String?,
      langKey: json['langKey'] as String?,
      activated: json['activated'] as bool,
      imageUrl: json['imageUrl'] as String?,
      authorities: List<String>.from(json['authorities'] ?? const []),
      submissionCount: (json['submissionCount'] as num?)?.toInt(),
      assignmentCount: (json['submissionCount'] as num?)?.toInt(),
      orgUnitCount: json['orgUnitCount'] as int?,
      activityUIDs: List<String>.from(json['activityUIDs'] ?? const []),
      userTeamsUIDs: List<String>.from(json['userTeamsUIDs'] ?? const []),
      managedTeamsUIDs: List<String>.from(json['managedTeamsUIDs'] ?? const []),
      userGroupsUIDs: List<String>.from(json['userGroupsUIDs'] ?? const []),
      userFormsUIDs: List<String>.from(json['userFormsUIDs'] ?? const []),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'firstName': firstName,
        'lastName': lastName,
        'mobile': mobile,
        'email': email,
        'langKey': langKey,
        'activated': activated,
        'imageUrl': imageUrl,
        'authorities': authorities,
        'submissionCount': submissionCount,
        'assignmentCount': assignmentCount,
        'orgUnitCount': orgUnitCount,
        'activityUIDs': activityUIDs,
        'userTeamsUIDs': userTeamsUIDs,
        'managedTeamsUIDs': managedTeamsUIDs,
        'userGroupsUIDs': userGroupsUIDs,
        'userFormsUIDs': userFormsUIDs,
      };

  String toJsonString() => json.encode(toJson());

  factory UserSession.fromJsonString(String jsonString) =>
      UserSession.fromJson(json.decode(jsonString));

  factory UserSession.fromUser(String jsonString) =>
      UserSession.fromJson(json.decode(jsonString));
}
