import 'dart:developer';

import 'package:facechat/constants/constants_colors.dart';
import 'package:facechat/utils/local_utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';

class ImageSaveBottomSheet extends StatefulWidget {
  final List imageList;
  final int currentImageIndex;
  const ImageSaveBottomSheet(
      {Key? key, required this.imageList, required this.currentImageIndex})
      : super(key: key);

  @override
  State<ImageSaveBottomSheet> createState() => _ImageSaveBottomSheetState();
}

class _ImageSaveBottomSheetState extends State<ImageSaveBottomSheet> {
  Future<bool> saveImage(String imageUrl) async {
    try {
      http.Response response = await http.get(Uri.parse(imageUrl));

      final result = await ImageGallerySaver.saveImage(
        response.bodyBytes,
        quality: 100,
      );

      return result['isSuccess'] ?? false;
    } catch (e) {
      log('saveImage error : $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    kCustomButton(
                      title: '묶음사진 전체 저장',
                      onPressed: () async {
                        bool saveSuccess = false;
                        for (int i = 0; i < widget.imageList.length; i++) {
                          saveSuccess = await saveImage(widget.imageList[i]);
                          if (!saveSuccess) {
                            if (!mounted) return;
                            Navigator.pop(context);
                            showMessage(context, message: '잠시후에 다시 시도해주세요.');
                            return;
                          }
                        }
                        if (!mounted) return;
                        if (saveSuccess) {
                          Navigator.pop(context);
                          showMessage(context, message: '사진이 갤러리에 저장되었습니다.');
                        }
                      },
                    ),
                    Container(
                        width: double.infinity,
                        height: 1,
                        color: kDarkGray20Color),
                    kCustomButton(
                      title: '이 사진만 저장',
                      onPressed: () async {
                        bool saveSuccess = await saveImage(
                            widget.imageList[widget.currentImageIndex]);
                        if (!mounted) return;
                        if (saveSuccess) {
                          Navigator.pop(context);
                          showMessage(context, message: '사진이 갤러리에 저장되었습니다.');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            SafeArea(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    '취소',
                    style: TextStyle(
                      fontSize: 16,
                      color: kMainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget kCustomButton({
    required String title,
    required Function onPressed,
  }) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        alignment: Alignment.center,
        color: kDarkGray20Color,
        width: double.infinity,
        height: 50,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: kMainColor,
          ),
        ),
      ),
    );
  }
}
