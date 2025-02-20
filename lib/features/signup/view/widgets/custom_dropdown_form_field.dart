import 'package:flutter/material.dart';
import 'package:nti_form/core/constants/countries.dart';

class CustomDropdownFormField extends StatelessWidget {
  const CustomDropdownFormField({
    super.key,
    required this.selectedCountry,
    required this.onChanged,
    this.validator,
  });

  final Country? selectedCountry;
  final void Function(Country?) onChanged;
  final String? Function(Country?)? validator;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Country>(
      decoration: InputDecoration(
        labelText: 'Country',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      menuMaxHeight: 250,
      isExpanded: true,
      value: selectedCountry,
      items: List.generate(
        countries.length,
        (index) => DropdownMenuItem<Country>(
          value: countries[index],
          child: Text(countries[index].name),
        ),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
