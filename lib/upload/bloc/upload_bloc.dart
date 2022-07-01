import 'dart:async';

import 'package:ahmed_mustafa_amazon/upload/view/upload_page.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:products_repository/src/products_repository.dart';

import '../../shared/data/product.dart';

part 'upload_event.dart';
part 'upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  UploadBloc({required ProductsRepository productsRepository})
      : _productsRepository = productsRepository,
        super(UploadStateInitial()) {
    on<UploadPressed>(_onUploadPressed);
  }
  final ProductsRepository _productsRepository;

  Future<void> _onUploadPressed(
      UploadPressed event, Emitter<UploadState> emit) async {
    print('just before uploading');
    emit(UploadStateLoading());
    try {
      var result = await _productsRepository.uploadProduct(
        event.title,
        event.imgUrl,
        event.price,
      );
      await result.fold((l) async {
        emit(UploadStateError());
      }, (r) {
        emit(UploadStateSuccess());
        print('success');
        Timer(Duration(seconds: 1), () {
          _emitBackToInitial();
        });
      });
    } catch (e) {
      emit(UploadStateError());
    }
  }

  void _emitBackToInitial() {
    emit(UploadStateInitial());
  }
}
