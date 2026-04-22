import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class SelectImageUtils {
  final int maxImageCount;
  final BuildContext context;

  SelectImageUtils({required this.context, this.maxImageCount = 1});

  // 갤러리에서 이미지 선택
  Future<List<File>> pickImagesFromGallery() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
        // allowCompression: true,
      );

      List<File> newImages = [];
      if (result != null) {
        for (var file in result.files) {
          if (file.path != null) {
            File imageFile = File(file.path!);
            if (newImages.length < maxImageCount) {
              newImages.add(imageFile);
            }
          }
        }

        print('선택된 이미지 개수: ${newImages.length}');
      }
      return newImages;
    } catch (e) {
      print('갤러리에서 이미지 선택 중 오류: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('이미지 선택 중 오류가 발생했습니다.'),
          backgroundColor: Colors.red,
        ),
      );
      return [];
    }
  }

  // 카메라로 사진 촬영
  Future<List<File>> takePhotoWithCamera() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        // allowCompression: true,
      );

      List<File> newImages = [];
      if (result != null && result.files.isNotEmpty) {
        if (result.files.first.path != null) {
          File imageFile = File(result.files.first.path!);
          if (newImages.length < maxImageCount) {
            newImages.add(imageFile);
          }
        }

        print('촬영된 이미지 추가됨');
      }
      return newImages;
    } catch (e) {
      print('카메라 촬영 중 오류: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('카메라 촬영 중 오류가 발생했습니다.'),
          backgroundColor: Colors.red,
        ),
      );
      return [];
    }
  }
}
