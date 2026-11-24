import 'package:url_launcher/url_launcher.dart';

import '../../domain/project_inquiry.dart';

class EmailProjectInquiryGateway implements ProjectInquiryGateway {
  const EmailProjectInquiryGateway(this.address);

  final String address;

  @override
  Future<bool> openDraft(ProjectInquiry inquiry) {
    final subject = Uri.encodeComponent('Project inquiry: ${inquiry.service}');
    final body = Uri.encodeComponent(
      'Name: ${inquiry.name}\nEmail: ${inquiry.email}\n'
      'Service: ${inquiry.service}\n\n${inquiry.overview}',
    );
    return launchUrl(Uri.parse('mailto:$address?subject=$subject&body=$body'));
  }
}
