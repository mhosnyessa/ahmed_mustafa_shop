part of 'upload_bloc.dart';

abstract class UploadEvent extends Equatable {
  const UploadEvent();

  @override
  List<Object> get props => [];
}

class UploadPressed extends UploadEvent {
  final String title;
  final int price;
  final String imgUrl;

  const UploadPressed(
      {required this.title, required this.price, required this.imgUrl});
  @override
  List<Object> get props => [title, price, imgUrl];
}
