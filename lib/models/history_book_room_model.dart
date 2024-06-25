class HistoryBookRoomModel {
  int? id;
  String? name;
  int? phone;
  String? checkin;
  String? checkout;
  int? adults;
  int? children;
  int? numberRoom;
  String? createdAt;
  String? updatedAt;
  int? customerId;
  String? status;
  int? ownerId;
  String? namePlace;
  String? numberDays;
  List<RoomsInHistoryBook>? rooms;

  HistoryBookRoomModel(
      {this.id,
      this.name,
      this.phone,
      this.checkin,
      this.checkout,
      this.adults,
      this.children,
      this.numberRoom,
      this.createdAt,
      this.updatedAt,
      this.customerId,
      this.status,
      this.ownerId,
      this.namePlace,
      this.numberDays,
      this.rooms});

  HistoryBookRoomModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    checkin = json['checkin'];
    checkout = json['checkout'];
    adults = json['adults'];
    children = json['children'];
    numberRoom = json['number_room'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customerId = json['customer_id'];
    status = json['status'];
    ownerId = json['owner_id'];
    namePlace = json['name_place'];
    numberDays = json['number_days'];
    if (json['rooms'] != null) {
      rooms = <RoomsInHistoryBook>[];
      json['rooms'].forEach((v) {
        rooms!.add(new RoomsInHistoryBook.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['checkin'] = this.checkin;
    data['checkout'] = this.checkout;
    data['adults'] = this.adults;
    data['children'] = this.children;
    data['number_room'] = this.numberRoom;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['customer_id'] = this.customerId;
    data['status'] = this.status;
    data['owner_id'] = this.ownerId;
    data['name_place'] = this.namePlace;
    data['number_days'] = this.numberDays;
    if (this.rooms != null) {
      data['rooms'] = this.rooms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RoomsInHistoryBook {
  int? id;
  String? title;
  String? slug;
  String? desc;
  String? content;
  String? image;
  String? multiimage;
  String? utilities;
  int? numberOfBeds;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? price;
  int? ownerId;
  PivotBookedRoom? pivot;

  RoomsInHistoryBook(
      {this.id,
      this.title,
      this.slug,
      this.desc,
      this.content,
      this.image,
      this.multiimage,
      this.utilities,
      this.numberOfBeds,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.price,
      this.ownerId,
      this.pivot});

  RoomsInHistoryBook.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    desc = json['desc'];
    content = json['content'];
    image = json['image'];
    multiimage = json['multiimage'];
    utilities = json['utilities'];
    numberOfBeds = json['number_of_beds'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    price = json['price'];
    ownerId = json['owner_id'];
    pivot = json['pivot'] != null
        ? new PivotBookedRoom.fromJson(json['pivot'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['desc'] = this.desc;
    data['content'] = this.content;
    data['image'] = this.image;
    data['multiimage'] = this.multiimage;
    data['utilities'] = this.utilities;
    data['number_of_beds'] = this.numberOfBeds;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['price'] = this.price;
    data['owner_id'] = this.ownerId;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class PivotBookedRoom {
  int? bookRoomId;
  int? roomId;
  int? number;

  PivotBookedRoom({this.bookRoomId, this.roomId, this.number});

  PivotBookedRoom.fromJson(Map<String, dynamic> json) {
    bookRoomId = json['book_room_id'];
    roomId = json['room_id'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['book_room_id'] = this.bookRoomId;
    data['room_id'] = this.roomId;
    data['number'] = this.number;
    return data;
  }
}
