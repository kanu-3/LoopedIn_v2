import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loopedin_v2/core/constants/app_colors.dart';
import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/core/constants/product_constants.dart';
import 'package:loopedin_v2/core/constants/routes_paths.dart';
import 'package:loopedin_v2/core/extensions/context_extensions.dart';
import 'package:loopedin_v2/core/models/product_model.dart';
import 'package:loopedin_v2/core/utils/app_snackbar.dart';
import 'package:loopedin_v2/core/utils/validators.dart';
import 'package:loopedin_v2/core/widgets/buttons/app_button.dart';
import 'package:loopedin_v2/core/widgets/common/app_header.dart';
import 'package:loopedin_v2/core/widgets/fields/app_text_field.dart';
import 'package:loopedin_v2/features/products/data/models/product_draft_model.dart';
import 'package:loopedin_v2/features/products/presentation/widgets/product_image_picker.dart';
import 'package:loopedin_v2/features/products/presentation/widgets/product_toggle_tile.dart';
import 'package:loopedin_v2/features/products/presentation/widgets/product_type_selector.dart';
import 'package:loopedin_v2/features/products/presentation/widgets/quantity_selector.dart';
import 'package:loopedin_v2/features/products/providers/providers/add_product_provider.dart';
import 'package:loopedin_v2/features/products/providers/providers/product_provider.dart';

class AddProductScreen extends ConsumerStatefulWidget {
  const AddProductScreen({super.key, this.product,});
  final ProductModel? product;

  @override
  ConsumerState<AddProductScreen> createState() =>
      _AddProductScreenState();
}

