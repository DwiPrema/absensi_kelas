import 'package:absensi_kelas/core/constant/app_colors.dart';
import 'package:absensi_kelas/features/attendance/providers/attendance_export_provider.dart';
import 'package:absensi_kelas/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ExportHistoryPage extends ConsumerStatefulWidget {
  const ExportHistoryPage({super.key});

  @override
  ConsumerState<ExportHistoryPage> createState() => _ExportHistoryPageState();
}

class _ExportHistoryPageState extends ConsumerState<ExportHistoryPage> {
  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();

    final files = ref.watch(attendanceExportProvider);

    return Scaffold(
      backgroundColor: AppColors.grey,
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 120,
              pinned: true,
              backgroundColor: AppColors.blueCard,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      color: AppColors.black.withAlpha(40),
                      child: const Icon(
                        Icons.arrow_back,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.all(12),
                title: Align(
                  alignment: Alignment.bottomRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      textPoppins(
                        "Total File",
                        color: AppColors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                      ),
                      files.when(
                        data: (listFile) {
                          return textPoppins(
                            "${listFile.length} Export",
                            color: AppColors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.w700,
                          );
                        },
                        error: (e, s) => textPoppins("-"),
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
                background: Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 16,
                  ),
                  alignment: Alignment.topCenter,
                  child: textPagratiNarrow(
                    "Riwayat Export",
                    color: AppColors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            files.when(
              data: (fileList) {
                return fileList.isEmpty
                    ? SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Center(
                            child: textPoppins(
                              "Belum ada file export",
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final file = fileList[index];

                          return Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withAlpha(10),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                      color: AppColors.background,
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: const Icon(
                                      Icons.table_chart,
                                      color: AppColors.blueCard,
                                    ),
                                  ),

                                  const SizedBox(width: 14),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        textPoppins(
                                          file.name,
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                        ),
                                        const SizedBox(height: 6),
                                        textPoppins(
                                          DateFormat(
                                            "dd MMM yyyy • HH:mm",
                                            locale,
                                          ).format(file.modified),
                                          color: Colors.grey,
                                          fontSize: 11,
                                        ),
                                        textPoppins(
                                          file.size,
                                          color: Colors.grey,
                                          fontSize: 11,
                                        ),
                                      ],
                                    ),
                                  ),

                                  PopupMenuButton(
                                    color: AppColors.background,
                                    icon: const Icon(Icons.more_vert),
                                    itemBuilder: (context) => [
                                      const PopupMenuItem(
                                        value: "open",
                                        child: Text("Buka"),
                                      ),
                                      const PopupMenuItem(
                                        value: "share",
                                        child: Text("Bagikan"),
                                      ),
                                      const PopupMenuItem(
                                        value: "delete",
                                        child: Text("Hapus"),
                                      ),
                                    ],

                                    onSelected: (value) {
                                      final notifier = ref.read(
                                        attendanceExportProvider.notifier,
                                      );

                                      switch (value) {
                                        case "open":
                                          notifier.openFile(file.file, context);
                                          break;
                                        case "share":
                                          notifier.shareFile(file.file);
                                        case "delete":
                                          notifier.deleteFile(file.file);
                                          break;
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        }, childCount: fileList.length),
                      );
              },
              error: (e, s) => SliverToBoxAdapter(
                child: Center(child: textPoppins("Maaf, Terjadi Kesalahan")),
              ),
              loading: () => SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),
    );
  }
}
