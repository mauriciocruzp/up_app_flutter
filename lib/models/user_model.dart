class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final bool isAdmin;

  const UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isAdmin,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'firstName': String firstName,
        'lastName': String lastName,
        'email': String email,
        'isAdmin': bool isAdmin,
      } =>
        UserModel(
          id: id,
          firstName: firstName,
          lastName: lastName,
          email: email,
          isAdmin: isAdmin,
        ),
      _ =>
        throw const FormatException('Failed to create an UserModel from JSON'),
    };
  }
}