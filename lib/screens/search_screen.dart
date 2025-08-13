import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/supabase_service.dart';
import '../widgets/company_card.dart';
import '../widgets/search_filters.dart';
import '../constants/app_constants.dart';
import 'add_entry_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchQuery = '';
  String _selectedSegment = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Search Entries'),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          SearchFilters(
            searchQuery: _searchQuery,
            selectedSegment: _selectedSegment,
            onSearchChanged: (query) {
              setState(() {
                _searchQuery = query;
              });
            },
            onSegmentChanged: (segment) {
              setState(() {
                _selectedSegment = segment ?? '';
              });
            },
          ),
          Expanded(
            child: Consumer<SupabaseService>(
              builder: (context, service, child) {
                final filteredEntries = service.searchEntries(
                  query: _searchQuery,
                  segment: _selectedSegment,
                );

                if (filteredEntries.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 80,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No results found',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try adjusting your search criteria',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: AppConstants.screenPadding,
                  itemCount: filteredEntries.length,
                  itemBuilder: (context, index) {
                    final entry = filteredEntries[index];
                    return CompanyCard(
                      entry: entry,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddEntryScreen(entry: entry),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}