import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_flutter/models/city_model.dart';
import 'package:package_flutter/models/province_model.dart';

class MyMap extends StatefulWidget {
  const MyMap({super.key});

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  Province? selectedProvince;
  City? selectedCity;
  String? provinceId;

  Future<List<Province>> fetchProvince() async {
    final response = await http.get(
      Uri.parse('https://wilayah.id/api/provinces.json'),
    );

    final data = json.decode(response.body);
    final List<Map<String, dynamic>> results = List<Map<String, dynamic>>.from(
      data['data'],
    );

    return results.map((e) => Province.fromJson(e)).toList();
  }

  Future<List<City>> fetchCity() async {
    final response = await http.get(
      Uri.parse('https://wilayah.id/api/regencies/$provinceId.json'),
    );

    final data = json.decode(response.body);
    final List<Map<String, dynamic>> results = List<Map<String, dynamic>>.from(
      data['data'],
    );

    return results.map((e) => City.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        children: [
          DropdownSearch<Province>(
            // ambil data dari API
            items: (filter, loadProps) async => await fetchProvince(),

            // tampilkan nama
            itemAsString: (p) => p.name,

            // selected value
            selectedItem: selectedProvince,
            onChanged: (value) {
              setState(() {
                selectedProvince = value;
              });

              provinceId = value?.id;

              selectedCity = null;

              print(selectedCity?.code);
              print(selectedProvince?.id);
            },

            compareFn: (item1, item2) => item1.id == item2.id,

            decoratorProps: DropDownDecoratorProps(
              decoration: InputDecoration(
                labelText: 'Pilih Provinsi',
                border: OutlineInputBorder(),
              ),
            ),

            // popup simple
            popupProps: PopupProps.menu(showSearchBox: true),
          ),

          SizedBox(height: 25),

          if (provinceId != null)
            DropdownSearch<City>(
              // ambil data dari API
              items: (filter, loadProps) async => await fetchCity(),

              // tampilkan nama
              itemAsString: (p) => p.name,

              // selected value
              selectedItem: selectedCity,
              onChanged: (value) {
                setState(() {
                  selectedCity = value;
                });

                print(selectedCity?.code);
                print(selectedProvince?.id);
              },

              compareFn: (item1, item2) => item1.code == item2.code,

              decoratorProps: DropDownDecoratorProps(
                decoration: InputDecoration(
                  labelText: 'Pilih Kota/Kabupaten',
                  border: OutlineInputBorder(),
                ),
              ),

              // popup simple
              popupProps: PopupProps.menu(showSearchBox: true),
            ),
        ],
      ),
    );
  }
}
