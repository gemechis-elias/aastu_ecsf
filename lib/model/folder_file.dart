import 'package:flutter/material.dart';

class FolderFile {

  IconData? image;
  late String name;
  late String date;
  bool section = false;
  bool folder = true;

  FolderFile(String name, String date, IconData image, bool folder) {
    this.image = image;
    this.name = name;
    this.date = date;
    this.folder = folder;
  }

  FolderFile.section(String name) {
    this.name = name;
    this.section = true;
  }

}
