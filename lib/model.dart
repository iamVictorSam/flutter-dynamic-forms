class UserModel {
  late int userAge;
  late List<String> emails;

  UserModel(this.userAge, this.emails);

  UserModel.fromJson(Map<String, dynamic> json) {
    userAge = json['UserAge'];
    emails = json['Emails'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserAge'] = userAge;
    data['Emails'] = emails;
    return data;
  }
}
