import 'dart:async';

import 'package:ahmed_mustafa_amazon/upload/bloc/upload_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:products_repository/products_repository.dart';

import '../bloc/products_bloc.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, ProductsState state) {
        print(state.status);
        // _onRefresh() async {
        //   print(state.status);
        //   context.read<ProductsBloc>().add(ProductsAllRequested());
        //   print(state.status);
        //   while (state.status == ProductsStatus.loading) {
        //     print('loading in refresh');
        //   }
        //   await Future.delayed(Duration(seconds: 2), () {});
        //   while (state.status == ProductsStatus.loading) {
        //     print('loading in refresh');
        //   }
        //   print(state.status);

        //   return Future(() => null);
        // }

        print('from the UI : ' + state.status.toString());
        if (state.status == ProductsStatus.resultsReady) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: RefreshIndicator(
                    // onRefresh: _onRefresh,
                    onRefresh: () {
                      context.read<ProductsBloc>().add(ProductsAllRequested());
                      return Future.delayed(Duration(milliseconds: 300));
                    },
                    child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: state.productsList.map((e) {
                          print(e);
                          return Container(
                            margin: const EdgeInsets.all(8.0),
                            width: double.infinity,
                            height: 150,
                            color: Colors.white,
                            child: Row(
                              children: [
                                Container(
                                  width: 150,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            4, 0), // changes position of shadow
                                      ),
                                    ],
                                    image: DecorationImage(
                                      image: NetworkImage(e['img']),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 150,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        e['title'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        e['price'].toString() + ' EGP',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 40, 40, 40)),
                                      ),
                                    ],
                                  ),
                                ),
                                LikeButton(),
                              ],
                            ),
                          );
                        }).toList()),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                TextButton(
                  onPressed: () {
                    context.read<ProductsBloc>().add(ProductsAllRequested());
                  },
                  child: Text('get all products'),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
