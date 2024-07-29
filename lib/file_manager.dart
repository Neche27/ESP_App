import 'dart:io';
import 'dart:convert';
import 'package:esp8266_app/model/client_json.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class FileManager {
  static FileManager? _instance;

  FileManager._internal() {
    _instance = this;
  }

  factory FileManager() => _instance ?? FileManager._internal();
  Future<String?> get _directoryPath async {
    Directory? directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _file async {
    final path = await _directoryPath;
    return File('$path/appDetails.txt');
  }

  Future<File> get _jsonFile async {
    final path = await _directoryPath;
    return File('$path/appData.json');
  }

  Future<String> readTextFile() async {
    String fileContent = 'NO file Found';

    File file = await _file;

    if (await file.exists()) {
      try {
        fileContent = await file.readAsString();
      } catch (e) {
        print("My error");
      }
    }

    return fileContent;
  }

  Future<String> writeTextFile(String txt) async {
    String text = DateFormat('h:mm:ss').format(DateTime.now());
    text += " $txt";

    File file = await _file;

    await file.writeAsString(text);
    return text;
  }

  Future<Map<String, dynamic>> readJsonFile() async{
    String fileContent = 'NO file Found';

    File file = await _jsonFile;

    if (await file.exists()) {
      try {
        fileContent = await file.readAsString();
      } catch (e) {
        print(e);
      }
    }

    return json.decode(fileContent);
  }

   Future<Client_JSON> writeJsonFile() async {
    final  Client_JSON client = Client_JSON("24", "100");

    File file = await _jsonFile;
    await file.writeAsString(json.encode(client));
    return client;
  }
}
