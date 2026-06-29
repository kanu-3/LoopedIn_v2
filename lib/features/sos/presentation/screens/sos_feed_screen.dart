import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/core/constants/routes_paths.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/theme/text_theme.dart';
import 'package:loopedin_v2/core/utils/app_snackbar.dart';
import 'package:loopedin_v2/core/widgets/buttons/app_button.dart';
import 'package:loopedin_v2/core/widgets/buttons/app_outline_button.dart';
import 'package:loopedin_v2/core/widgets/common/app_empty_widget.dart';
import 'package:loopedin_v2/core/widgets/common/app_header.dart';
import 'package:loopedin_v2/features/sos/presentation/widgets/sos_section_card.dart';
import 'package:loopedin_v2/features/sos/presentation/widgets/sos_status_chip.dart';
import 'package:loopedin_v2/features/sos/providers/provider/sos_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SosFeedScreen extends ConsumerStatefulWidget {
  const SosFeedScreen({super.key});

  @override
  ConsumerState<SosFeedScreen> createState() =>
      _SosFeedScreenState();
}

class _SosFeedScreenState
    extends ConsumerState<SosFeedScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      print("Opening SOS Feed...");
      await ref.read(sosProvider.notifier).fetchFeed();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(sosProvider);

    final currentUserId =
        Supabase.instance.client.auth.currentUser!.id;

    return Scaffold(
      appBar: const AppHeader(
        title: "Incoming SOS",
      ),

      body: state.isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : state.feed.isEmpty
          ? const AppEmptyWidget(
        title: "No SOS requests",
        subtitle: "Everything is calm right now",
      )
          : ListView.separated(
        padding: context.bodypad,
        itemCount: state.feed.length,
        separatorBuilder: (_, __) => context.gapS,
        itemBuilder: (_, index) {
          final sos = state.feed[index];

          final response =
          state.myResponses[sos.request.id];

          final accepted =
              response ==
                  SosResponseStatus.accepted;

          final declined =
              response ==
                  SosResponseStatus.declined;

          final isOwner =
              sos.request.requesterId ==
                  currentUserId;

          return SosSectionCard(
            title: sos.request.title,
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                Text(
                    "By: ${sos.requester.name}"),

                context.gapS,

                Row(
                  children: [
                    const Text("Status: "),
                    SizedBox(
                        width:
                        context.scaleW(8)),
                    SosStatusChip(
                      status:
                      sos.request.status,
                    ),
                  ],
                ),

                context.gapL,

                if (!isOwner)
                  Row(
                    children: [

                      Expanded(
                        child:
                        AppOutlinedButton(
                          text: "Decline",
                          onPressed: declined
                              ? null
                              : () async {

                            await ref
                                .read(
                                sosProvider
                                    .notifier)
                                .declineSos(
                              sos.request
                                  .id,
                            );

                            if (!context
                                .mounted) {
                              return;
                            }

                            AppSnackBar.show(
                              context,
                              message:
                              "Declined",
                            );
                          },
                        ),
                      ),

                      context.gapWS,

                      Expanded(
                        child: AppButton(
                          text: "Accept",
                          onPressed: accepted
                              ? null
                              : () async {

                            await ref
                                .read(
                                sosProvider
                                    .notifier)
                                .acceptSos(
                              sos.request
                                  .id,
                            );

                            if (!context
                                .mounted) {
                              return;
                            }

                            AppSnackBar.show(
                              context,
                              message:
                              "Accepted",
                            );
                          },
                        ),
                      ),
                    ],
                  )
                else
                  const Text(
                    "Your SOS Request",
                    style: TextStyle(
                      fontWeight:
                      FontWeight.w600,
                    ),
                  ),

                context.gapS,

                AppButton(
                  width: double.infinity,
                  variant:
                  ButtonVariant.white,
                  text: "View Details",
                  onPressed: () {
                    context.push(
                      RoutePaths.sosDetails,
                      extra: sos,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}