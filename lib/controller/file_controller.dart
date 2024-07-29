import 'package:esp8266_app/file_manager.dart';
import 'package:esp8266_app/model/client_json.dart';
import 'package:flutter/material.dart';

class FileController extends ChangeNotifier
{
  String _text = '';
  Client_JSON _client = Client_JSON('', '');

  String get text => _text;
  Client_JSON get client => _client;

  readText() async {
    _text = await FileManager().readTextFile();
    notifyListeners();
  }

  writeText(String txt) async {
    _text = await FileManager().writeTextFile(txt);
    notifyListeners();
  }

  readClient() async {
    _client = Client_JSON.fromJson(await FileManager().readJsonFile());
    notifyListeners();
  }

  writeClient() async {
    _client = await FileManager().writeJsonFile();
    notifyListeners();
  }
}