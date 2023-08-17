import 'package:facechat/constants/constants_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'components/image_save_bottom_sheet.dart';

class ShowImageScreen extends StatefulWidget {
  final List imageList;
  const ShowImageScreen({Key? key, required this.imageList}) : super(key: key);

  @override
  State<ShowImageScreen> createState() => _ShowImageScreenState();
}

class _ShowImageScreenState extends State<ShowImageScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    double imageWidth = MediaQuery.of(context).size.width;
    double imageHeight = imageWidth + 100;
    double bottomHeight = AppBar().preferredSize.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlackColor,
        foregroundColor: kWhiteColor,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              double page = _pageController.page ?? 0;
              int currentIndex = page.toInt();
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) => ImageSaveBottomSheet(
                  imageList: widget.imageList,
                  currentImageIndex: currentIndex,
                ),
              );
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              alignment: Alignment.center,
              width: 26,
              height: 26,
              child: SvgPicture.asset('assets/icons/svg/more_white_26px.svg'),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      backgroundColor: kBlackColor,
      body: PageView(
        controller: _pageController,
        children: widget.imageList.map((image) {
          return Column(
            children: [
              const Spacer(),
              Container(
                width: imageWidth,
                height: imageHeight,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(image),
                  ),
                ),
              ),
              const Spacer(),
              SafeArea(child: Container(height: bottomHeight)),
            ],
          );
        }).toList(),
      ),
    );
  }
}
