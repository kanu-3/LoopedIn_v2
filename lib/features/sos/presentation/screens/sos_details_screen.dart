import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/core/constants/routes_paths.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/widgets/buttons/app_button.dart';
import 'package:loopedin_v2/core/widgets/common/app_header.dart';
import 'package:loopedin_v2/features/products/presentation/widgets/product_description_section.dart';
import 'package:loopedin_v2/features/sos/data/models/sos_model.dart';
import 'package:loopedin_v2/features/sos/presentation/widgets/sos_details_tile.dart';
import 'package:loopedin_v2/features/sos/presentation/widgets/sos_section_card.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SosDetailsScreen extends ConsumerWidget {
  const SosDetailsScreen({
    super.key,
    required this.sos,
  });

  final SosModel sos;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserId =
        Supabase.instance.client.auth.currentUser!.id;

    final isOwner =
        sos.request.requesterId == currentUserId;

    final detail = sos.details.first;

    return Scaffold(
      appBar: const AppHeader(
        title: "SOS Details",
      ),

      body: ListView(
        padding: context.bodypad,
        children: [
          SosSectionCard(
            title: "SOS Details",
            child: Column(
              children: [
                SosDetailTile(
                  title: "Size",
                  value: detail.size ?? "-",
                ),
                SosDetailTile(
                  title: "Brand",
                  value: detail.brand ?? "-",
                ),
                SosDetailTile(
                  title: "Style",
                  value: detail.style ?? "-",
                ),
                SosDetailTile(
                  title: "Pattern",
                  value: detail.pattern ?? "-",
                ),
                SosDetailTile(
                  title: "Color",
                  value: detail.color ?? "-",
                ),
              ],
            ),
          ),

          context.gapM,

          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: ProductDescriptionSection(
              description: detail.description,
            ),
          ),

          context.gapM,

          SosSectionCard(
            title: "Requested By",
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundImage:
                sos.requester.profilePic != null
                    ? NetworkImage(
                  sos.requester.profilePic!,
                )
                    : null,
              ),
              title: Text(sos.requester.name),
              subtitle: Text(
                "@${sos.requester.username}",
              ),
            ),
          ),

          context.gapL,
        ],
      ),

      bottomNavigationBar: !isOwner
          ? null
          : SafeArea(
        child: Padding(
          padding: context.bodypad,
          child: AppButton(
            text: "View Accepted Users",
              onPressed: () {
                context.push(
                  RoutePaths.acceptedUsers,
                  extra: sos,
                );
              }
          ),
        ),
      ),
    );
  }
}