import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controller/c_detail_course.dart';

class DetailCourse extends StatelessWidget {
  const DetailCourse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cDetailApp = Get.put(CDetailCourse());
    cDetailApp.setMCourse(Get.parameters['id']!.trim());
    return Scaffold(
      appBar: DView.appBarLeft('Detail Course'),
      body: Obx(() {
        if (cDetailApp.mCourse.idCourse == null) return DView.loadingCircle();
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 300,
                  maxWidth: 400,
                  minHeight: 200,
                  minWidth: 300,
                ),
                child: Image.network(
                  cDetailApp.mCourse.cover!,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            DView.spaceHeight(),
            const Text('This course available on:'),
            DView.spaceHeight(8),
            Obx(() {
              if (cDetailApp.mCourse.publishedAt!.isEmpty) return DView.empty();
              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: cDetailApp.mCourse.publishedAt!.map((e) {
                  return ActionChip(
                    label: Text(e['web']),
                    backgroundColor: Theme.of(context).primaryColor,
                    onPressed: () async {
                      if (await canLaunchUrl(Uri.parse(e['url'] ?? ''))) {
                        await launchUrl(Uri.parse(e['url'] ?? ''));
                      }
                    },
                  );
                }).toList(),
              );
            }),
          ],
        );
      }),
    );
  }
}
