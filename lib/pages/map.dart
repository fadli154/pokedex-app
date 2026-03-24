import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_flutter/models/province_model.dart';

class MyMap extends StatefulWidget {
  const MyMap({super.key});

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  List<Province>? _cachedProvinces;

  Future<List<Province>> fetchProvince(String? filter) async {
    if (_cachedProvinces != null) {
      return _filterData(_cachedProvinces!, filter);
    }

    final response = await http.get(
      Uri.parse('https://wilayah.id/api/provinces.json'),
    );

    final Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;

    final List<Map<String, dynamic>> results = List<Map<String, dynamic>>.from(
      data['data'],
    );

    _cachedProvinces = results.map((e) => Province.fromJson(e)).toList();

    return _filterData(_cachedProvinces!, filter);
  }

  List<Province> _filterData(List<Province> data, String? filter) {
    if (filter == null || filter.isEmpty) return data;

    return data
        .where((item) => item.name.toLowerCase().contains(filter.toLowerCase()))
        .toList();
  }

  Province? selectedProvince;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: DropdownSearch<Province>(
        selectedItem: selectedProvince,
        onChanged: (value) {
          setState(() {
            selectedProvince = value;
          });
        },
        compareFn: (item1, item2) => item1 == item2,

        items: (filter, loadProps) async {
          try {
            return await fetchProvince(filter);
          } catch (e) {
            return [];
          }
        },

        itemAsString: (Province p) => p.name,

        popupProps: PopupProps.menu(
          showSearchBox: true,

          // 🔥 loading indicator
          loadingBuilder: (context, searchEntry) =>
              Center(child: CircularProgressIndicator()),
        ),

        decoratorProps: DropDownDecoratorProps(
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 20),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(12),
            ),
            hintText: 'Please select...',
            hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
