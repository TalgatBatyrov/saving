import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saving/blocs/saving/saving_cubit.dart';
import 'package:saving/services/file_picker_service/file_picker_service.dart';

class OrderPhotoModal extends StatelessWidget {
  final String savingId;
  const OrderPhotoModal({super.key, required this.savingId});

  @override
  Widget build(BuildContext context) {
    final savingCubit = context.read<SavingCubit>();
    final router = context.router;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Фото груза'),
        const SizedBox(height: 14),
        const Text(
          'Наведите камеру на груз. Пожалуйста, постарайтесь сделать качественное фото.',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () async {
                  final data = await AppFilePicker().takePhoto();

                  if (data != null) {
                    savingCubit.uploadImage(savingId, data.file);
                    router.pop();
                  }
                },
                child: const Icon(
                  Icons.camera_alt_outlined,
                ),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: () async {
                  final data = await AppFilePicker().showPhotoGallery();

                  if (data != null) {
                    savingCubit.uploadImage(savingId, data.file);
                    router.pop();
                  }
                },
                child: const Icon(Icons.photo_outlined),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
