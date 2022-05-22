import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/model/m_package.dart';
import '../../controller/c_packages.dart';

class Packages extends StatelessWidget {
  const Packages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cPackage = Get.put(CPackages());
    return Scaffold(
      appBar: DView.appBarLeft('Packages'),
      body: Obx(() {
        if (cPackage.loading) return DView.loadingCircle();
        if (cPackage.list.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DView.empty(),
              DView.spaceHeight(),
              IconButton(
                onPressed: () => cPackage.refreshData(),
                icon: const Icon(Icons.refresh),
              ),
            ],
          );
        }
        return RefreshIndicator(
          onRefresh: () async => cPackage.refreshData(),
          child: ListView.separated(
            itemCount: cPackage.list.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              MPackage mPackage = cPackage.list[index];
              return ListTile(
                onTap: () async {
                  if (await canLaunchUrl(Uri.parse(mPackage.url ?? ''))) {
                    await launchUrl(Uri.parse(mPackage.url ?? ''));
                  }
                },
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text(mPackage.id ?? ""),
                subtitle: Text(mPackage.description ?? ""),
                trailing: const Icon(Icons.navigate_next),
              );
            },
          ),
        );
      }),
    );
  }
}
