import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo_structure/core/locator.dart';
import 'package:flutter_demo_structure/generated/l10n.dart';
import 'package:flutter_demo_structure/res.dart';
import 'package:flutter_demo_structure/router/app_router.dart';
import 'package:flutter_demo_structure/ui/auth/login/sign_up_widget.dart';
import 'package:flutter_demo_structure/values/export.dart';
import 'package:flutter_demo_structure/widget/button_widget_inverse.dart';
import 'package:flutter_demo_structure/widget/text_form_filed.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final bool _isHidden = true;
  late GlobalKey<FormState> _formKey;
  late TextEditingController nameController,
      emailController,
      mobileController,
      passwordController,
      confPasswordController;
  late FocusNode mobileNode;
  ValueNotifier<bool> showLoading = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isRead = ValueNotifier<bool>(false);

  late List<ReactionDisposer> _disposers;

  bool get isCurrent => !ModalRoute.of(context)!.isCurrent;

  var socialId, type = "S";
  Country _selectedDialogCountry = CountryPickerUtils.getCountryByIsoCode('IN');

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    nameController = TextEditingController();
    emailController = TextEditingController();
    mobileController = TextEditingController();
    passwordController = TextEditingController();
    confPasswordController = TextEditingController();
    mobileNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    confPasswordController.dispose();
    mobileNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 0, left: 30, right: 30).r,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                30.0.verticalSpace,
                getHeaderContent(),
                getSignUpForm(),
                40.0.verticalSpace,
                SignUpWidget(
                  fromLogin: false,
                  onTap: () => Navigator.of(context).pop(),
                ),
                40.0.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getHeaderContent() {
    return Column(
      children: [
        10.0.verticalSpace,
        Text(
          S.current.signUp.toUpperCase(),
          style: textBold.copyWith(
            color: AppColor.primaryColor,
            fontSize: 24.sp,
          ),
        ),
        10.0.verticalSpace,
        Text(
          S.current.fillDetails,
          style: textLight.copyWith(
            color: AppColor.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget getSignUpForm() {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            25.0.verticalSpace,
            AppTextField(
              controller: nameController,
              label: S.current.name,
              hint: S.current.name,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.sentences,
              validators: nameValidator,
              prefixIcon: IconButton(
                onPressed: null,
                icon: Image.asset(
                  Res.user,
                  color: AppColor.primaryColor,
                  height: 26.0,
                  width: 26.0,
                ),
              ),
            ),
            10.0.verticalSpace,
            AppTextField(
              controller: emailController,
              label: S.current.email,
              hint: S.current.email,
              keyboardType: TextInputType.emailAddress,
              validators: emailValidator,
              prefixIcon: IconButton(
                onPressed: null,
                icon: Image.asset(
                  Res.email,
                  color: AppColor.primaryColor,
                  height: 26.0,
                  width: 26.0,
                ),
              ),
            ),
            10.0.verticalSpace,
            AppTextField(
              controller: mobileController,
              label: S.current.mobNumber,
              hint: S.current.mobNumber,
              keyboardType: TextInputType.phone,
              validators: mobileValidator,
              focusNode: mobileNode,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                LengthLimitingTextInputFormatter(10),
              ],
              prefixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: null,
                    icon: Image.asset(
                      Res.mobile,
                      color: AppColor.primaryColor,
                      height: 26.0,
                      width: 26.0,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async => {
                      Future.delayed(Duration.zero, () {
                        mobileNode.unfocus();
                        mobileNode.canRequestFocus = false;
                      }),
                      await _openCountryPickerDialog(),
                      mobileNode.canRequestFocus = true,
                    },
                    child: Row(
                      children: [
                        Text(
                          '+${_selectedDialogCountry.phoneCode}',
                          style: textMedium.copyWith(
                            fontSize: 15.sp,
                          ),
                        ),
                        2.0.horizontalSpace,
                        Image.asset(
                          Res.arrow_down,
                          color: AppColor.osloGray,
                          height: 8.0,
                          width: 8.0,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 12.0,
                    color: Colors.grey,
                    width: 1.5,
                  ),
                ],
              ),
            ),
            10.0.verticalSpace,
            AppTextField(
              label: S.current.password,
              hint: S.current.password,
              obscureText: _isHidden,
              validators: passwordValidator,
              controller: passwordController,
              keyboardType: TextInputType.visiblePassword,
              keyboardAction: TextInputAction.next,
              maxLines: 1,
              maxLength: 15,
              prefixIcon: IconButton(
                onPressed: null,
                icon: Image.asset(
                  Res.password,
                  color: AppColor.primaryColor,
                  height: 26.0,
                  width: 26.0,
                ),
              ),
            ),
            10.0.verticalSpace,
            AppTextField(
              label: S.current.confPassword,
              hint: S.current.confPassword,
              obscureText: _isHidden,
              validators: confPasswordValidator,
              controller: confPasswordController,
              keyboardType: TextInputType.visiblePassword,
              keyboardAction: TextInputAction.done,
              maxLines: 1,
              maxLength: 15,
              prefixIcon: IconButton(
                onPressed: null,
                icon: Image.asset(
                  Res.password,
                  color: AppColor.primaryColor,
                  height: 26.0,
                  width: 26.0,
                ),
              ),
            ),
            16.0.verticalSpace,
            ValueListenableBuilder<bool>(
              valueListenable: _isRead,
              builder: (context, bool value, child) => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedContainer(
                    height: 20.0,
                    width: 20.0,
                    duration: const Duration(milliseconds: 300),
                    child: IconButton(
                      splashColor: AppColor.transparent,
                      padding: EdgeInsets.zero,
                      icon: Image.asset(
                        Res.checked_box,
                        color:
                            value ? AppColor.primaryColor : AppColor.osloGray,
                      ),
                      onPressed: () => _isRead.value = !value,
                    ),
                  ),
                  8.0.horizontalSpace,
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: S.current.iAgree,
                        style: textLight.copyWith(
                          color: AppColor.grey,
                          fontSize: 14.sp,
                        ),
                        children: <InlineSpan>[
                          TextSpan(
                            text: S.current.tNc,
                            style: textSemiBold.copyWith(
                              fontSize: 14.sp,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(S.current.tNc)));
                              },
                          ),
                          TextSpan(
                            text: S.current.and,
                          ),
                          TextSpan(
                            text: S.current.privacyPolicy,
                            style: textSemiBold.copyWith(
                              fontSize: 14.sp,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text(S.current.privacyPolicy)));
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            18.0.verticalSpace,
            AppButtonInverse(
              S.current.signUp.toUpperCase(),
              () {
                //navigator.pushNamed(RouteName.otpVerificationPage);
                if (_formKey.currentState!.validate()) {
                  if (passwordController.text.trim() !=
                      confPasswordController.text.trim()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(S.current.passwordMismatch)));

                    return;
                  }
                  if (!_isRead.value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(S.current.acceptTnC)));

                    return;
                  }
                  signUpAndNavigateToHome();
                }
              },
              elevation: 0.0,
            ),
          ],
        ),
      ),
    );
  }

  signUpAndNavigateToHome() async {
    locator<AppRouter>().push(const HomeRoute());
  }

  removeDisposer() {
    for (var element in _disposers) {
      element.reaction.dispose();
    }
  }

  Widget _buildDialogItem(Country country) => Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          const SizedBox(width: 8.0),
          Text("+${country.phoneCode}"),
          const SizedBox(width: 8.0),
          Flexible(child: Text(country.name))
        ],
      );

  Future _openCountryPickerDialog() => showDialog(
        context: context,
        builder: (context) => CountryPickerDialog(
          titlePadding: const EdgeInsets.all(8.0),
          searchCursorColor: Colors.lightBlueAccent,
          searchInputDecoration: const InputDecoration(hintText: 'Search...'),
          isSearchable: true,
          title: const Text('Select your phone code'),
          onValuePicked: (Country country) =>
              setState(() => _selectedDialogCountry = country),
          itemBuilder: _buildDialogItem,
          priorityList: [
            CountryPickerUtils.getCountryByIsoCode('US'),
            CountryPickerUtils.getCountryByIsoCode('IN'),
          ],
        ),
      );
}
