import 'package:flutter_babe/data/repository/history_table_repo.dart';
import 'package:flutter_babe/models/history_book_table_model.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryBookTableController extends GetxController implements GetxService {
  final HistoryBookTableRepo historyBookTableRepo;
  SharedPreferences sharedPreferences;

  HistoryBookTableController(
      {required this.historyBookTableRepo, required this.sharedPreferences});

  List<HistoryBookTableModel> _historyBookTableList = [];
  List<HistoryBookTableModel> get historyBookTableList => _historyBookTableList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  HistoryBookTableModel? _historyBookTable;
  HistoryBookTableModel? get historyBookTable => _historyBookTable;

  Future<void> getDataHistoryTable() async {
    _isLoading = true;
    String? language =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? 'vi';
    try {
      Response response =
          await historyBookTableRepo.getHistoryBookTable(locale: language);
      if (response.statusCode == 200) {
        _historyBookTableList.clear();
        List<dynamic> data = response.body["results"];
        data.forEach((element) {
          HistoryBookTableModel historyBookTable =
              HistoryBookTableModel.fromJson(element);
          _historyBookTableList.add(historyBookTable);
        });
        _isLoading = false;
        update();
      }
      //print(_historyBookTableList[0].dishes!.map((e) => print(e.title)));
    } catch (e) {
      print("fail when system is getting data at history table controller: $e");
    }
  }

  Future<void> getDetailHistoryBookTable(int id) async {
    _isLoading = true;
    String? language =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? 'vi';
    try {
      Response response = await historyBookTableRepo.getDetailHistoryBookTable(
          book_table_id: id, language: language);
      if (response.statusCode == 200) {
        // _historyBookTableList.clear();
        // List<dynamic> data = response.body["results"];
        // data.forEach((element) {
        //   HistoryBookTable historyBookTable =
        //       HistoryBookTable.fromJson(element);
        //   _historyBookTableList.add(historyBookTable);
        // });
        _isLoading = false;
        update();
      }
    } catch (e) {
      print("fail when system is getting data at history table controller: $e");
    }
  }
}
