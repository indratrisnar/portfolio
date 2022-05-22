import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/model/m_app.dart';
import '../../data/model/m_course.dart';
import '../../data/model/m_package.dart';
import '../controller/c_dashboard.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cDashboard = Get.put(CDashboard());
    return Scaffold(
      appBar: DView.appBarCenter("Indra's Portfolio"),
      drawer: Obx(() {
        if (cDashboard.profile.isEmpty) return const Drawer();
        return Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: Image.network(
                        cDashboard.profile['image'],
                        fit: BoxFit.cover,
                        height: 80,
                        width: 80,
                      ),
                    ),
                    DView.spaceHeight(),
                    Text(
                      cDashboard.profile['name'],
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    DView.spaceHeight(4),
                    Text(
                      cDashboard.profile['position'],
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: Colors.white70,
                          ),
                    ),
                  ],
                ),
              ),
              ListTile(
                onTap: () async {
                  List emails = cDashboard.profile['email'];
                  Get.dialog(SimpleDialog(
                    title: const Text('Email'),
                    titlePadding: const EdgeInsets.all(16),
                    contentPadding: const EdgeInsets.only(bottom: 16),
                    children: emails.map((e) {
                      return ListTile(
                        title: Text(e['for']),
                        subtitle: Text(e['email']),
                        onTap: () {
                          final Uri emailLaunchUri = Uri(
                            scheme: 'mailto',
                            path: e['email'],
                          );
                          launchUrl(emailLaunchUri);
                        },
                        trailing: const Icon(Icons.navigate_next),
                      );
                    }).toList(),
                  ));
                },
                horizontalTitleGap: 0,
                title: const Text('Email'),
                trailing: const Icon(Icons.navigate_next),
              ),
              ListTile(
                onTap: () async {
                  String url = cDashboard.profile['linkedin'] ?? '';
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url));
                  }
                },
                horizontalTitleGap: 0,
                title: const Text('LinkedIn'),
                trailing: const Icon(Icons.navigate_next),
              ),
              ListTile(
                onTap: () async {
                  String url = cDashboard.profile['github'] ?? '';
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url));
                  }
                },
                horizontalTitleGap: 0,
                title: const Text('Github'),
                trailing: const Icon(Icons.navigate_next),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Learning With Me',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.white70,
                          ),
                    ),
                    DView.spaceHeight(4),
                    Divider(
                      height: 1,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children:
                      List.castFrom(cDashboard.profile['learning_with_me'])
                          .map((e) {
                    return ActionChip(
                      label: Text(e['web']),
                      backgroundColor: Theme.of(context).primaryColor,
                      onPressed: () async {
                        if (await canLaunchUrl(Uri.parse(e['url']))) {
                          await launchUrl(Uri.parse(e['url']));
                        }
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      }),
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
                    child: GestureDetector(
                      onTap: () => Get.toNamed('/detail-app?id=${mApp.id}'),
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
                              onTap: () async {
                                if (await canLaunchUrl(
                                    Uri.parse(mPackage.url!))) {
                                  await launchUrl(Uri.parse(mPackage.url!));
                                }
                              },
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
            DView.spaceHeight(50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DView.textTitle('Courses'),
                  DView.textAction(
                    () => Get.toNamed('/courses'),
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
              child: cDashboard.listCourse.isEmpty
                  ? DView.empty()
                  : ListView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: cDashboard.listCourse.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        MCourse mCourse = cDashboard.listCourse[index];
                        return Padding(
                          padding: EdgeInsets.fromLTRB(
                            index == 0 ? 16 : 8,
                            0,
                            index == cDashboard.listApp.length - 1 ? 16 : 8,
                            0,
                          ),
                          child: GestureDetector(
                            onTap: () => Get.toNamed(
                                '/detail-course?id=${mCourse.idCourse}'),
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
                                        mCourse.cover!,
                                        height: 240,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                    DView.spaceHeight(),
                                    ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        maxWidth: 400,
                                      ),
                                      child: SizedBox(
                                        height: 44,
                                        child: Text(
                                          mCourse.name ?? '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
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
