import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/utils/app_snackbar.dart';
import 'package:loopedin_v2/core/widgets/buttons/app_button.dart';
import 'package:loopedin_v2/core/widgets/common/app_empty_widget.dart';
import 'package:loopedin_v2/core/widgets/common/app_header.dart';
import 'package:loopedin_v2/core/widgets/dialogs/confirm_dialog.dart';
import 'package:loopedin_v2/features/chat/providers/provider/chat_provider.dart';
import 'package:loopedin_v2/features/profile/data/repositories/profile_repository.dart';
import 'package:loopedin_v2/features/sos/data/models/sos_model.dart';
import 'package:loopedin_v2/features/sos/presentation/widgets/sos_user_card.dart';
import 'package:loopedin_v2/features/sos/providers/provider/sos_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AcceptedUsersScreen extends ConsumerWidget {
  const AcceptedUsersScreen({
    super.key,
    required this.sos,
  });

  final SosModel sos;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isClosed = sos.request.status != SosStatus.open;

    return Scaffold(

      appBar: const AppHeader(
        title: "Accepted Users",
      ),

      body: sos.acceptedUsers.isEmpty
          ? const AppEmptyWidget(
        title: "No Responses Yet",
        subtitle:
        "No one has accepted your SOS.",
      )
          : ListView.separated(

        padding: context.bodypad,

        itemCount:
        sos.acceptedUsers.length,

        separatorBuilder:
            (_, __) =>
        context.gapS,

        itemBuilder:
            (_, index) {

          final user =
          sos.acceptedUsers[index];

          return SosUserCard(

            user: user,

              onChat: () async {

                final profile = await ref
                    .read(profileRepositoryProvider)
                    .fetchProfile(user.userId);

                final roomId = await ref
                    .read(chatRepositoryProvider)
                    .getOrCreateRoom(
                  Supabase.instance.client.auth.currentUser!.id,
                  user.userId,
                );

                if (!context.mounted) return;

                context.push(
                  "/chat/$roomId",
                  extra: {
                    "otherUser": profile,
                  },
                );
              },
          );
        },
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: context.bodypad,
          child: AppButton(
            text: isClosed ? "SOS Closed" : "End SOS",
            onPressed: isClosed
                ? null
                : () async {

              final ok = await ConfirmDialog.show(
                context: context,
                title: "End SOS?",
                message: "This will close the SOS request.",
              );

              if (ok != true) return;

              await ref
                  .read(sosProvider.notifier)
                  .closeSos(sos.request.id);

              if (!context.mounted) return;

              AppSnackBar.show(
                context,
                message: "SOS ended successfully.",
              );

              context.pop();
            },
          ),
        ),
      ),
    );
  }
}