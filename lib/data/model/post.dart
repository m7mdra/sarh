import 'category.dart';

class Post {
  int id;
  Author author;
  String post;
  String title;
  String slug;
  List<Tags> tags;
  List<PostAttachments> postAttachments;
  List<PostComments> postComments;
  int allCommentsCount;
  List<PostFavorites> postFavorites;
  List<PostLikes> postLikes;
  int createdAt;


  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    author = json['author'] != null ? new Author.fromJson(json['author']) : null;
    post = json['post'];
    title = json['title'];
    slug = json['slug'];
    if (json['tags'] != null) {
      tags = new List<Tags>();
      json['tags'].forEach((v) { tags.add(new Tags.fromJson(v)); });
    }
    if (json['postAttachments'] != null) {
      postAttachments = new List<PostAttachments>();
      json['postAttachments'].forEach((v) { postAttachments.add(new PostAttachments.fromJson(v)); });
    }
    if (json['postComments'] != null) {
      postComments = new List<PostComments>();
      json['postComments'].forEach((v) { postComments.add(new PostComments.fromJson(v)); });
    }
    allCommentsCount = json['allCommentsCount'];
    if (json['postFavorites'] != null) {
      postFavorites = new List<PostFavorites>();
      json['postFavorites'].forEach((v) { postFavorites.add(new PostFavorites.fromJson(v)); });
    }
    if (json['postLikes'] != null) {
      postLikes = new List<PostLikes>();
      json['postLikes'].forEach((v) { postLikes.add(new PostLikes.fromJson(v)); });
    }
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.author != null) {
      data['author'] = this.author.toJson();
    }
    data['post'] = this.post;
    data['title'] = this.title;
    data['slug'] = this.slug;
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    if (this.postAttachments != null) {
      data['postAttachments'] = this.postAttachments.map((v) => v.toJson()).toList();
    }
    if (this.postComments != null) {
      data['postComments'] = this.postComments.map((v) => v.toJson()).toList();
    }
    data['allCommentsCount'] = this.allCommentsCount;
    if (this.postFavorites != null) {
      data['postFavorites'] = this.postFavorites.map((v) => v.toJson()).toList();
    }
    if (this.postLikes != null) {
      data['postLikes'] = this.postLikes.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Author {
  String fullName;
  String image;
  Category mainCategory;

  Author({this.fullName, this.image, this.mainCategory});

  Author.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    image = json['image'];
    mainCategory = json['mainCategory'] != null
        ? new Category.fromJson(json['mainCategory'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    data['image'] = this.image;
    if (this.mainCategory != null) {
      data['mainCategory'] = this.mainCategory.toJson();
    }
    return data;
  }
}

class PostAttachments {
  int id;
  int postId;
  String fileUrl;
  String fileType;
  String createdAt;
  String updatedAt;
  Null deletedAt;

  PostAttachments(
      {this.id,
        this.postId,
        this.fileUrl,
        this.fileType,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  PostAttachments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['post_id'];
    fileUrl = json['file_url'];
    fileType = json['file_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['post_id'] = this.postId;
    data['file_url'] = this.fileUrl;
    data['file_type'] = this.fileType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class PostComments {
  int id;
  String comment;
  Customer customer;
  List<SubComments> subComments;
  int createdAt;

  PostComments(
      {this.id, this.comment, this.customer, this.subComments, this.createdAt});

  PostComments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    if (json['subComments'] != null) {
      subComments = new List<SubComments>();
      json['subComments'].forEach((v) {
        subComments.add(new SubComments.fromJson(v));
      });
    }
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comment'] = this.comment;
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
    }
    if (this.subComments != null) {
      data['subComments'] = this.subComments.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Customer {
  String fullName;
  String image;

  Customer({this.fullName, this.image});

  Customer.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    data['image'] = this.image;
    return data;
  }
}

class SubComments {
  int id;
  int postId;
  String comment;
  int tblAccountId;
  int parentCommentId;
  int createdAt;
  int updatedAt;

  SubComments(
      {this.id,
        this.postId,
        this.comment,
        this.tblAccountId,
        this.parentCommentId,
        this.createdAt,
        this.updatedAt});

  SubComments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['post_id'];
    comment = json['comment'];
    tblAccountId = json['tbl_account_id'];
    parentCommentId = json['parent_comment_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['post_id'] = this.postId;
    data['comment'] = this.comment;
    data['tbl_account_id'] = this.tblAccountId;
    data['parent_comment_id'] = this.parentCommentId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class PostFavorites {
  int id;
  int postId;
  int tblAccountId;
  String createdAt;
  String updatedAt;

  PostFavorites(
      {this.id,
        this.postId,
        this.tblAccountId,
        this.createdAt,
        this.updatedAt});

  PostFavorites.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['post_id'];
    tblAccountId = json['tbl_account_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['post_id'] = this.postId;
    data['tbl_account_id'] = this.tblAccountId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class PostLikes {
  int id;
  int postId;
  int tblAccountId;
  String createdAt;
  String updatedAt;

  PostLikes(
      {this.id,
        this.postId,
        this.tblAccountId,
        this.createdAt,
        this.updatedAt});

  PostLikes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['post_id'];
    tblAccountId = json['tbl_account_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['post_id'] = this.postId;
    data['tbl_account_id'] = this.tblAccountId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
class Tags {
  int id;
  String name;
  int controllerId;
  int objectId;
  int createdAt;
  int updatedAt;


  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    controllerId = json['controller_id'];
    objectId = json['object_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['controller_id'] = this.controllerId;
    data['object_id'] = this.objectId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}