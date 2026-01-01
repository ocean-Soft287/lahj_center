import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditAdImagePicker extends StatelessWidget {
  final List<String> existingImageUrls;
  final List<File> selectedImages;
  final int maxImages;
  final Color green;
  final VoidCallback onPickCamera;
  final VoidCallback onPickGallery;
  final Function(int) onRemoveExisting;
  final Function(int) onRemoveNew;

  const EditAdImagePicker({
    super.key,
    required this.existingImageUrls,
    required this.selectedImages,
    required this.maxImages,
    required this.green,
    required this.onPickCamera,
    required this.onPickGallery,
    required this.onRemoveExisting,
    required this.onRemoveNew,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: label('صور الاعلان', green),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            children: [
              // عرض الصور
              if (existingImageUrls.isNotEmpty ||
                  selectedImages.isNotEmpty) ...[
                SizedBox(
                  height: 150.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    addAutomaticKeepAlives: true,
                    itemCount: existingImageUrls.length + selectedImages.length,
                    itemBuilder: (context, index) {
                      bool isExistingImage = index < existingImageUrls.length;
                      return Stack(
                        children: [
                          Container(
                            width: 200.w,
                            margin: EdgeInsets.only(
                              left: 8.w,
                              right: 8.w,
                              bottom: 8.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: isExistingImage
                                  ? Image.network(
                                      existingImageUrls[index],
                                      width: 200.w,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Container(
                                              color: Colors.grey.shade200,
                                              child: const Icon(
                                                Icons.broken_image,
                                                color: Colors.grey,
                                              ),
                                            );
                                          },
                                    )
                                  : Image.file(
                                      selectedImages[index -
                                          existingImageUrls.length],
                                      width: 200.w,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap: () {
                                if (isExistingImage) {
                                  onRemoveExisting(index);
                                } else {
                                  onRemoveNew(index - existingImageUrls.length);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 12.h),
              ],

              // أزرار إضافة الصور
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: onPickCamera,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt_outlined,
                              size: 32.sp,
                              color: green,
                            ),
                            SizedBox(height: 4.h),
                            Text("الكاميرا", style: TextStyle(fontSize: 12.sp)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: onPickGallery,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.photo_library_outlined,
                              size: 32.sp,
                              color: green,
                            ),
                            SizedBox(height: 4.h),
                            Text("المعرض", style: TextStyle(fontSize: 12.sp)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                "يمكنك إضافة حتى $maxImages صور (${existingImageUrls.length + selectedImages.length}/$maxImages)",
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget label(String text, Color color) => Center(
    child: Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12.sp,
        color: color,
      ),
      textAlign: TextAlign.center,
    ),
  );
}
