import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertio_bloc/bloc/properti/properti_bloc.dart';
import 'package:propertio_bloc/bloc/propertyType/property_type_bloc.dart';
import 'package:propertio_bloc/shared/theme.dart';
import 'package:propertio_bloc/ui/component/bottom_modal.dart';
import 'package:propertio_bloc/ui/component/button.dart';
import 'package:propertio_bloc/ui/component/dropdown_type.dart';
import 'package:propertio_bloc/ui/component/text_failure.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SearchForm extends StatefulWidget {
  TextEditingController? controller;
  String? selectedItem;
  void Function(String?)? onChanged;
  VoidCallback? action;
  bool? justSearch;
  bool? isProyek;
  int? sellOrRent;
  bool? fromHomePage;
  String? hintText;
  SearchForm(
      {this.controller,
      this.selectedItem,
      this.onChanged,
      this.action,
      this.sellOrRent,
      this.hintText,
      this.isProyek = false,
      this.fromHomePage = false,
      this.justSearch = false});

  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(120),
        border: Border.all(
          width: 1,
          color: Colors.grey,
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Perform search action
            },
          ),
          Expanded(
            child: TextField(
              controller: widget.controller,
              onSubmitted: (value) {
                widget.action!();
              },
              decoration: InputDecoration(
                hintText: widget.hintText ?? 'Cari Properti',
                border: InputBorder.none,
              ),
            ),
          ),
          widget.justSearch == true
              ? Container()
              : IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    showCustomSnackbar(
                        context,
                        ModalFilter(
                          widget.selectedItem,
                          widget.onChanged,
                          isProyek: widget.isProyek,
                          controller: widget.controller,
                          sellOrRent: widget.sellOrRent,
                          fromHomePage: widget.fromHomePage,
                        ));
                  },
                ),
        ],
      ),
    );
  }
}
