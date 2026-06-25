import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/core_colors.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/theme/text_theme.dart';
import 'package:loopedin_v2/core/widgets/buttons/app_button.dart';

class AddressEditOverlay extends StatefulWidget {
  final String userId;
  final Future<bool> Function({required String table, required String column, required dynamic value}) onSave;

  const AddressEditOverlay({
    super.key,
    required this.userId,
    required this.onSave,
  });

  static void show(BuildContext context, {
    required String userId,
    required Future<bool> Function({required String table, required String column, required dynamic value}) onSave,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddressEditOverlay(userId: userId, onSave: onSave),
    );
  }

  @override
  State<AddressEditOverlay> createState() => _AddressEditOverlayState();
}

class _AddressEditOverlayState extends State<AddressEditOverlay> {
  final _formKey = GlobalKey<FormState>();

  String _addressType = 'Home';
  final TextEditingController _addressLineController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  String? _selectedState;
  bool _isDefault = true;
  bool _isSaving = false;

  final List<String> _indianStates = [
    'Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar', 'Chhattisgarh', 'Goa',
    'Gujarat', 'Haryana', 'Himachal Pradesh', 'Jharkhand', 'Karnataka', 'Kerala',
    'Madhya Pradesh', 'Maharashtra', 'Manipur', 'Meghalaya', 'Mizoram', 'Nagaland',
    'Odisha', 'Punjab', 'Rajasthan', 'Sikkim', 'Tamil Nadu', 'Telangana', 'Tripura',
    'Uttar Pradesh', 'Uttarakhand', 'West Bengal', 'Delhi', 'Jammu & Kashmir', 'Ladakh'
  ];

  @override
  void dispose() {
    _addressLineController.dispose();
    _cityController.dispose();
    _pincodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(24, 24, 24, bottomInset + 24),
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: AppColors.whitetext,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Manage Address Details",
                style: AppTextTheme.textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),

              Text("Address Type", style: AppTextTheme.textTheme.bodySmall?.copyWith(
                color: CoreColors.grey700,
              )),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: ['Home', 'College', 'Office', 'Other'].map((type) {
                  final isSelected = _addressType == type;
                  return ChoiceChip(
                    label: Text(type),
                    selected: isSelected,
                    selectedColor: AppColors.main,
                    labelStyle: TextStyle(color: isSelected ? AppColors.whitetext : AppColors.blacktext),
                    onSelected: (val) {
                      if (val) setState(() => _addressType = type);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _addressLineController,
                maxLines: 2,
                style: TextStyle(color: AppColors.blacktext),
                decoration: _inputDecoration("Street Address / Apartment Details"),
                validator: (v) => v!.isEmpty ? "Required Field" : null,
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: _selectedState,
                style: TextStyle(color: AppColors.blacktext),
                dropdownColor: AppColors.whitetext,
                decoration: _inputDecoration("Select State"),
                items: _indianStates.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                onChanged: (val) => setState(() => _selectedState = val),
                validator: (v) => v == null ? "Please select a state" : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _cityController,
                style: TextStyle(color: AppColors.blacktext),
                decoration: _inputDecoration("City"),
                validator: (v) => v!.isEmpty ? "Required Field" : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _pincodeController,
                style: TextStyle(color: AppColors.blacktext),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(6),
                ],
                decoration: _inputDecoration("Pincode (6 digits)"),
                validator: (v) => v!.length != 6 ? "Enter a valid 6-digit code" : null,
              ),
              const SizedBox(height: 16),

              CheckboxListTile(
                title: const Text("Set as Default Delivery Address"),
                value: _isDefault,
                activeColor: AppColors.main,
                contentPadding: EdgeInsets.zero,
                onChanged: (val) => setState(() => _isDefault = val ?? true),
              ),
              const SizedBox(height: 24),

              AppButton(
                width: double.infinity,
                text: "Save Address",
                onPressed: _submitForm,
                isLoading: _isSaving,
                height: context.scaleH(62),
              )
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: CoreColors.grey200,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.main, width: 1.5)),
    );
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    final Map<String, dynamic> addressPayload = {
      'address_type': _addressType,
      'address_line': _addressLineController.text.trim(),
      'city': _cityController.text.trim(),
      'state': _selectedState,
      'pincode': _pincodeController.text.trim(),
      'is_default': _isDefault,
    };

    final success = await widget.onSave(
      table: 'user_address',
      column: 'structured_payload',
      value: addressPayload,
    );

    if (mounted) {
      setState(() => _isSaving = false);
      if (success) Navigator.pop(context);
    }
  }
}