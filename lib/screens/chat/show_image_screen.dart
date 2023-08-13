import 'package:facechat/constants/constants_colors.dart';
import 'package:flutter/material.dart';

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
            onTap: (){},
            behavior: HitTestBehavior.opaque,
            child: const Center(
              child: Icon(Icons.more_vert),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      backgroundColor: kBlackColor,
      body: PageView(
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
