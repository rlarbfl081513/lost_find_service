import 'package:client/core/constants/app_colors.dart';
import 'package:client/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class SelectImageModal extends StatelessWidget {
  final VoidCallback onPickImagesFromGallery;
  final VoidCallback onTakePhotoWithCamera;

  const SelectImageModal({
    super.key,
    required this.onPickImagesFromGallery,
    required this.onTakePhotoWithCamera,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      title: Text('이미지 추가', style: AppTextStyle.title()),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.photo_library, size: 20),
            title: Text('갤러리에서 선택', style: AppTextStyle.subTitle()),
            onTap: () {
              Navigator.pop(context);
              onPickImagesFromGallery();
            },
          ),
          ListTile(
            leading: Icon(Icons.camera_alt, size: 20),
            title: Text('카메라로 촬영', style: AppTextStyle.subTitle()),
            onTap: () {
              Navigator.pop(context);
              onTakePhotoWithCamera();
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            '취소',
            style: AppTextStyle.subTitle(color: AppColors.error),
          ),
        ),
      ],
    );
  }
}
