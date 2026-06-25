import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/asset_paths.dart';
import 'package:loopedin_v2/core/constants/core_colors.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';

class ProfileEditOverlay extends StatefulWidget {
  final String title;
  final String initialValue;
  final String table;
  final String column;
  final Future<bool> Function({required String table, required String column, required dynamic value}) onSave;

  const ProfileEditOverlay({
    super.key,
    required this.title,
    required this.initialValue,
    required this.table,
    required this.column,
    required this.onSave,
  });

  static void show(
      BuildContext context, {
        required String title,
        required String initialValue,
        required String table,
        required String column,
        required Future<bool> Function({required String table, required String column, required dynamic value}) onSave,
      }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ProfileEditOverlay(
        title: title,
        initialValue: initialValue,
        table: table,
        column: column,
        onSave: onSave,
      ),
    );
  }

  @override
  State<ProfileEditOverlay> createState() => _ProfileEditOverlayState();
}

class _ProfileEditOverlayState extends State<ProfileEditOverlay> {
  late TextEditingController _controller;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(24, 24, 24, bottomInset + 24),
      decoration: const BoxDecoration(
        color: AppColors.whitetext,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Edit ${widget.title}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blacktext,
                ),
              ),
              if (_controller.text.isNotEmpty)
                IconButton(
                  icon: Icon(AssetPaths.cross, size: context.scaleH(20),),
                  onPressed: () => setState(() => _controller.clear()),
                ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            autofocus: true,
            style: TextStyle(color: AppColors.blacktext),
            decoration: InputDecoration(
              hintText: "Enter your ${widget.title.toLowerCase()}",
              filled: true,
              fillColor: CoreColors.grey200,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.main, width: 1.5),
              ),
            ),
            onChanged: (text) => setState(() {}),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.main,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _isSaving
                  ? null
                  : () async {
                setState(() => _isSaving = true);

                final success = await widget.onSave(
                  table: widget.table,
                  column: widget.column,
                  value: _controller.text.trim(),
                );

                if (mounted) {
                  setState(() => _isSaving = false);
                  if (success) Navigator.pop(context);
                }
              },
              child: _isSaving
                  ? const CircularProgressIndicator(color: AppColors.whitetext)
                  : const Text(
                "Save Changes",
                style: TextStyle(color: AppColors.whitetext, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}