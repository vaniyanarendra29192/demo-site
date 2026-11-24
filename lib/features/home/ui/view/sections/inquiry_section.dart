import 'package:flutter/material.dart';

import '../../../../../app/localization/site_language.dart';

import '../../../domain/project_inquiry.dart';
import '../site_content.dart';
import '../site_theme.dart';

class InquirySection extends StatefulWidget {
  const InquirySection({
    super.key,
    required this.compact,
    required this.selection,
    required this.gateway,
    required this.onContact,
  });

  final bool compact;
  final ValueNotifier<String?> selection;
  final ProjectInquiryGateway gateway;
  final ValueChanged<Uri> onContact;

  @override
  State<InquirySection> createState() => _InquirySectionState();
}

class _InquirySectionState extends State<InquirySection> {
  final _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final form = _InquiryForm(
      key: _formKey,
      compact: widget.compact,
      selection: widget.selection,
      gateway: widget.gateway,
    );
    if (widget.compact) return form;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          colors: [Color(0xff163278), Color(0xff0c192e), Color(0xff0b334a)],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3907162a),
            blurRadius: 22,
            offset: Offset(0, 13),
          ),
        ],
      ),
      padding: const EdgeInsets.all(35),
      child: Row(
        spacing: 38,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                siteEyebrow(
                  context.tr('Let\'s Build Something Great Together'),
                  color: const Color(0xff71e7ff),
                ),
                const SizedBox(height: 14),
                Text.rich(
                  TextSpan(
                    text: "${context.tr('Have a Project in Mind?')}\n",
                    style: siteText(
                      33,
                      weight: FontWeight.w800,
                      color: Colors.white,
                      editorial: true,
                      height: 1.15,
                      spacing: -.8,
                    ),
                    children: [
                      TextSpan(
                        text: context.tr('Talk to Our Technical Leads'),
                        style: const TextStyle(color: Color(0xff55d9ff)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  context.tr(
                    'Whether you need cloud software, a responsive web portal, a mobile app or specialized healthcare IoT engineering, tell us what you’re building.',
                  ),
                  style: siteText(15, color: siteOnDark),
                ),
                const SizedBox(height: 18),
                ContactDetails(onContact: widget.onContact),
              ],
            ),
          ),
          Expanded(child: form),
        ],
      ),
    );
  }
}

class ContactDetails extends StatelessWidget {
  const ContactDetails({super.key, required this.onContact});

  final ValueChanged<Uri> onContact;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      for (final (icon, label, link) in [
        (Icons.location_on_outlined, context.tr(companyAddress), null),
        (Icons.mail_outline, companyEmail, companyEmailUri),
        (Icons.phone_outlined, companyPhone, companyPhoneUri),
      ])
        Builder(
          builder: (context) {
            final row = Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Icon(icon, size: 17, color: const Color(0xff63deff)),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Text(
                      label,
                      style: siteText(13, color: const Color(0xffe1ecfa)),
                    ),
                  ),
                ],
              ),
            );
            return link == null
                ? row
                : InkWell(onTap: () => onContact(link), child: row);
          },
        ),
    ],
  );
}

class _InquiryForm extends StatefulWidget {
  const _InquiryForm({
    super.key,
    required this.compact,
    required this.selection,
    required this.gateway,
  });

  final bool compact;
  final ValueNotifier<String?> selection;
  final ProjectInquiryGateway gateway;

  @override
  State<_InquiryForm> createState() => _InquiryFormState();
}

class _InquiryFormState extends State<_InquiryForm> {
  static final _emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
  final _form = GlobalKey<FormState>();
  final _services = GlobalKey<FormFieldState<String>>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _overview = TextEditingController();
  bool _openingDraft = false;

  @override
  void initState() {
    super.initState();
    widget.selection.addListener(_updateService);
  }

