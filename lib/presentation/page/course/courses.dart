import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/model/m_course.dart';
import '../../controller/c_courses.dart';

class Courses extends StatelessWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cCourses = Get.put(CCourses());
    return Scaffold(
      appBar: DView.appBarLeft('Courses'),
      body: Obx(() {
        if (cCourses.loading) return DView.loadingCircle();
        if (cCourses.list.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DView.empty(),
              DView.spaceHeight(),
              IconButton(
                onPressed: () => cCourses.refreshData(),
                icon: const Icon(Icons.refresh),
              ),
            ],
          );
        }
        return RefreshIndicator(
          onRefresh: () async => cCourses.refreshData(),
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: cCourses.list.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              mainAxisExtent: 240,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              MCourse mCourse = cCourses.list[index];
              return GestureDetector(
                onTap: () =>
                    Get.toNamed('/detail-course?id=${mCourse.idCourse}'),
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          mCourse.cover!,
                          width: double.maxFinite,
                          height: double.maxFinite,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    DView.spaceHeight(),
                    Text(
                      mCourse.name ?? '',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