class _AddProductScreenState
    extends ConsumerState<AddProductScreen> {

  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final rentPriceController = TextEditingController();
  final brandController = TextEditingController();
  final colorController = TextEditingController();
  final fabricController = TextEditingController();
  final descriptionController = TextEditingController();
  final styleController = TextEditingController();
  final patternController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.product == null) {
      return;
    }

    final product = widget.product!;

    titleController.text = product.title;
    priceController.text = product.price?.toString() ?? '';
    rentPriceController.text = product.rentPricePerDay?.toString() ?? '';
    brandController.text = product.brand ?? '';
    colorController.text = product.color ?? '';
    fabricController.text = product.fabric ?? '';
    descriptionController.text = product.description ?? '';
    styleController.text = product.style ?? '';
    patternController.text = product.pattern ?? '';

    Future.microtask(() {
      ref
          .read(addProductProvider.notifier)
          .loadFromProduct(product);
    });
  }

  @override
  void dispose() {

    titleController.dispose();
    priceController.dispose();
    rentPriceController.dispose();
    brandController.dispose();
    colorController.dispose();
    fabricController.dispose();
    descriptionController.dispose();
    styleController.dispose();
    patternController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final state =
    ref.watch(addProductProvider);

    final notifier =
    ref.read(
      addProductProvider.notifier,
    );

    return Scaffold(

      appBar: AppHeader(
        title: widget.product == null
            ? "Add Product"
            : "Edit Product",
        showCloseButton: false,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: context.bodypad,
          child: Form(
            key: _formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text(
                  "Product Images",
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                context.gapS,

                if (widget.product != null &&
                    widget.product!.images.isNotEmpty) ...[
                  ClipRRect(
                    borderRadius: context.borderRadiusM,
                    child: CachedNetworkImage(
                      imageUrl:
                      widget.product!.images.first,
                      height: context.scaleH(240),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  context.gapM,
                ],

                ProductImagePicker(
                  images: state.images,
                  onChanged: notifier.setImages,
                ),

                context.gapL,

                AppTextField(

                  focusLabelColor: AppColors.main,
                  controller:
                  titleController,
                  labelText:
                  "Product Title",
                  validator: (value) =>
                      AppValidators
                          .requiredField(
                        value,
                        fieldName:
                        "Title",
                      ),
                ),

                context.gapL,

                Text(
                  "Availability",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge,
                ),

                context.gapS,

                ProductTypeSelector(
                  value:
                  state.availability,
                  onChanged: notifier
                      .setAvailability,
                ),

                context.gapL,

                DropdownButtonFormField<
                    String>(
                  value:
                  state.subCategory,

                  decoration:
                  const InputDecoration(
                    labelText:
                    "Sub Category",
                  ),

                  items:
                  ProductConstants
                      .womenSubCategories
                      .map(
                        (e) =>
                        DropdownMenuItem(
                          value: e,
                          child:
                          Text(e),
                        ),
                  )
                      .toList(),

                  onChanged:
                      (value) {

                    if (value ==
                        null) {
                      return;
                    }

                    notifier
                        .setSubCategory(
                      value,
                    );
                  },
                ),

                context.gapL,

                DropdownButtonFormField<
                    String>(
                  value: state.size,

                  decoration:
                  const InputDecoration(
                    labelText:
                    "Size",
                  ),

                  items:
                  ProductConstants
                      .sizes
                      .map(
                        (e) =>
                        DropdownMenuItem(
                          value: e,
                          child:
                          Text(e),
                        ),
                  )
                      .toList(),

                  onChanged:
                      (value) {

                    if (value ==
                        null) {
                      return;
                    }

                    notifier
                        .setSize(
                      value,
                    );
                  },
                ),

                context.gapL,

                DropdownButtonFormField<
                    String>(
                  value:
                  state.productCondition,

                  decoration:
                  const InputDecoration(
                    labelText:
                    "Condition",
                  ),

                  items:
                  ProductConstants
                      .conditions
                      .map(
                        (e) =>
                        DropdownMenuItem(
                          value: e,
                          child:
                          Text(e),
                        ),
                  )
                      .toList(),

                  onChanged:
                      (value) {

                    if (value ==
                        null) {
                      return;
                    }

                    notifier
                        .setCondition(
                      value,
                    );
                  },
                ),

                context.gapL,

                if (state.availability == product_availability.rent ||
                    state.availability == product_availability.both)
                  AppTextField(
                    focusLabelColor: AppColors.main,
                    controller: rentPriceController,
                    labelText: "Rent Price Per Day",
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    ],
                    validator: AppValidators.price,
                  ),

                if (state.availability == product_availability.sell ||
                    state.availability == product_availability.both)
                  AppTextField(
                    focusLabelColor: AppColors.main,
                    controller: priceController,
                    labelText: "Price",
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    ],
                    validator: AppValidators.price,
                  ),

                context.gapL,

                AppTextField(
                  focusLabelColor: AppColors.main,
                  controller: styleController,
                  labelText: "Style",
                ),

                context.gapL,

                AppTextField(
                  focusLabelColor: AppColors.main,
                  controller: patternController,
                  labelText: "Pattern",
                ),

                context.gapL,

                Text(
                  "Quantity",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge,
                ),

                context.gapS,

                QuantitySelector(
                  quantity:
                  state.quantity,
                  onChanged:
                  notifier
                      .setQuantity,
                ),

                context.gapL,

                AppTextField(
                  focusLabelColor: AppColors.main,
                  controller:
                  brandController,
                  labelText:
                  "Brand",
                ),

                context.gapM,

                AppTextField(
                  focusLabelColor: AppColors.main,
                  controller:
                  colorController,
                  labelText:
                  "Color",
                ),

                context.gapM,

                AppTextField(
                  focusLabelColor: AppColors.main,
                  controller:
                  fabricController,
                  labelText:
                  "Fabric",
                ),

                context.gapM,

                AppTextField(
                  focusLabelColor: AppColors.main,
                  controller:
                  descriptionController,
                  labelText:
                  "Description",
                  maxLines: 5,
                  validator:
                  AppValidators
                      .description,
                ),

                context.gapL,

                ProductToggleTile(
                  title:
                  "Express Delivery",
                  value: state
                      .expressDelivery,
                  onChanged:
                  notifier
                      .setExpressDelivery,
                ),

                ProductToggleTile(
                  title:
                  "Alteration",
                  value: state
                      .alteration,
                  onChanged:
                  notifier
                      .setAlteration,
                ),

                ProductToggleTile(
                  title:
                  "Dry Clean",
                  value:
                  state.dryClean,
                  onChanged:
                  notifier
                      .setDryClean,
                ),

                ProductToggleTile(
                  title:
                  "Direct Contact",
                  value: state
                      .directContact,
                  onChanged:
                  notifier
                      .setDirectContact,
                ),

                context.gapL,

                AppButton(
                  width: double.infinity,
                  text: widget.product == null
                      ? "Preview Product"
                      : "Update Product",

                  onPressed: () async{

                if (!_formKey.currentState!.validate()) {
                return;
                }

                final hasExistingImages =
                widget.product?.images.isNotEmpty ?? false;

                final hasNewImages =
                state.images.isNotEmpty;

                if (!hasExistingImages &&
                !hasNewImages) {
                AppSnackBar.show(
                context,
                message:
                'Add at least one image',
                isError: true,
                );
                return;
                }

                if (state.productCondition == null) {
                AppSnackBar.show(
                context,
                message: "Select product condition",
                isError: true,
                );
                return;
                }

                double? sellPrice;
                double? rentPrice;

                switch (state.availability) {

                case product_availability.sell:

                sellPrice = double.parse(
                priceController.text.trim(),
                );

                break;

                case product_availability.rent:

                rentPrice = double.parse(
                rentPriceController.text.trim(),
                );

                break;

                case product_availability.both:

                sellPrice = double.parse(
                priceController.text.trim(),
                );

                rentPrice = double.parse(
                rentPriceController.text.trim(),
                );

                break;
                }

                final draft = ProductDraftModel(
                title: titleController.text.trim(),
                price: sellPrice,
                rentPricePerDay: rentPrice,
                images: state.images,
                availability: state.availability,
                size: state.size,
                subCategory: state.subCategory,
                quantity: state.quantity,
                expressDelivery: state.expressDelivery,
                alteration: state.alteration,
                dryClean: state.dryClean,
                directContact: state.directContact,
                style: styleController.text.trim().isEmpty
                ? null
                    : styleController.text.trim(),
                pattern: patternController.text.trim().isEmpty
                ? null
                    : patternController.text.trim(),
                brand: brandController.text.trim().isEmpty
                ? null
                    : brandController.text.trim(),
                color: colorController.text.trim().isEmpty
                ? null
                    : colorController.text.trim(),
                fabric: fabricController.text.trim().isEmpty
                ? null
                    : fabricController.text.trim(),
                description: descriptionController.text.trim(),
                productCondition: state.productCondition,
                status: product_status.active.name,
                );

                if (widget.product != null) {

                await ref
                    .read(productProvider.notifier)
                    .updateProduct(
                productId: widget.product!.id,
                draft: draft,
                );

                if (context.mounted) {
                AppSnackBar.show(
                context,
                message: 'Product updated successfully',
                );
                context.pop();
                }
                return;
                }

                context.push(
                RoutePaths.productPreview,
                extra: draft,
                );
                },
                ),
                context.gapL,
              ],
            ),
          ),
        ),
      ),
    );
  }
}