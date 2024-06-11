class HistoryBookTableModel {
  int? id;
  String? name;
  int? phone;
  String? date;
  String? time;
  int? people;
  int? numberTable;
  String? createdAt;
  String? updatedAt;
  int? customerId;
  String? status;
  int? ownerId;
  String? nameRestaurant;
  List<DishesInHistoryBookTableModel>? dishes;

  HistoryBookTableModel(
      {this.id,
      this.name,
      this.phone,
      this.date,
      this.time,
      this.people,
      this.numberTable,
      this.createdAt,
      this.updatedAt,
      this.customerId,
      this.status,
      this.ownerId,
      this.nameRestaurant,
      this.dishes});

  HistoryBookTableModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    date = json['date'];
    time = json['time'];
    people = json['people'];
    numberTable = json['number_table'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customerId = json['customer_id'];
    status = json['status'];
    ownerId = json['owner_id'];
    nameRestaurant = json['name_restaurant'];
    if (json['dishes'] != null) {
      dishes = <DishesInHistoryBookTableModel>[];
      json['dishes'].forEach((v) {
        dishes!.add(new DishesInHistoryBookTableModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['date'] = this.date;
    data['time'] = this.time;
    data['people'] = this.people;
    data['number_table'] = this.numberTable;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['customer_id'] = this.customerId;
    data['status'] = this.status;
    data['owner_id'] = this.ownerId;
    data['name_restaurant'] = this.nameRestaurant;
    if (this.dishes != null) {
      data['dishes'] = this.dishes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DishesInHistoryBookTableModel {
  int? id;
  String? title;
  String? slug;
  String? desc;
  String? image;
  String? content;
  int? price;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? multiimage;
  int? ownerId;
  Pivot? pivot;

  DishesInHistoryBookTableModel(
      {this.id,
      this.title,
      this.slug,
      this.desc,
      this.image,
      this.content,
      this.price,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.multiimage,
      this.ownerId,
      this.pivot});

  DishesInHistoryBookTableModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    desc = json['desc'];
    image = json['image'];
    content = json['content'];
    price = json['price'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    multiimage = json['multiimage'];
    ownerId = json['owner_id'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['desc'] = this.desc;
    data['image'] = this.image;
    data['content'] = this.content;
    data['price'] = this.price;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['multiimage'] = this.multiimage;
    data['owner_id'] = this.ownerId;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? bookTableId;
  int? dishId;

  Pivot({this.bookTableId, this.dishId});

  Pivot.fromJson(Map<String, dynamic> json) {
    bookTableId = json['book_table_id'];
    dishId = json['dish_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['book_table_id'] = this.bookTableId;
    data['dish_id'] = this.dishId;
    return data;
  }
}
