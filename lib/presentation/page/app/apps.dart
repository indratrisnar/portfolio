import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/m_app.dart';
import '../../controller/c_apps.dart';

class Apps extends StatelessWidget {
  const Apps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cApps = Get.put(CApps());
    return Scaffold(
      appBar: DView.appBarLeft('Apps'),
      body: Obx(() {
        if (cApps.loading) return DView.loadingCircle();
        if (cApps.list.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DView.empty(),
              DView.spaceHeight(),
              IconButton(
                onPressed: () => cApps.refreshData(),
                icon: const Icon(Icons.refresh),
              ),
            ],
          );
        }
        return RefreshIndicator(
          onRefresh: () async => cApps.refreshData(),
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: cApps.list.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              mainAxisExtent: 240,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              MApp mApp = cApps.list[index];
              return GestureDetector(
                onTap: () => Get.toNamed('/detail-app?id=${mApp.id}'),
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          mApp.cover!,
                          width: double.maxFinite,
                          height: double.maxFinite,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    DView.spaceHeight(),
                    Text(
                      mApp.name ?? '',
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
