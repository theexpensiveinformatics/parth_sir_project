class CompanyEntry {
  final String? id;
  final String companyName;
  final String companyEmail;
  final String companyPhone;
  final String companySegment;
  final String address;
  final String otherNotes;
  final DateTime createdAt;

  CompanyEntry({
    this.id,
    required this.companyName,
    required this.companyEmail,
    required this.companyPhone,
    required this.companySegment,
    required this.address,
    required this.otherNotes,
    required this.createdAt,
  });

  factory CompanyEntry.fromJson(Map<String, dynamic> json) {
    return CompanyEntry(
      id: json['id']?.toString(),
      companyName: json['company_name'] ?? '',
      companyEmail: json['company_email'] ?? '',
      companyPhone: json['company_phone'] ?? '',
      companySegment: json['company_segment'] ?? '',
      address: json['address'] ?? '',
      otherNotes: json['other_notes'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company_name': companyName,
      'company_email': companyEmail,
      'company_phone': companyPhone,
      'company_segment': companySegment,
      'address': address,
      'other_notes': otherNotes,
      'created_at': createdAt.toIso8601String(),
    };
  }

  CompanyEntry copyWith({
    String? id,
    String? companyName,
    String? companyEmail,
    String? companyPhone,
    String? companySegment,
    String? address,
    String? otherNotes,
    DateTime? createdAt,
  }) {
    return CompanyEntry(
      id: id ?? this.id,
      companyName: companyName ?? this.companyName,
      companyEmail: companyEmail ?? this.companyEmail,
      companyPhone: companyPhone ?? this.companyPhone,
      companySegment: companySegment ?? this.companySegment,
      address: address ?? this.address,
      otherNotes: otherNotes ?? this.otherNotes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}