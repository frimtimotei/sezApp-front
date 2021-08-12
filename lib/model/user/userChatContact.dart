class UserChatContact {
  String id;
  String firstName;
  String lastName;
  String role;
  String imageUrl;

  UserChatContact(
      {this.id, this.firstName, this.lastName, this.role, this.imageUrl});

  UserChatContact.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    firstName = json['first_name'];
    lastName = json['last_name'];
    imageUrl = json['imageUrl'];
    role = json['role'];
  }
}

class UserChatRoomContact extends UserChatContact {
  String lastMessage;

  UserChatRoomContact(
      {this.lastMessage,
      String id,
      String firstName,
      String lastName,
      String role,
      String imageUrl})
      : super(
            id: id,
            firstName: firstName,
            lastName: lastName,
            role: role,
            imageUrl: imageUrl);

  UserChatRoomContact.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    firstName = json['first_name'];
    lastName = json['last_name'];
    lastMessage = json['lastMessage'];
    imageUrl = json['imageUrl'];
    role = json['role'];
  }
}
