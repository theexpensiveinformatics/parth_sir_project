import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/company_entry.dart';

class SupabaseService extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;

  List<CompanyEntry> _entries = [];
  bool _isLoading = false;
  String? _error;

  List<CompanyEntry> get entries => _entries;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchEntries() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _supabase
          .from('companies')
          .select()
          .order('created_at', ascending: false);

      _entries = (response as List)
          .map((entry) => CompanyEntry.fromJson(entry))
          .toList();
    } catch (e) {
      _error = e.toString();
      debugPrint('Error fetching entries: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addEntry(CompanyEntry entry) async {
    _error = null;
    notifyListeners();

    try {
      await _supabase.from('companies').insert(entry.toJson());
      await fetchEntries(); // Refresh the list
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      debugPrint('Error adding entry: $e');
      return false;
    }
  }

  Future<bool> updateEntry(CompanyEntry entry) async {
    _error = null;
    notifyListeners();

    try {
      await _supabase
          .from('companies')
          .update(entry.toJson())
          .eq('id', entry.id!);
      await fetchEntries(); // Refresh the list
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      debugPrint('Error updating entry: $e');
      return false;
    }
  }

  Future<bool> deleteEntry(String id) async {
    _error = null;
    notifyListeners();

    try {
      await _supabase.from('companies').delete().eq('id', id);
      await fetchEntries(); // Refresh the list
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      debugPrint('Error deleting entry: $e');
      return false;
    }
  }

  List<CompanyEntry> searchEntries({
    String? query,
    String? segment,
  }) {
    List<CompanyEntry> filtered = List.from(_entries);

    if (query != null && query.isNotEmpty) {
      filtered = filtered.where((entry) {
        return entry.companyName.toLowerCase().contains(query.toLowerCase()) ||
            entry.companyEmail.toLowerCase().contains(query.toLowerCase()) ||
            entry.companyPhone.contains(query) ||
            entry.address.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }

    if (segment != null && segment.isNotEmpty && segment != 'All') {
      filtered = filtered.where((entry) => entry.companySegment == segment).toList();
    }

    return filtered;
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}