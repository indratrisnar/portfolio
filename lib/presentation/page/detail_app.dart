import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../../data/model/m_app.dart';

class DetailApp extends StatelessWidget {
  const DetailApp({Key? key, required this.mApp}) : super(key: key);
  final MApp mApp;

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: mApp.youtube ?? '1qCrl2-lzTk&t=1s',
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        autoPlay: false,
      ),
    );
    return Scaffold(
      appBar: DView.appBarLeft(mApp.name ?? ""),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DView.textTitle('Download'),
          DView.spaceHeight(12),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: mApp.download!.map((e) {
              return Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () async {
                    if (!await launch(e.url!)) {
                      DInfo.dialogError('Could not launch ${e.url}');
                      DInfo.closeDialog();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!, width: 0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'v${e.version}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          DView.spaceHeight(30),
          DView.textTitle('Description'),
          DView.spaceHeight(12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: mApp.description!.split("//").map((e) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(e, style: Theme.of(context).textTheme.bodyMedium),
              );
            }).toList(),
          ),
          DView.spaceHeight(30 - 4),
          DView.textTitle('Feature'),
          DView.spaceHeight(12),
          Column(
            children: mApp.feature!.map((e) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle, size: 16),
                    DView.spaceWidth(8),
                    Expanded(
                      child: Text(
                        e,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          DView.spaceHeight(30 - 4),
          DView.textTitle('Tools'),
          DView.spaceHeight(12),
          Column(
            children: mApp.tools!.map((e) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle, size: 16),
                    DView.spaceWidth(8),
                    Expanded(
                      child: Text(
                        e,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          DView.spaceHeight(30),
          DView.textTitle('Demo App'),
          DView.spaceHeight(12),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 800,
            ),
            child: YoutubePlayerIFrame(
              controller: _controller,
              aspectRatio: 16 / 9,
            ),
          ),
          DView.spaceHeight(30),
          DView.textTitle('Screenshot'),
          DView.spaceHeight(),
          GridView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: mApp.screenshot!.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 240,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              mainAxisExtent: 400,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => viewScreenshot(mApp.screenshot!, index),
                child: Image.network(
                  mApp.screenshot![index],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void viewScreenshot(List<String> screenshot, int index) {
    PageController controller = PageController(
      initialPage: index,
    );
    Get.dialog(
      Dialog(
        child: Stack(
          children: [
            PageView.builder(
              controller: controller,
              itemCount: screenshot.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InteractiveViewer(
                  child: Image.network(
                    screenshot[index],
                  ),
                );
              },
            ),
            Positioned(
              left: 16,
              top: 16,
              child: SmoothPageIndicator(
                controller: controller,
                count: screenshot.length,
                effect: WormEffect(
                  activeDotColor: Theme.of(Get.context!).primaryColor,
                ),
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 20,
              child: FloatingActionButton(
                heroTag: 'previous',
                onPressed: () {
                  controller.previousPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeIn,
                  );
                },
                child: const Icon(Icons.navigate_before, size: 30),
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              right: 20,
              child: FloatingActionButton(
                heroTag: 'next',
                onPressed: () {
                  controller.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeIn,
                  );
                },
                child: const Icon(Icons.navigate_next, size: 30),
              ),
            ),
            const Align(
              alignment: Alignment.topRight,
              child: CloseButton(),
            ),
          ],
        ),
      ),
    );
  }
}
