import 'package:facechat/screens/chat/show_image_screen.dart';
import 'package:flutter/material.dart';

import '../../../../constants/constants_colors.dart';

class ImageContainer extends StatelessWidget {
  final double topMargin;
  final List imageList;
  const ImageContainer(
      {Key? key, required this.topMargin, required this.imageList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ShowImageScreen(imageList: imageList ),
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(top: topMargin),
        constraints: const BoxConstraints(maxWidth: 248),
        child: Builder(builder: (context) {
          List showImageList = [];
          if (imageList.length > 3) {
            showImageList.addAll(imageList.sublist(0, 2));
            showImageList.add('more');
          } else {
            showImageList.addAll(imageList);
          }

          int imageIndex = 0;

          return Row(
            mainAxisSize: MainAxisSize.min,
            children: showImageList.map(
              (image) {
                double rightMargin =
                    imageIndex++ < showImageList.length - 1 ? 4 : 0;
                if (image == 'more') {
                  return Container(
                    alignment: Alignment.center,
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: kDarkGray10Color,
                    ),
                    child: Icon(
                      Icons.more_horiz,
                      color: kDarkGray30Color,
                    ),
                  );
                }
                return Container(
                  margin: EdgeInsets.only(right: rightMargin),
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: kDarkGray10Color,
                    image: DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ).toList(),
          );
        }),
      ),
    );
  }
}
