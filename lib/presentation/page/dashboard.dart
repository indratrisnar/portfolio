import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/model/m_app.dart';
import '../controller/c_dashboard.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cDashboard = Get.put(CDashboard());
    return Scaffold(
      appBar: DView.appBarCenter("Indra's Portfolio"),
      body: Obx(() {
        if (cDashboard.loading) return DView.loadingCircle();
        if (cDashboard.listApp.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DView.empty(),
              DView.spaceHeight(),
              IconButton(
                onPressed: () => cDashboard.refreshData(),
                icon: const Icon(Icons.refresh),
              ),
            ],
          );
        }
        return RefreshIndicator(
          onRefresh: () async => cDashboard.refreshData(),
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: cDashboard.listApp.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              mainAxisExtent: 240,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              MApp mApp = cDashboard.listApp[index];
              return GestureDetector(
                onTap: () => Get.offNamed('/detail-app?id=${mApp.id}'),
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
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
