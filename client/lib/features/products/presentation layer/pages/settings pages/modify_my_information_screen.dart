import 'package:client/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/reusable_text.dart';
import '../../../../../core/widgets/reusable_text_field_widget.dart';
import '../../../../authorisation/domain layer/entities/user.dart';
import '../../../../authorisation/presentation layer/bloc/get_cached_user_info/get_cached_user_bloc.dart';
import '../../../../authorisation/presentation layer/bloc/modify my information bloc/modify_my_information_bloc.dart';

class ModifyMyInformationScreen extends StatefulWidget {
  late User user;

  ModifyMyInformationScreen({super.key, required this.user});

  @override
  State<ModifyMyInformationScreen> createState() =>
      _ModifyMyInformationScreenState();
}

class _ModifyMyInformationScreenState extends State<ModifyMyInformationScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _firstNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late ModifyMyInformationBloc _modifyMyInformationBloc;
  late GetCachedUserBloc _getCachedUserBloc;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.user.lastName);
    _firstNameController = TextEditingController(text: widget.user.firstName);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phoneNumber);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _modifyMyInformationBloc = context.read<ModifyMyInformationBloc>();
  }

  @override
  void dispose() {
    if (_nameController.text != widget.user.lastName ||
        _firstNameController.text != widget.user.firstName ||
        _phoneController.text != widget.user.phoneNumber) {
      final user = User.create(
        lastName: _nameController.text,
        firstName: _firstNameController.text,
        email: _emailController.text,
        phoneNumber: _phoneController.text,
        password: '',
        passwordConfirm: '',
      );
      print(user);
      _modifyMyInformationBloc.modifyMyInformationUseCase(user);
      context.read<GetCachedUserBloc>().add(GetCachedUser());
    }
    _nameController.dispose();
    _firstNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            centerTitle: true,
            title: ReusableText(
              text: 'Modifier mes informations',
              textSize: 18.sp,
              textColor: Colors.white,
              textFontWeight: FontWeight.w800,
            ),
            backgroundColor: primaryColor,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15.h),
                        ReusableTextFieldWidget(
                          prefixIcon: Icons.person,
                          paddingValue: 0,
                          errorMessage: "Saisir votre prénom",
                          controller: _firstNameController,
                          hintText: "Flen",
                          suffixIcon: Icon(
                            Icons.edit,
                            color: Colors.grey,
                          ),
                        ),
                        ReusableTextFieldWidget(
                          paddingValue: 0,
                          prefixIcon: Icons.person,
                          errorMessage: "Saisir votre prénom",
                          controller: _nameController,
                          hintText: "Ben Foulen",
                          suffixIcon: Icon(
                            Icons.edit,
                            color: Colors.grey,
                          ),
                        ),
                        ReusableTextFieldWidget(
                          prefixIcon: Icons.phone,
                          paddingValue: 0,
                          keyboardType: TextInputType.phone,
                          errorMessage: "Saisir votre téléphone",
                          controller: _phoneController,
                          hintText: "+216 99 999 999",
                          suffixIcon: Icon(
                            Icons.edit,
                            color: Colors.grey,
                          ),
                        ),
                        ReusableTextFieldWidget(
                          enabled: false,
                          prefixIcon: Icons.email,
                          paddingValue: 0,
                          errorMessage: "Saisir votre email",
                          controller: _emailController,
                          hintText: "Example@gmail.com",
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
