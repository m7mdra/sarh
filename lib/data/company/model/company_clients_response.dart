import 'package:Sarh/data/model/client.dart';

class CompanyClientsResponse {
  bool success;
  List<Client> clients;
  String message;

  CompanyClientsResponse({this.success, this.clients, this.message});

  CompanyClientsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      clients = new List<Client>();
      json['data'].forEach((v) {
        clients.add(new Client.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.clients != null) {
      data['data'] = this.clients.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

