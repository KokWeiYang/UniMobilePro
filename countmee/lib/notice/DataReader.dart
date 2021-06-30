import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

Future<File> _getNoteFile() async {
  String dir = (await getApplicationDocumentsDirectory()).path;
  return new File('$dir/zjf_notepad.txt');
}

Future<File> _getMarkFile() async {
  String dir = (await getApplicationDocumentsDirectory()).path;
  return new File('$dir/zjf_notepadmark.txt');
}

Future<List<Map>> getNotes() async {
  try {
    File file = await _getNoteFile();
    String contents = await file.readAsString();
    final formatContents = json.decode(contents);
    if (formatContents is List) {
      return formatContents.map((Object item) {
        final Map newItem = item;
        return newItem;
      }).toList();
    } else {
      return [];
    }
  } on FileSystemException {
    return [];
  }
}

Future<List<Map>> getMarks() async {
  try {
    File file = await _getMarkFile();
    String contents = await file.readAsString();
    final formatContents = json.decode(contents);
    if (formatContents is List) {
      return formatContents.map((Object item) {
        final Map newItem = item;
        return newItem;
      }).toList();
    } else {
      return [];
    }
  } on FileSystemException {
    return [];
  }
}

Future setNotes(List<Map> contents) async {
  final String writeContents = json.encode(contents);
  print(writeContents);
  await (await _getNoteFile()).writeAsString(writeContents);
}

Future appendNote(Map note) async {
  final List<Map> existContents = await getNotes();
  existContents.insert(0, note);
  await (await _getNoteFile()).writeAsString(json.encode(existContents));
}

Future appendMark(Map mark) async {
  final List<Map> existContents = await getMarks();
  existContents.insert(0, mark);
  await (await _getMarkFile()).writeAsString(json.encode(existContents));
}

Future removeNote(int index) async {
  final List<Map> existContents = await getNotes();
  existContents.removeAt(index);
  await (await _getNoteFile()).writeAsString(json.encode(existContents));
}

Future removeMark(int index) async {
  final List<Map> existContents = await getMarks();
  existContents.removeAt(index);
  await (await _getMarkFile()).writeAsString(json.encode(existContents));
}

Future removeMarks(List<String> ids) async {
  final List<Map> existContents = await getMarks();
  existContents.removeWhere((Map mark) {
    return ids.any((String id) {
      return id == mark['id'];
    });
  });
  await (await _getMarkFile()).writeAsString(json.encode(existContents));
}