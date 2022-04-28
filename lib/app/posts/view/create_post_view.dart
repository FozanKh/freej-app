import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freej/core/constants/phosphor_icons.dart';
import 'package:freej/core/exports/core.dart';

import '../../../core/services/firebase/storage_services.dart';
import '../models/post.dart';

class CreatePostView extends StatefulWidget {
  final Function callback;
  final PostType type;
  const CreatePostView({Key? key, required this.callback, required this.type}) : super(key: key);

  @override
  State<CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  String title = '';
  String description = '';
  List<File> images = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RoundedTextFormField(
          title: 'title'.translate,
          onChanged: (value) => title = value,
        ),
        const SizedBox(height: 30),
        RoundedTextFormField(
          title: 'description'.translate,
          onChanged: (value) => description = value,
          maxLines: 4,
        ),
        const SizedBox(height: 30),
        Titled(
          title: 'images'.translate,
          child: Container(
            height: Sizes.xxlCardHeight,
            decoration: BoxDecoration(
              border: Border.all(color: kGrey),
              borderRadius: Borders.mBorderRadius,
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...[
                      GestureDetector(
                        onTap: () async {
                          String? path = await StorageServices.openImagePicker();
                          if (path != null) images.add(File(path));
                          setState(() {});
                        },
                        child: Container(
                          height: Sizes.xxlCardHeight,
                          width: Sizes.xxlCardHeight / 2 + 10,
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: Borders.mBorderRadius,
                            border: Border.all(color: kGrey),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(PhosphorIcons.file_plus, size: 35),
                              Text("add_image".translate),
                            ],
                          ),
                        ),
                      )
                    ],
                    ...List.generate(
                      images.length,
                      (index) => Container(
                        height: Sizes.xxlCardHeight,
                        width: Sizes.xxlCardHeight + 10,
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: Borders.mBorderRadius,
                          border: Border.all(color: kGrey),
                          image: DecorationImage(image: FileImage(images[index]), fit: BoxFit.fill),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        RoundedButton(
          title: "submit".translate,
          onTap: () async {
            if (title.length < 4) {
              AlertDialogBox.showAlert(context, message: 'please_enter_proper_title');
            } else if (description.length < 5) {
              AlertDialogBox.showAlert(context, message: 'please_enter_proper_description');
            } else if (await widget.callback(
              widget.type,
              title,
              description,
              images,
            )) {
              Nav.popPage(context);
            }
          },
        ),
      ],
    );
  }
}
