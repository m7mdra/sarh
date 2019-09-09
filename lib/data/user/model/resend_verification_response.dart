class ResendVerificationCodeResponse {
  bool success;
  String data;
  String message;

  ResendVerificationCodeResponse({this.success, this.data, this.message});

  ResendVerificationCodeResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'];
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['data'] = this.data;
    data['Message'] = this.message;
    return data;
  }
}
