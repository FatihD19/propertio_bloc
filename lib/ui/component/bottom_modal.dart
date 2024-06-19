// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_single_cascade_in_expression_statements

import 'package:another_flushbar/flushbar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:propertio_bloc/bloc/project/project_bloc.dart';

import 'package:propertio_bloc/bloc/properti/properti_bloc.dart';
import 'package:propertio_bloc/bloc/propertyType/property_type_bloc.dart';
import 'package:propertio_bloc/data/model/agent_model.dart';
import 'package:propertio_bloc/data/model/developer_model.dart';
import 'package:propertio_bloc/data/model/responses/address_response_model.dart';
import 'package:propertio_bloc/data/model/responses/list_propertyType_Response_model.dart';
import 'package:propertio_bloc/injection.dart';
import 'package:propertio_bloc/shared/theme.dart';
import 'package:propertio_bloc/ui/component/button.dart';
import 'package:propertio_bloc/ui/component/dropdown_type.dart';
import 'package:propertio_bloc/ui/component/text_failure.dart';
import 'package:propertio_bloc/ui/component/textfieldForm.dart';
import 'package:propertio_bloc/ui/pages/Properti/properti_page.dart';
import 'package:propertio_bloc/ui/view/info_promo_view.dart';
import 'package:propertio_bloc/ui/view/listile_agen.dart';
import 'package:toggle_switch/toggle_switch.dart';

void showMessageModal(BuildContext context, String message, {Color? color}) {
  Flushbar(
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: color != null ? color : Colors.red,
    duration: const Duration(seconds: 1),
  ).show(context);
}

void confirmDialog(
    BuildContext context, String title, String message, Function() onConfirm) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.warning,
    animType: AnimType.scale,
    title: '$title',
    desc: '$message',
    btnCancelText: 'Batal',
    btnOkOnPress: () {
      onConfirm();
    },
    btnCancelOnPress: () {},
  )..show();
}

void errorDialog(BuildContext context, String message, String title,
    {Function()? onConfirm}) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    animType: AnimType.scale,
    title: '$message',
    btnCancelText: 'Batal',
    btnCancelOnPress: () {},
    btnOkOnPress: () {
      onConfirm!();
    },
  ).show();
}

void succsessDialog(
    BuildContext context, String message, Function() onConfirm) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.success,
    animType: AnimType.scale,
    title: '$message',
    btnOkOnPress: () {
      onConfirm();
    },
  ).show();
}

void showCustomSnackbar(BuildContext context, Widget content,
    {String? type, bool? isProperti}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) => Container(
              // height: 800,
              child: Container(
                  // height: MediaQuery.of(context).size.height * 0.55,
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(25.0),
                      topRight: const Radius.circular(25.0),
                    ),
                  ),
                  child: content)));
    },
  );
}

class ModalFilter extends StatefulWidget {
  bool? isProyek;
  TextEditingController? controller;
  String? selectedItem;
  void Function(String?)? onChanged;
  int? sellOrRent;
  bool? fromHomePage;
  ModalFilter(this.selectedItem, this.onChanged,
      {this.isProyek = false,
      this.sellOrRent,
      this.fromHomePage = false,
      this.controller,
      super.key});

  @override
  State<ModalFilter> createState() => _ModalFilterState();
}

class _ModalFilterState extends State<ModalFilter> {
  int sellOrRent = 0;
  String? _selectedItem;

  void filterSearch(bool isProyek) {
    isProyek == false
        ? context.read<PropertiBloc>().add(OnGetProperti(
            type: widget.selectedItem,
            query: widget.controller!.text,
            isRent: widget.sellOrRent == 1 ? true : false))

        // ? () {

        //   }
        : context.read<ProjectBloc>().add(OnGetProject(
              query: widget.controller!.text,
              type: widget.selectedItem,
            ));
    Navigator.pop(context);
  }

  @override
  // void initState() {
  //   // TODO: implement initState
  //   _selectedItem = widget.selectedItem;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        children: [
          widget.isProyek == true
              ? SizedBox()
              : Column(
                  children: [
                    SizedBox(height: 24),
                    Text(
                      'Filter Pencarian',
                      style: primaryTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
                ),
          SizedBox(height: 16),
          widget.isProyek == true
              ? SizedBox()
              : Center(
                  child: ToggleSwitch(
                    borderColor: [
                      primaryColor,
                    ],
                    minWidth: 176.0,

                    cornerRadius: 20,
                    activeBgColors: [
                      [Colors.white],
                      [Colors.white]
                    ],
                    activeFgColor: primaryColor,
                    inactiveBgColor: primaryColor,
                    inactiveFgColor:
                        Colors.white, // Set inactive text color to white
                    initialLabelIndex: widget.sellOrRent,
                    totalSwitches: 2,
                    customTextStyles: [
                      TextStyle(
                          fontWeight: FontWeight
                              .bold), // Add this line to make the text bold
                      TextStyle(
                          fontWeight: FontWeight
                              .bold), // Add this line to make the text bold
                    ],
                    fontSize: 16,
                    labels: ['Jual', 'Sewa'],
                    radiusStyle: true,
                    onToggle: (index) {
                      widget.sellOrRent = index ?? 1;

                      print('switched to: $index');
                    },
                  ),
                ),
          SizedBox(height: 16),
          Text(
            'Pilih Tipe Properti',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),

          // DropdownType(widget.selectedItem, widget.onChanged),
          DropdownType(widget.selectedItem, (value) {
            setState(() {
              widget.onChanged!(value);
              widget.selectedItem = value;
            });
          }),
          SizedBox(height: 16),
          // Text('${widget.selectedItem}'),
          CustomButton(
              text: 'Cari',
              onPressed: () {
                filterSearch(widget.isProyek!);
                widget.fromHomePage == true
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PropertiPage(
                                fromHomePage: true,
                                isRent: widget.sellOrRent == 1 ? true : false)))
                    : print('from home page: ${widget.fromHomePage}');
              })
        ],
      ),
    );
  }
}
