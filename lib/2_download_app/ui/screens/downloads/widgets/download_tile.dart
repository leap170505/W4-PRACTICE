import 'package:flutter/material.dart';

import 'download_controler.dart';

class DownloadTile extends StatelessWidget {
  const DownloadTile({super.key, required this.controller});

  final DownloadController controller;

  // TODO

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        return Card(
          margin: const EdgeInsets.all(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildText(),
                _buildIcon()
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildText() {
    final percent = (controller.progress * 100);
    final downloadedSize = controller.ressource.size * controller.progress;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          controller.ressource.name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 6),

        if (controller.status != DownloadStatus.notDownloaded)
          Text(
            "${percent.toStringAsFixed(1)} % completed - "
            "${downloadedSize.toStringAsFixed(1)} of "
            "${controller.ressource.size.toStringAsFixed(1)} MB",
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
      ],
    );
  }

  Widget _buildIcon() {
    switch (controller.status) {
      case DownloadStatus.notDownloaded:
        return IconButton(
          icon: const Icon(Icons.download),
          onPressed: controller.startDownload,
        );

      case DownloadStatus.downloading:
        return const Icon(Icons.downloading);

      case DownloadStatus.downloaded:
        return const Icon(Icons.folder);
    }
  }
}
