import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/model/m_app.dart';
import '../../data/model/m_package.dart';
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
        return ListView(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DView.textTitle('Apps'),
                  DView.textAction(
                    () => Get.toNamed('/apps'),
                    color: Colors.blue,
                    iconRight: Icons.arrow_forward,
                    iconRightColor: Colors.blue,
                  ),
                ],
              ),
            ),
            DView.spaceHeight(),
            SizedBox(
              height: 348,
              child: ListView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: cDashboard.listApp.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  MApp mApp = cDashboard.listApp[index];
                  return Padding(
                    padding: EdgeInsets.fromLTRB(
                      index == 0 ? 16 : 8,
                      0,
                      index == cDashboard.listApp.length - 1 ? 16 : 8,
                      0,
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                mApp.cover!,
                                height: 240,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            DView.spaceHeight(),
                            SizedBox(
                              height: 44,
                              child: Text(
                                mApp.name ?? '',
                                style: Theme.of(context).textTheme.titleLarge,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            DView.spaceHeight(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DView.textTitle('Packages'),
                  DView.textAction(
                    () => Get.toNamed('/packages'),
                    color: Colors.blue,
                    iconRight: Icons.arrow_forward,
                    iconRightColor: Colors.blue,
                  ),
                ],
              ),
            ),
            DView.spaceHeight(),
            SizedBox(
              height: 50,
              child: cDashboard.listPackage.isEmpty
                  ? DView.empty()
                  : ListView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: cDashboard.listPackage.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        MPackage mPackage = cDashboard.listPackage[index];
                        return Padding(
                          padding: EdgeInsets.fromLTRB(
                            index == 0 ? 16 : 8,
                            0,
                            index == cDashboard.listPackage.length - 1 ? 16 : 8,
                            0,
                          ),
                          child: Material(
                            borderRadius: BorderRadius.circular(8),
                            child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  mPackage.id ?? '',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      }),
    );
  }
}
