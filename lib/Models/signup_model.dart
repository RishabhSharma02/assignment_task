class signupModel {
  String? message;
  bool? success;
  String? userId;

  signupModel({this.message, this.success, this.userId});

  signupModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['success'] = this.success;
    data['user_id'] = this.userId;
    return data;
  }
}