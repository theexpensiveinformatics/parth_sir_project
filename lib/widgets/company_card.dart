import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/company_entry.dart';
import '../constants/app_constants.dart';

class CompanyCard extends StatelessWidget {
  final CompanyEntry entry;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const CompanyCard({
    super.key,
    required this.entry,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      entry.companyName,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  if (onDelete != null)
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: AppConstants.errorColor),
                      onPressed: onDelete,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              _buildInfoRow(
                icon: Icons.business,
                label: entry.companySegment,
                color: AppConstants.primaryColor,
              ),
              const SizedBox(height: 4),
              _buildInfoRow(
                icon: Icons.email_outlined,
                label: entry.companyEmail,
                color: AppConstants.secondaryColor,
                onTap: () => _launchEmail(entry.companyEmail),
              ),
              const SizedBox(height: 4),
              _buildInfoRow(
                icon: Icons.phone_outlined,
                label: entry.companyPhone,
                color: AppConstants.secondaryColor,
                onTap: () => _launchPhone(entry.companyPhone),
              ),
              if (entry.address.isNotEmpty) ...[
                const SizedBox(height: 4),
                _buildInfoRow(
                  icon: Icons.location_on_outlined,
                  label: entry.address,
                  color: AppConstants.secondaryColor,
                ),
              ],
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('MMM dd, yyyy • HH:mm').format(entry.createdAt),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppConstants.secondaryColor,
                    ),
                  ),
                  if (entry.otherNotes.isNotEmpty)
                    Icon(
                      Icons.note_outlined,
                      size: 16,
                      color: AppConstants.secondaryColor,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required Color color,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 14,
                decoration: onTap != null ? TextDecoration.underline : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _launchEmail(String email) async {
    final Uri uri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _launchPhone(String phone) async {
    final Uri uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}