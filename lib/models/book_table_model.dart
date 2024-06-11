class BookTableModel {
  String? name;
  String? phone;
  String? date;
  String? time;
  String? people;
  String? number_table;
  List<DishesSelected>? dishesSelected;

  BookTableModel({
    this.name,
    this.phone,
    this.date,
    this.time,
    this.people,
    this.number_table,
    this.dishesSelected,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['date'] = this.date;
    data['time'] = this.time;
    data['people'] = this.people;
    data['number_table'] = this.number_table;
    if (this.dishesSelected != null) {
      data['book_table_dish_id'] =
          this.dishesSelected!.map((v) => v.toJson()).toList().toString();
    }
    return data;
  }
}

class DishesSelected {
  String? dishId;
  //String? number;

  DishesSelected({this.dishId});

  DishesSelected.fromJson(Map<String, dynamic> json) {
    dishId = json['table_id'];
    // number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\"table_id\"'] = this.dishId;
    //data['\"number\"'] = this.number;
    return data;
  }
}
