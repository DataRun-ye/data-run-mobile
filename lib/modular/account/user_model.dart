import 'package:equatable/equatable.dart';

class UserModel with EquatableMixin {
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['firstName'],
      username: json['username'],
      mobile: json['phoneNumber'],
      isLoggedIn: json['isLoggedIn'],
      baseUrl: json['baseUrl'],
      email: json['email'],
      langKey: json['langKey'],
      activated: json['activated'],
      imageUrl: json['imageUrl'],
    );
  }

  UserModel(
      {required this.id,
      this.name,
      this.surname,
      this.mobile,
      required this.username,
      this.imageUrl,
      this.baseUrl,
      this.email,
      this.langKey,
      this.activated,
      this.isLoggedIn = false});

  final String id;
  final String? name;
  final String? surname;
  final String username;
  final String? mobile;
  final String? imageUrl;
  final bool isLoggedIn;
  final String? baseUrl;
  final String? email;
  final String? langKey;
  final bool? activated;

  static List<UserModel> fromJsonList(List<dynamic> list) {
    return list.map((item) => UserModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#$id $name';
  }

  //
  // ///this method will prevent the override of toString
  // bool userFilterByCreationDate(String filter) {
  //   return createdAt.toString().contains(filter);
  // }

  ///custom comparing function to check if two users are equal
  bool isEqual(UserModel model) {
    return id == model.id;
  }

  @override
  List<Object?> get props =>
      [id, username, isLoggedIn, activated, baseUrl, langKey];
}
