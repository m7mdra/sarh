import 'dart:io';

class ModifyProfileImageEvent {}

class Modify extends ModifyProfileImageEvent {
  final File file;

  Modify(this.file);
}

class Load extends ModifyProfileImageEvent {}
