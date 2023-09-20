class faceModel {
  String? frame;
  String? message;
  bool? success;

  faceModel({this.frame, this.message, this.success});

  faceModel.fromJson(Map<String, dynamic> json) {
    frame = json['frame'];
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['frame'] = this.frame;
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}