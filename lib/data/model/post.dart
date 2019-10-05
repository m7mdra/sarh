/*
 * Copyright (c) 2019.
 *           ______             _
 *          |____  |           | |
 *  _ __ ___    / / __ ___   __| |_ __ __ _
 * | '_ ` _ \  / / '_ ` _ \ / _` | '__/ _` |
 * | | | | | |/ /| | | | | | (_| | | | (_| |
 * |_| |_| |_/_/ |_| |_| |_|\__,_|_|  \__,_|
 *
 *
 *
 *
 */

import 'category.dart';

class Post {
  int id;
  Author author;
  String post;
  String title;
  String slug;
  List<Tag> tags;
  List<PostAttachments> postAttachments;
  List<PostComments> postComments;
  int allCommentsCount;
  List<PostFavorites> postFavorites;
  List<PostLikes> postLikes;
  int _like;
  int createdAt;

  set like(bool value) {
    _like = value ? 1 : 0;
  }

  bool get isLiked => _like == 1;

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    post = json['post'];
    title = json['title'];
    _like = json['isLikeIt'];
    slug = json['slug'];
    if (json['tags'] != null) {
      tags = new List<Tag>();
      json['tags'].forEach((v) {
        tags.add(new Tag.fromJson(v));
      });
    }
    if (json['postAttachments'] != null) {
      postAttachments = new List<PostAttachments>();
      json['postAttachments'].forEach((v) {
        postAttachments.add(new PostAttachments.fromJson(v));
      });
    }
    if (json['postComments'] != null) {
      postComments = new List<PostComments>();
      json['postComments'].forEach((v) {
        postComments.add(new PostComments.fromJson(v));
      });
    }
    allCommentsCount = json['allCommentsCount'];
    if (json['postFavorites'] != null) {
      postFavorites = new List<PostFavorites>();
      json['postFavorites'].forEach((v) {
        postFavorites.add(new PostFavorites.fromJson(v));
      });
    }
    if (json['postLikes'] != null) {
      postLikes = new List<PostLikes>();
      json['postLikes'].forEach((v) {
        postLikes.add(new PostLikes.fromJson(v));
      });
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
    data['isLikeIt'] = _like;
    if (this.postAttachments != null) {
      data['postAttachments'] =
          this.postAttachments.map((v) => v.toJson()).toList();
    }
    if (this.postComments != null) {
      data['postComments'] = this.postComments.map((v) => v.toJson()).toList();
    }
    data['allCommentsCount'] = this.allCommentsCount;
    if (this.postFavorites != null) {
      data['postFavorites'] =
          this.postFavorites.map((v) => v.toJson()).toList();
    }
    if (this.postLikes != null) {
      data['postLikes'] = this.postLikes.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Post &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          author == other.author &&
          post == other.post &&
          title == other.title &&
          slug == other.slug &&
          tags == other.tags &&
          postAttachments == other.postAttachments &&
          postComments == other.postComments &&
          allCommentsCount == other.allCommentsCount &&
          postFavorites == other.postFavorites &&
          postLikes == other.postLikes &&
          createdAt == other.createdAt;

  @override
  int get hashCode =>
      id.hashCode ^
      author.hashCode ^
      post.hashCode ^
      title.hashCode ^
      slug.hashCode ^
      tags.hashCode ^
      postAttachments.hashCode ^
      postComments.hashCode ^
      allCommentsCount.hashCode ^
      postFavorites.hashCode ^
      postLikes.hashCode ^
      createdAt.hashCode;
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Author &&
          runtimeType == other.runtimeType &&
          fullName == other.fullName &&
          image == other.image &&
          mainCategory == other.mainCategory;

  @override
  int get hashCode =>
      fullName.hashCode ^ image.hashCode ^ mainCategory.hashCode;
}

class PostAttachments {
  int id;
  int postId;
  String fileUrl;
  String fileType;
  String createdAt;
  String updatedAt;

  PostAttachments(
      {this.id,
      this.postId,
      this.fileUrl,
      this.fileType,
      this.createdAt,
      this.updatedAt});

  PostAttachments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['post_id'];
    fileUrl = json['file_url'];
    fileType = json['file_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['post_id'] = this.postId;
    data['file_url'] = this.fileUrl;
    data['file_type'] = this.fileType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostAttachments &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          postId == other.postId &&
          fileUrl == other.fileUrl &&
          fileType == other.fileType &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode =>
      id.hashCode ^
      postId.hashCode ^
      fileUrl.hashCode ^
      fileType.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}

class PostComments {
  int id;
  String comment;
  Customer customer;
  List<SubComments> subComments;
  int createdAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostComments &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          comment == other.comment &&
          customer == other.customer &&
          subComments == other.subComments &&
          createdAt == other.createdAt;

  @override
  int get hashCode =>
      id.hashCode ^
      comment.hashCode ^
      customer.hashCode ^
      subComments.hashCode ^
      createdAt.hashCode;

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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Customer &&
          runtimeType == other.runtimeType &&
          fullName == other.fullName &&
          image == other.image;

  @override
  int get hashCode => fullName.hashCode ^ image.hashCode;
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubComments &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          postId == other.postId &&
          comment == other.comment &&
          tblAccountId == other.tblAccountId &&
          parentCommentId == other.parentCommentId &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode =>
      id.hashCode ^
      postId.hashCode ^
      comment.hashCode ^
      tblAccountId.hashCode ^
      parentCommentId.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostFavorites &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          postId == other.postId &&
          tblAccountId == other.tblAccountId &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode =>
      id.hashCode ^
      postId.hashCode ^
      tblAccountId.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostLikes &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          postId == other.postId &&
          tblAccountId == other.tblAccountId &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode =>
      id.hashCode ^
      postId.hashCode ^
      tblAccountId.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}

class Tag {
  int id;
  String name;
  int controllerId;
  int objectId;
  int createdAt;
  int updatedAt;

  Tag.name(this.name);

  Tag.fromJson(Map<String, dynamic> json) {
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Tag &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          controllerId == other.controllerId &&
          objectId == other.objectId &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      controllerId.hashCode ^
      objectId.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
