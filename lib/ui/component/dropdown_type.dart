import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertio_mobile/bloc/address/cities/cities_cubit.dart';
import 'package:propertio_mobile/bloc/address/province/province_cubit.dart';
import 'package:propertio_mobile/bloc/propertyType/property_type_bloc.dart';
import 'package:propertio_mobile/data/model/responses/address_response_model.dart';
import 'package:propertio_mobile/shared/theme.dart';
import 'package:propertio_mobile/ui/component/text_failure.dart';

class DropdownType extends StatelessWidget {
  String? selectedItem;
  final void Function(String?)? onChanged;
  DropdownType(this.selectedItem, this.onChanged, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PropertyTypeBloc, PropertyTypeState>(
      builder: (context, state) {
        if (state is PropertyTypeLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is PropertyTypeError) {
          return TextFailure(message: state.message);
        }
        if (state is PropertyTypeLoaded) {
          // _selectedItem = state.propertyTypeModel.data!.first.name;
          return Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 10),
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Color(0xFF79747E),
              ),
            ),
            child: DropdownButton(
              isExpanded: true,
              value: selectedItem,
              hint: Text('Pilih properti'),
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.black),
              underline: Container(
                height: 0,
                color: Colors.transparent,
              ),
              items: state.propertyTypeModel.data?.map((e) {
                return DropdownMenuItem(
                  value: e.name,
                  child: Text('${e.name}'),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          );
        }
        return Container();
      },
    );
  }
}

class CustomDropdown<T> extends StatelessWidget {
  final T value;
  final List<T> items;
  final String label;
  final Function(T?)? onChanged;
  DropdownMenuItem<T> Function(T) itemBuilder;
  List<DropdownMenuItem<T>>? dropdownItems;

  CustomDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.label,
    this.onChanged,
    this.dropdownItems,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(children: [
          TextSpan(
            text: label,
            style: primaryTextStyle.copyWith(
              fontSize: 18,
              fontWeight: semiBold,
            ),
          ),
          TextSpan(
            text: ' *',
            style: primaryTextStyle.copyWith(
              fontSize: 18,
              fontWeight: medium,
              color: Colors.red,
            ),
          ),
        ])),
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 16),
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Color(0xFF79747E),
            ),
          ),
          child: DropdownButton<T>(
            underline: Container(
              height: 0,
              color: Colors.transparent,
            ),
            isExpanded: true,
            value: value,
            onChanged: onChanged,
            items: items.map((T item) {
              return itemBuilder(item);
              // DropdownMenuItem<T>(
              //   value: item,
              //   child: Text(item.toString()),
              // );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class DropdownCustomized extends StatelessWidget {
  final String label;
  Widget dropdown;
  DropdownCustomized({required this.label, required this.dropdown, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(children: [
          TextSpan(
            text: label,
            style: primaryTextStyle.copyWith(
              fontSize: 18,
              fontWeight: semiBold,
            ),
          ),
          TextSpan(
            text: ' *',
            style: primaryTextStyle.copyWith(
              fontSize: 18,
              fontWeight: medium,
              color: Colors.red,
            ),
          ),
        ])),
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 16),
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Color(0xFF79747E),
            ),
          ),
          child: dropdown,
        ),
      ],
    );
  }
}

class AddressForm extends StatefulWidget {
  String _selectedProvince;
  String _selectedCity;
  void Function(String?)? onChangedProvince;
  void Function(String?)? onChangedCity;
  AddressForm(this._selectedProvince, this._selectedCity,
      {this.onChangedProvince, this.onChangedCity, super.key});

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      BlocBuilder<ProvinceCubit, ProvinceState>(
        builder: (context, state) {
          if (state is ProvinceLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProvinceError) {
            return TextFailure(message: state.message);
          }
          if (state is ProvinceLoaded) {
            List<ProvinceResponseModel> provinces = state.provinces;

            return CustomDropdown<String>(
              value: widget._selectedProvince,
              items: provinces.map((e) => '${e.name}').toList(),
              label: 'Provinsi',
              onChanged: (value) {
                widget.onChangedProvince!(value);
                setState(() {
                  var idProvince = provinces
                      .firstWhere((element) => element.name == value)
                      .id;
                  widget._selectedProvince = value!;
                  context.read<CitiesCubit>().disposeCity();
                  widget._selectedCity = 'Pilih Kota';
                  print('idProvince: $idProvince');
                  idProvince == '0'
                      ? null
                      : context.read<CitiesCubit>().getCities('$idProvince');
                });
              },
              itemBuilder: (item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text('${item}'),
                );
              },
            );
          }
          return Container();
        },
      ),
      BlocBuilder<CitiesCubit, CitiesState>(
        builder: (context, state) {
          if (state is CitiesLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CitiesError) {
            return TextFailure(message: state.message);
          }
          if (state is CitiesLoaded) {
            List<CitiesResponseModel> cities = state.cities;

            return CustomDropdown<String>(
              value: widget._selectedCity,
              items: cities.map((e) => '${e.name}').toList(),
              label: 'Kota',
              onChanged: (value) {
                setState(() {
                  widget.onChangedCity!(value);
                  widget._selectedCity = value!;
                });
              },
              itemBuilder: (item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text('${item}'),
                );
              },
            );
          }
          return IgnorePointer(
            ignoring: true,
            child: CustomDropdown<String>(
              value: widget._selectedCity,
              items: [widget._selectedCity],
              label: 'Kota',
              onChanged: (value) {
                setState(() {
                  widget._selectedCity = value!;
                });
              },
              itemBuilder: (item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text('${item}'),
                );
              },
            ),
          );
        },
      )
    ]);
  }
}
