import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/core/constants/routes_paths.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/theme/text_theme.dart';
import 'package:loopedin_v2/core/widgets/buttons/app_button.dart';
import 'package:loopedin_v2/core/widgets/buttons/app_outline_button.dart';
import 'package:loopedin_v2/core/widgets/common/app_empty_widget.dart';
import 'package:loopedin_v2/core/widgets/common/app_header.dart';
import 'package:loopedin_v2/features/sos/presentation/widgets/sos_section_card.dart';
import 'package:loopedin_v2/features/sos/presentation/widgets/sos_status_chip.dart';
import 'package:loopedin_v2/features/sos/providers/provider/sos_provider.dart';

class MySosScreen extends ConsumerStatefulWidget {
  const MySosScreen({super.key});

  @override
  ConsumerState<MySosScreen> createState() => _MySosScreenState();
}

class _MySosScreenState extends ConsumerState<MySosScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(sosProvider.notifier).fetchMySos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(sosProvider);

    return Scaffold(
      appBar: const AppHeader(title: "My SOS Requests"),
      body: state.mySos.isEmpty
          ? const AppEmptyWidget(
        title: "No SOS created",
        subtitle: "Create your first SOS request",
      )
          : ListView.separated(
        padding: context.bodypad,
        itemCount: state.mySos.length,
        separatorBuilder: (_, __) => context.gapS,
        itemBuilder: (_, index) {
          final sos = state.mySos[index];

          return SosSectionCard(
            title: sos.request.title,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Sos status : ", style: AppTextTheme.textTheme.headlineSmall,),
                    SizedBox(width: context.scaleW(12),),
                    SosStatusChip(status: sos.request.status),
                  ],
                ),

                context.gapXXS,

                Row(
                  children: [
                    Text("Accepted :", style: AppTextTheme.textTheme.headlineSmall,),
                    SizedBox(width: context.scaleW(12),),
                    Text("${sos.acceptedCount}")
                  ],
                ),

                context.gapM,

                Row(
                  children: [
                    Expanded(
                      child: AppOutlinedButton(
                        text: "Details",
                        onPressed: () {
                          context.push(
                            RoutePaths.sosDetails,
                            extra: sos,
                          );
                        },
                      ),
                    ),

                    context.gapWS,

                    Expanded(
                      child: AppButton(
                        text: "View Users",
                          onPressed: () {
                            context.push(
                              RoutePaths.acceptedUsers,
                              extra: sos,
                            );
                          }
                      ),

                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}