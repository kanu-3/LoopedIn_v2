import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/utils/app_snackbar.dart';
import 'package:loopedin_v2/core/utils/validators.dart';
import 'package:loopedin_v2/core/widgets/common/app_header.dart';
import 'package:loopedin_v2/core/widgets/fields/app_text_field.dart';
import 'package:loopedin_v2/features/sos/data/models/sos_request_detail_model.dart';
import 'package:loopedin_v2/features/sos/presentation/widgets/sos_bell_header.dart';
import 'package:loopedin_v2/features/sos/presentation/widgets/sos_bottom_bar.dart';
import 'package:loopedin_v2/features/sos/presentation/widgets/sos_duration_selector.dart';
import 'package:loopedin_v2/features/sos/presentation/widgets/sos_section_card.dart';
import 'package:loopedin_v2/features/sos/providers/provider/sos_provider.dart';

class CreateSosScreen extends ConsumerStatefulWidget {
  const CreateSosScreen({super.key});

  @override
  ConsumerState<CreateSosScreen> createState() =>
      _CreateSosScreenState();
}

class _CreateSosScreenState
    extends ConsumerState<CreateSosScreen> {

  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final notesController = TextEditingController();
  final sizeController = TextEditingController();
  final brandController = TextEditingController();
  final styleController = TextEditingController();
  final patternController = TextEditingController();
  final colorController = TextEditingController();
  final descriptionController =
  TextEditingController();

  int duration = 30;

  @override
  void dispose() {
    titleController.dispose();
    notesController.dispose();
    sizeController.dispose();
    brandController.dispose();
    styleController.dispose();
    patternController.dispose();
    colorController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> createSos() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final notifier =
    ref.read(sosProvider.notifier);

    await notifier.createSos(
      title: titleController.text.trim(),
      notes: notesController.text.trim(),
      durationMinutes: duration,
      details: [
        SosRequestDetailModel(
          id: '',
          sosId: '',
          title: titleController.text.trim(),
          size: sizeController.text.trim(),
          brand: brandController.text.trim(),
          style: styleController.text.trim(),
          pattern: patternController.text.trim(),
          color: colorController.text.trim(),
          description:
          descriptionController.text.trim(),
          createdAt: DateTime.now(),
        ),
      ], expiresAt: DateTime.now().add(
      Duration(minutes: duration),
    ),
    );

    if (!mounted) return;

    AppSnackBar.show(
      context,
      message: "SOS created successfully.",
    );

    context.pop();
  }

  @override
  Widget build(BuildContext context) {

    final state = ref.watch(sosProvider);

    return Scaffold(

      appBar: const AppHeader(
        title: "Create SOS",
      ),

      bottomNavigationBar: SosBottomBar(
        primaryText: "Ring Bell",
        onPrimary: createSos,
      ),

      body: Form(

        key: _formKey,

        child: ListView(

          padding: context.bodypad,

          children: [

            const SosBellHeader(
              title: "Ring the Community Bell",
              subtitle:
              "Describe the outfit you need and nearby users can help.",
            ),

            context.gapXS,

            SosSectionCard(

              title: "Outfit Requirement",

              child: Column(

                children: [

                  AppTextField(
                    labelText: "Title",
                    controller: titleController,
                    validator: AppValidators.requiredField,
                  ),

                  context.gapS,

                  AppTextField(
                    labelText: "Notes",
                    controller: notesController,
                    maxLines: 3,
                  ),
                ],
              ),
            ),

            context.gapM,

            SosSectionCard(

              title: "Outfit Details",

              child: Column(

                children: [

                  AppTextField(
                    labelText: "Size",
                    controller: sizeController,
                  ),

                  context.gapS,

                  AppTextField(
                    labelText: "Brand",
                    controller: brandController,
                  ),

                  context.gapS,

                  AppTextField(
                    labelText: "Style",
                    controller: styleController,
                  ),

                  context.gapS,

                  AppTextField(
                    labelText: "Pattern",
                    controller: patternController,
                  ),

                  context.gapS,

                  AppTextField(
                    labelText: "Color",
                    controller: colorController,
                  ),

                  context.gapS,

                  AppTextField(
                    labelText: "Description",
                    controller:
                    descriptionController,
                    maxLines: 4,
                  ),
                ],
              ),
            ),

            context.gapM,

            SosSectionCard(

              title: "SOS Duration",

              child: SosDurationSelector(
                selected: duration,
                onChanged: (v) {
                  setState(() {
                    duration = v;
                  });
                },
              ),
            ),

            context.gapM,


            if (state.isCreating)

              Padding(

                padding: context.padAllXS,

                child: const Center(
                  child:
                  CircularProgressIndicator(),
                ),
              ),

            context.gapXS,
          ],
        ),
      ),
    );
  }
}