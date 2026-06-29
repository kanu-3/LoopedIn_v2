import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart' show ContextExtensions;
import 'package:loopedin_v2/core/utils/app_snackbar.dart';
import 'package:loopedin_v2/core/widgets/buttons/app_button.dart';
import 'package:loopedin_v2/core/widgets/common/app_header.dart';
import 'package:loopedin_v2/features/chat/providers/provider/chat_provider.dart';
import 'package:loopedin_v2/features/sos/data/models/sos_model.dart';
import 'package:loopedin_v2/features/sos/presentation/widgets/sos_details_tile.dart';
import 'package:loopedin_v2/features/sos/presentation/widgets/sos_section_card.dart';
import 'package:loopedin_v2/features/sos/presentation/widgets/sos_user_card.dart';
import 'package:loopedin_v2/features/sos/providers/provider/sos_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SosStatusScreen extends ConsumerWidget {
  const SosStatusScreen({
    super.key,
    required this.sos,
  });

  final SosModel sos;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpired =
    sos.request.expiresAt.isBefore(DateTime.now());

    final isClosed = sos.request.status != SosStatus.open;

    return Scaffold(
      appBar: const AppHeader(title: "SOS Status"),

      body: ListView(
        padding: context.bodypad,
        children: [
          SosSectionCard(
            title: "SOS Info",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SosDetailTile(
                  title: "Title",
                  value: sos.request.title,
                ),
                SosDetailTile(
                  title: "Status",
                  value: isClosed
                      ? "Closed"
                      : isExpired
                      ? "Expired"
                      : "Active",
                ),
                SosDetailTile(
                  title: "Accepted",
                  value: "${sos.acceptedUsers.length}",
                ),
              ],
            ),
          ),

          context.gapM,

          SosSectionCard(
            title: "Volunteers",
            child: sos.acceptedUsers.isEmpty
                ? const Text("No volunteers yet")
                : Column(
              children: sos.acceptedUsers.map((u) {
                return SosUserCard(
                  user: u,
                  onChat: () async {
                    final roomId = await ref
                        .read(chatRepositoryProvider)
                        .getOrCreateRoom(
                      Supabase.instance.client.auth
                          .currentUser!.id,
                      u.userId,
                    );

                    if (!context.mounted) return;

                    context.push(
                      "/chat/$roomId",
                      extra: {"otherUser": u},
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: context.bodypad,
          child: AppButton(
            text: "End SOS",
            onPressed: isClosed
                ? null
                : () async {
              await ref
                  .read(sosProvider.notifier)
                  .closeSos(sos.request.id);

              if (!context.mounted) return;

              AppSnackBar.show(
                context,
                message: "SOS closed",
              );

              context.pop();
            },
          ),
        ),
      ),
    );
  }
}