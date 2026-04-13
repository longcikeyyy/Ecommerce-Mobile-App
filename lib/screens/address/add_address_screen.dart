import 'package:ecommerce_mobile_app/cubit/address/address_cubit.dart';
import 'package:ecommerce_mobile_app/cubit/address/address_state.dart';
import 'package:ecommerce_mobile_app/di/injector.dart';
import 'package:ecommerce_mobile_app/models/response/address_response.dart';
import 'package:ecommerce_mobile_app/shared/app_button.dart';
import 'package:ecommerce_mobile_app/shared/app_text_field.dart';
import 'package:ecommerce_mobile_app/theme/app_colors.dart';
import 'package:ecommerce_mobile_app/theme/app_typography.dart';
import 'package:ecommerce_mobile_app/core/utils/validator_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AddAddressScreen extends StatefulWidget {
  final AddressResponseModel? address;

  const AddAddressScreen({super.key, this.address});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _streetController;
  late final TextEditingController _cityController;
  late final TextEditingController _stateController;
  late final TextEditingController _zipCodeController;

  bool get _isEditing => widget.address != null;

  @override
  void initState() {
    super.initState();
    _streetController =
        TextEditingController(text: widget.address?.streetAddress ?? '');
    _cityController =
        TextEditingController(text: widget.address?.city ?? '');
    _stateController =
        TextEditingController(text: widget.address?.state ?? '');
    _zipCodeController =
        TextEditingController(text: widget.address?.zipCode ?? '');
  }

  @override
  void dispose() {
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    super.dispose();
  }

  void _onSave(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    final cubit = context.read<AddressCubit>();

    if (_isEditing) {
      cubit.updateAddress(
        addressId: widget.address!.id,
        streetAddress: _streetController.text.trim(),
        city: _cityController.text.trim(),
        state: _stateController.text.trim(),
        zipCode: _zipCodeController.text.trim(),
      );
    } else {
      cubit.addAddress(
        streetAddress: _streetController.text.trim(),
        city: _cityController.text.trim(),
        state: _stateController.text.trim(),
        zipCode: _zipCodeController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AddressCubit>(),
      child: BlocListener<AddressCubit, AddressState>(
        listener: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
          }

          if (state.isSaveSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(
                    _isEditing
                        ? 'Address updated successfully!'
                        : 'Address added successfully!',
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            context.pop(true);
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: Column(
              children: [
                _buildAppBar(context),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 16.h),
                          AppTextField(
                            hintText: 'Street Address',
                            controller: _streetController,
                            validator: (value) =>
                                ValidatorUtils.validateRequired(
                              value,
                              fieldName: 'Street Address',
                            ),
                          ),
                          SizedBox(height: 16.h),
                          AppTextField(
                            hintText: 'City',
                            controller: _cityController,
                            validator: (value) =>
                                ValidatorUtils.validateRequired(
                              value,
                              fieldName: 'City',
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            children: [
                              Expanded(
                                child: AppTextField(
                                  hintText: 'State',
                                  controller: _stateController,
                                  validator: (value) =>
                                      ValidatorUtils.validateRequired(
                                    value,
                                    fieldName: 'State',
                                  ),
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: AppTextField(
                                  hintText: 'Zip Code',
                                  controller: _zipCodeController,
                                  keyboardType: TextInputType.number,
                                  validator: (value) =>
                                      ValidatorUtils.validateRequired(
                                    value,
                                    fieldName: 'Zip Code',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(24.w),
                  child: BlocBuilder<AddressCubit, AddressState>(
                    builder: (context, state) {
                      return AppButton(
                        text: 'Save',
                        isLoading: state.isSaving,
                        onPressed: () => _onSave(context),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              width: 36.r,
              height: 36.r,
              decoration: const BoxDecoration(
                color: AppColors.lightGrey,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 16.r,
                color: AppColors.darkGrey,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                _isEditing ? 'Edit Address' : 'Add Address',
                style: AppTypography.headline3,
              ),
            ),
          ),
          SizedBox(width: 36.r),
        ],
      ),
    );
  }
}
