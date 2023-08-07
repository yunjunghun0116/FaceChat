import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants/constants_colors.dart';
import '../../constants/constants_url.dart';
import '../../services/upload_service.dart';
import '../../widgets/custom_bottom_bar.dart';

class RegisterNameScreen extends StatefulWidget {
  final Function next;
  const RegisterNameScreen({Key? key, required this.next}) : super(key: key);

  @override
  State<RegisterNameScreen> createState() => _RegisterNameScreenState();
}

class _RegisterNameScreenState extends State<RegisterNameScreen> {
  final ImagePicker _picker = ImagePicker();

  final TextEditingController _nameController = TextEditingController();

  String _gender = '남성';
  late String _profileImage;

  bool get canNextPress => _nameController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _profileImage = DateTime.now().second % 2 == 0
        ? kProfileRedImageUrl
        : kProfileYellowImageUrl;
  }

  void imagePressed() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    String? imageUrl =
        await UploadService.uploadProfileImage(image: image);
    if (imageUrl == null) return;
    setState(() => _profileImage = imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: kWhiteColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '프로필 설정',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kFontGray900Color,
                  height: 1,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '프로필은 언제든 변경할 수 있어요.',
                style: TextStyle(
                  fontSize: 14,
                  color: kFontGray500Color,
                  height: 20 / 14,
                ),
              ),
            ),
            const SizedBox(height: 36),
            GestureDetector(
              onTap: () => imagePressed(),
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 104,
                      height: 104,
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.circular(55),
                        boxShadow: [
                          BoxShadow(
                            color: kBlackColor.withOpacity(0.08),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(55),
                        child: Image.network(
                          _profileImage,
                          fit: BoxFit.cover,
                          width: 104,
                          height: 104,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: kWhiteColor,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: kBlackColor.withOpacity(0.08),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/svg/camera_20px.svg',
                          width: 20,
                          height: 20,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 36),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const SizedBox(
                    width: 80,
                    child: Text('닉네임'),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 52,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: kFontGray50Color,
                      ),
                      child: TextField(
                        controller: _nameController,
                        keyboardType: TextInputType.number,
                        maxLength: 8,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          isDense: true,
                          counterText: '',
                          hintText: '8자 이내 한글 혹은 영문',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: kFontGray400Color,
                            height: 20 / 14,
                          ),
                        ),
                        onChanged: (text) => setState(() {}),
                        style: TextStyle(
                          fontSize: 14,
                          color: kFontGray800Color,
                          height: 20 / 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const SizedBox(
                    width: 80,
                    child: Text('성별'),
                  ),
                  Row(
                    children: ['남성', '여성']
                        .map((gender) => kGenderButton(gender))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomBar(
          active: canNextPress,
          text: '완료',
          onTap: () => widget.next(_nameController.text, _gender,_profileImage),
        ),
      ),
    );
  }

  Widget kGenderButton(String gender) {
    return GestureDetector(
      onTap: () => setState(() => _gender = gender),
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(right: 8),
        width: 80,
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: _gender == gender ? kSubColor1 : kFontGray50Color,
          border: _gender == gender ? Border.all(color: kMainColor) : null,
        ),
        child: Text(
          gender,
          style: TextStyle(
            fontSize: 14,
            height: 20 / 14,
            color: _gender == gender ? kSubColor3 : kFontGray400Color,
            fontWeight: _gender == gender ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
