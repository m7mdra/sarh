import 'messages.dart';

class Quotations {
  int id;
  Account account;
  List<Activities> activities;
  String subject;
  String details;
  List<QuotationReplies> quotationReplies;
  List<Attachment> attachment;

  Quotations({this.id,
    this.account,
    this.activities,
    this.subject,
    this.details,
    this.quotationReplies,
    this.attachment});

  Quotations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    account =
    json['account'] != null ? new Account.fromJson(json['account']) : null;
    if (json['activities'] != null) {
      activities = new List<Activities>();
      json['activities'].forEach((v) {
        activities.add(new Activities.fromJson(v));
      });
    }
    subject = json['subject'];
    details = json['details'];
//    quotationReplies = json['quotationReplies'] != null
//        ? new QuotationReplies.fromJson(json['quotationReplies'])
//        : null;
    if (json['quotationReplies'] != null) {
      quotationReplies = new List<QuotationReplies>();
      json['quotationReplies'].forEach((v) {
        quotationReplies.add(new QuotationReplies.fromJson(v));
      });
    }
    if (json['attachment'] != null) {
      attachment = new List<Attachment>();
      json['attachment'].forEach((v) {
        attachment.add(new Attachment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.account != null) {
      data['account'] = this.account.toJson();
    }
    if (this.activities != null) {
      data['activities'] = this.activities.map((v) => v.toJson()).toList();
    }
    data['subject'] = this.subject;
    data['details'] = this.details;
    if (this.activities != null) {
      data['activities'] = this.activities.map((v) => v.toJson()).toList();
      if (this.quotationReplies != null) {
        data['quotationReplies'] =
            this.quotationReplies.map((v) => v.toJson()).toList();
      }

      if (this.attachment != null) {
        data['attachment'] = this.attachment.map((v) => v.toJson()).toList();
      }
      return data;
    }
  }
}