class Message{
  int id;
  String message;
  AccountReceiver accountReceiver;
  AccountSender accountSender;
  List<Attachment> messageAttachments;
  QuotationRequest quotatioRequest;
  QuotationReplies quotationReply;
  String seenAt;
  int createdAt;

  Message(
      {this.id,
        this.message,
        this.accountReceiver,
        this.accountSender,
        this.messageAttachments,
        this.quotatioRequest,
        this.quotationReply,
        this.seenAt,
        this.createdAt});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    accountReceiver = json['accountReceiver'] != null
        ? new AccountReceiver.fromJson(json['accountReceiver'])
        : null;
    accountSender = json['accountSender'] != null
        ? new AccountSender.fromJson(json['accountSender'])
        : null;
    if (json['messageAttachments'] != null) {
      messageAttachments = new List<Attachment>();
      json['messageAttachments'].forEach((v) {
        messageAttachments.add(new Attachment.fromJson(v));
      });
    }
    quotatioRequest = json['quotatioRequest'] != null
        ? new QuotationRequest.fromJson(json['quotatioRequest'])
        : null;
    quotationReply = json['quotationReply'] != null
        ? new QuotationReplies.fromJson(json['quotationReply'])
        : null;
    seenAt = json['seen_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    if (this.accountReceiver != null) {
      data['accountReceiver'] = this.accountReceiver.toJson();
    }
    if (this.accountSender != null) {
      data['accountSender'] = this.accountSender.toJson();
    }
    if (this.messageAttachments != null) {
      data['messageAttachments'] =
          this.messageAttachments.map((v) => v.toJson()).toList();
    }
    if (this.quotatioRequest != null) {
      data['quotatioRequest'] = this.quotatioRequest.toJson();
    }
    if (this.quotationReply != null) {
      data['quotationReply'] = this.quotationReply.toJson();
    }
    data['seen_at'] = this.seenAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class AccountReceiver {
  int id;
  String fullName;
  String image;

  AccountReceiver({this.id, this.fullName, this.image});

  AccountReceiver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['image'] = this.image;
    return data;
  }
}

class AccountSender {
  int id;
  String fullName;
  String image;

  AccountSender({this.id, this.fullName, this.image});

  AccountSender.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['image'] = this.image;
    return data;
  }
}

class QuotationRequest {
  int id;
  Account account;
  List<Activities> activities;
  String subject;
  String details;
  List<QuotationReplies> quotationReplies;
  List<Attachment> attachment;

  QuotationRequest(
      {this.id,
        this.account,
        this.activities,
        this.subject,
        this.details,
        this.quotationReplies,
        this.attachment});

  QuotationRequest.fromJson(Map<String, dynamic> json) {
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

class Account {
  int id;
  String fullName;

  Account({this.id, this.fullName});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    return data;
  }
}

class Activities {
  int id;
  String nameEn;
  String nameAr;
  int createdAt;
  int updatedAt;
  Null deletedAt;

  Activities(
      {this.id,
        this.nameEn,
        this.nameAr,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Activities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Attachment {
  int id;
  int quotationId;
  String fileUrl;
  String fileType;
  String quotationType;
  String createdAt;
  String updatedAt;
  Null deletedAt;

  Attachment(
      {this.id,
        this.quotationId,
        this.fileUrl,
        this.fileType,
        this.quotationType,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Attachment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quotationId = json['quotation_id'];
    fileUrl = json['file_url'];
    fileType = json['file_type'];
    quotationType = json['quotation_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quotation_id'] = this.quotationId;
    data['file_url'] = this.fileUrl;
    data['file_type'] = this.fileType;
    data['quotation_type'] = this.quotationType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

//class MessageAttachments{}

class QuotationReplies{
  int id;
  String title;
  String details;
  int price;
  int companyId;
  int quotationRequestId;
  int messageId;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;

  QuotationReplies(
      {this.id,
        this.title,
        this.details,
        this.price,
        this.companyId,
        this.quotationRequestId,
        this.messageId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  QuotationReplies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    details = json['details'];
    price = json['price'];
    companyId = json['company_id'];
    quotationRequestId = json['quotation_request_id'];
    messageId = json['message_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['details'] = this.details;
    data['price'] = this.price;
    data['company_id'] = this.companyId;
    data['quotation_request_id'] = this.quotationRequestId;
    data['message_id'] = this.messageId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}