import 'package:ahmed_mustafa_amazon/shared/widgets/make_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/upload_bloc.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  State<UploadPage> createState() => _UploadPageState();
}

TextEditingController titleController = TextEditingController();
TextEditingController priceController = TextEditingController();
TextEditingController imgController = TextEditingController();

bool isValid() {
  if (titleController.text == '' ||
      imgController.text == '' ||
      priceController.text == 0.toString()) {
    return false;
  } else {
    return true;
  }
}

class _UploadPageState extends State<UploadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('upload product'),
        centerTitle: true,
      ),
      body: BlocBuilder<UploadBloc, UploadState>(
        builder: (context, state) {
          if (state is UploadStateSuccess) {
            titleController.clear();
            priceController.clear();
            imgController.clear();
          }
          print('state from ui upload : ' + state.toString());
          return Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MakeInput(
                    label: 'title',
                    controller: titleController,
                    onChanged: (v) {
                      setState(() {});
                    }),
                MakeInput(
                  label: 'price',
                  controller: priceController,
                  onChanged: (v) {
                    setState(() {
                      isValid();
                    });
                  },
                  isNumber: true,
                ),
                MakeInput(
                    label: 'image url',
                    controller: imgController,
                    onChanged: (v) {
                      setState(() {
                        isValid();
                      });
                    }),
                Container(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ButtonStyle(),
                        onPressed: !isValid() ||
                                state is UploadStateLoading ||
                                state is UploadStateSuccess
                            ? null
                            : () {
                                context.read<UploadBloc>().add(UploadPressed(
                                    title: titleController.text,
                                    price: int.parse(priceController.text),
                                    imgUrl: imgController.text));
                              },
                        child: state is UploadStateLoading
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator())
                            : state is UploadStateSuccess
                                ? Icon(
                                    Icons.check_box,
                                    color: Colors.green,
                                  )
                                : Text('upload')))
              ],
            ),
          ));
        },
      ),
    );
  }
}
