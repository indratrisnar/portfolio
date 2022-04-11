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
        if (cDashboard.listApp.isEmpty) return DView.empty();
        return GridView.builder(
          itemCount: cDashboard.listApp.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            MApp mApp = cDashboard.listApp[index];
            return Column(
              children: [
                Expanded(
                  child: Image.network(
                    mApp.cover!,
                    fit: BoxFit.contain,
                  ),
                ),
                Text(mApp.name ?? ''),
              ],
            );
          },
        );
      }),
    );
  }
}