  @override
  void didUpdateWidget(covariant _InquiryForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selection != widget.selection) {
      oldWidget.selection.removeListener(_updateService);
      widget.selection.addListener(_updateService);
    }
  }

  void _updateService() =>
      _services.currentState?.didChange(widget.selection.value);

  @override
  void dispose() {
    widget.selection.removeListener(_updateService);
    _name.dispose();
    _email.dispose();
    _overview.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_openingDraft || !_form.currentState!.validate()) return;
    final inquiry = ProjectInquiry(
      name: _name.text.trim(),
      email: _email.text.trim(),
      service: _services.currentState!.value!,
      overview: _overview.text.trim(),
    );
    setState(() => _openingDraft = true);
    var opened = false;
    try {
      opened = await widget.gateway.openDraft(inquiry);
    } on Exception {
      // A device can reject an external mail link.
    }
    if (!mounted) return;
    setState(() => _openingDraft = false);
    if (!opened) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            context.tr('Could not open your email app. Please email {email}.', {
              'email': companyEmail,
            }),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final name = _Input(
      label: context.tr('Your Name'),
      child: TextFormField(
        controller: _name,
        decoration: _decoration(context.tr('e.g. John Doe')),
        autofillHints: const [AutofillHints.name],
        textInputAction: TextInputAction.next,
        errorBuilder: _localizedError,
        validator: (value) =>
            value == null || value.trim().isEmpty ? 'Enter your name' : null,
      ),
    );
    final email = _Input(
      label: context.tr('Email Address'),
      child: TextFormField(
        controller: _email,
        decoration: _decoration('name@company.com'),
        autofillHints: const [AutofillHints.email],
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        errorBuilder: _localizedError,
        validator: (value) => _emailPattern.hasMatch(value?.trim() ?? '')
            ? null
            : 'Enter a valid email address',
      ),
    );
    return SitePanel(
      padding: EdgeInsets.all(widget.compact ? 18 : 25),
      child: Form(
        key: _form,
        child: AutofillGroup(
          child: Column(
            spacing: 11,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.compact) siteEyebrow(context.tr('Quick Estimate')),
                  Text(
                    widget.compact
                        ? context.tr('Discuss Your Project')
                        : context.tr('Request a Fast Quote'),
                    style: siteText(22, weight: FontWeight.w800),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    context.tr(
                      'Tell us your requirements and receive a project consultation response.',
                    ),
                    style: siteText(13, color: siteMuted),
                  ),
                ],
              ),
              if (widget.compact) ...[
                name,
                email,
              ] else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12,
                  children: [
                    Expanded(child: name),
                    Expanded(child: email),
                  ],
                ),
              _Input(
                label: context.tr('Service Needed'),
                child: DropdownButtonFormField<String>(
                  key: _services,
                  initialValue:
                      widget.selection.value ?? siteServices.first.title,
                  decoration: _decoration(context.tr('Select a service')),
                  isExpanded: true,
                  items: [
                    for (final title in [
                      ...siteServices.map((service) => service.title),
                      healthcareService,
                    ])
                      DropdownMenuItem(
                        value: title,
                        child: Text(
                          context.tr(title),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                  onChanged: (value) => widget.selection.value = value,
                  errorBuilder: _localizedError,
                  validator: (value) =>
                      value == null ? 'Select a service' : null,
                ),
              ),
              _Input(
                label: context.tr('Project Overview'),
                child: TextFormField(
                  controller: _overview,
                  minLines: 3,
                  maxLines: 4,
                  decoration: _decoration(
                    context.tr(
                      'Briefly describe your goals, timeline and features…',
                    ),
                  ),
                  errorBuilder: _localizedError,
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Describe your project'
                      : null,
                ),
              ),
              SiteButton(
                _openingDraft
                    ? context.tr('Opening Email…')
                    : context.tr('Send Project Inquiry'),
                onPressed: _openingDraft ? null : _submit,
                icon: Icons.send_outlined,
              ),
              Text(
                context.tr('Opens a draft in your email app.'),
                textAlign: TextAlign.center,
                style: siteText(12, color: siteMuted),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _localizedError(BuildContext context, String message) =>
      Text(context.tr(message));

  InputDecoration _decoration(String hint) => InputDecoration(
    hintText: hint,
    hintStyle: siteText(13, color: siteMuted),
    isDense: true,
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: siteBorder),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: sitePrimary, width: 1.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: siteBorder),
    ),
  );
}

class _Input extends StatelessWidget {
  const _Input({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    spacing: 5,
    children: [
      Text(label, style: siteText(13, weight: FontWeight.w700)),
      Semantics(label: label, child: child),
    ],
  );
}
