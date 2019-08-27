class ModifyProfileImageState {}

class Loading extends ModifyProfileImageState {}

class Failed extends ModifyProfileImageState {}

class ImageLoaded extends ModifyProfileImageState {
  final String imageUrl;

  ImageLoaded(this.imageUrl);
}

class Success extends ModifyProfileImageState {}

class Idle extends ModifyProfileImageState {}
