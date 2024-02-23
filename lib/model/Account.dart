

class Account  {
  Account._internal() {}
  String accountID = "";
  String fullName = "";
  String email = "";
  String password = "";
  String profile_pic = "";
  String type = '';

  static final Account _singleton = Account._internal();
  // Add a factory constructor to deserialize from Map
  factory Account.fromJson(Map<String, dynamic> json) {
    return Account._internal()
      ..accountID = json['accountID']
      ..fullName = json['fullName']
      ..email = json['email']
      ..password = json['password']
        .toList() ?? [];
  }
  // Add a method to convert to Map
  Map<String, dynamic> toJson() {
    return {
      'accountID': accountID,
      'fullName': fullName,
      'email': email,
      'password': password,
      'profilePic': profile_pic,
    };
  }
  factory Account() {
    return _singleton;
  }
}

// or
// static  Account _singleton = new Account();
// static Account getter() {
//  if( _singleton == null){
//     Account _singleton = new Account();
//  }
//  return _singleton;
// }





