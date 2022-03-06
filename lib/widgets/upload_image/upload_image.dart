import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatelessWidget {
  final Widget widget;
  final ValueChanged<ImageSource> pickImage;
  final VoidCallback removeImage;

  const UploadImage(
      {Key? key,
      required this.widget,
      required this.pickImage,
      required this.removeImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: <Widget>[
        widget,
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: ((builder) => bottomSheet(context)));
            },
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.camera_alt,
                size: 20,
              ),
            ),
          ),
        )
      ]),
    );
  }

  Widget bottomSheet(context) {
    return Container(
      //height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            "Choose photo",
            style: TextStyle(fontSize: 20.0),
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Camera'),
            onTap: () {
              pickImage(ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text('Gallery'),
            onTap: () {
              pickImage(ImageSource.gallery);
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Remove'),
            onTap: removeImage,
          ),
        ],
      ),
    );
  }
}
