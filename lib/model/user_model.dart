class UserModel {
  String? uid;
  String? email;
  String? name;
  String? roles;


  UserModel({this.uid, this.email, this.name, this.roles });

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      roles: map['roles']
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'roles':roles
    };
  }
}