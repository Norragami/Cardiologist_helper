import 'package:flutter/material.dart';
import 'package:reactive_file_picker/reactive_file_picker.dart';

abstract class ListItem {
  Widget build(BuildContext context);
}

class FileListItem extends ListItem {
  final String url;

  FileListItem(this.url);

  @override
  Widget build(context) {
    return Text(url);
  }
}

class PlatformFileListItem extends ListItem {
  final PlatformFile platformFile;

  PlatformFileListItem(this.platformFile);

  @override
  Widget build(context) {
    return Text(platformFile.path ?? '');
  }
}