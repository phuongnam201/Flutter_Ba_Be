class BookRoomModel {
  String? name;
  String? phone;
  String? checkin;
  String? checkout;
  String? adults;
  String? children;
  List<RoomsSelected>? roomsSelected;
  String? numberRoom;

  BookRoomModel({
    this.name,
    this.phone,
    this.checkin,
    this.checkout,
    this.adults,
    this.children,
    this.roomsSelected,
    this.numberRoom,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['checkin'] = this.checkin;
    data['checkout'] = this.checkout;
    data['adults'] = this.adults;
    data['children'] = this.children;
    data['number_room'] = this.numberRoom;
    if (this.roomsSelected != null) {
      data['book_room_id'] =
          this.roomsSelected!.map((v) => v.toJson()).toList().toString();
    }
    return data;
  }
}

class RoomsSelected {
  String? roomId;
  String? number;

  RoomsSelected({this.roomId, this.number});

  RoomsSelected.fromJson(Map<String, dynamic> json) {
    roomId = json['room_id'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\"room_id\"'] = this.roomId;
    data['\"number\"'] = this.number;
    return data;
  }
}
