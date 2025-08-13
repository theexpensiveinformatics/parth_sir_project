import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class SearchFilters extends StatelessWidget {
  final String searchQuery;
  final String selectedSegment;
  final Function(String) onSearchChanged;
  final Function(String?) onSegmentChanged;

  const SearchFilters({
    super.key,
    required this.searchQuery,
    required this.selectedSegment,
    required this.onSearchChanged,
    required this.onSegmentChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Search companies...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: searchQuery.isNotEmpty
                  ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => onSearchChanged(''),
              )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: selectedSegment.isEmpty ? null : selectedSegment,
            decoration: InputDecoration(
              labelText: 'Filter by Segment',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
            ),
            items: ['All', ...AppConstants.companySegments].map((segment) {
              return DropdownMenuItem(
                value: segment,
                child: Text(segment),
              );
            }).toList(),
            onChanged: onSegmentChanged,
          ),
        ],
      ),
    );
  }
}