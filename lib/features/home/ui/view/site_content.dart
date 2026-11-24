import 'package:flutter/material.dart';

const companyName = 'SoftLance Technologies';
const companyEmail = 'info@softlancetechnologies.com';
const companyPhone = '+919714540918';
const companyLocation = 'Ahmedabad, Gujarat, India';
const companyAddress =
    'A 401, Rishit Residency, Near Pooja Farm, New Narol, Ahmedabad, Gujarat';
final companyPhoneUri = Uri(scheme: 'tel', path: companyPhone);
final companyEmailUri = Uri(scheme: 'mailto', path: companyEmail);

enum SiteSection {
  home('Home'),
  overview('Overview'),
  about('About'),
  services('Services'),
  expertise('Expertise'),
  portfolio('Portfolio'),
  contact('Contact');

  const SiteSection(this.label);
  final String label;
}

class SiteService {
  const SiteService(
    this.title,
    this.shortTitle,
    this.description,
    this.icon,
    this.color,
  );

  final String title;
  final String shortTitle;
  final String description;
  final IconData icon;
  final Color color;
}

const siteServices = [
  SiteService(
    'Mobile App Development',
    'Mobile App Dev',
    'High-performance Android, iOS and Flutter apps built for scale.',
    Icons.phone_android_rounded,
    Color(0xff145cff),
  ),
  SiteService(
    'Website Development',
    'Web Platforms',
    'Modern, responsive websites and business portals engineered for conversion.',
    Icons.language_rounded,
    Color(0xff007fa7),
  ),
  SiteService(
    'Custom Software',
    'Custom Software',
    'Tailored business solutions, workflow automation and system integrations.',
    Icons.layers_outlined,
    Color(0xff008365),
  ),
  SiteService(
    'Hosting & Cloud',
    'Cloud & DevOps',
    'Application deployment, cloud hosting, maintenance and security auditing.',
    Icons.cloud_outlined,
    Color(0xff1665db),
  ),
  SiteService(
    'Digital Marketing',
    'Digital Growth',
    'SEO, social media marketing and online brand building.',
    Icons.campaign_outlined,
    Color(0xffaa5400),
  ),
  SiteService(
    'AI Solutions',
    'AI Solutions',
    'AI model integration, custom LLM fine-tuning and business automation.',
    Icons.memory_rounded,
    Color(0xff6349db),
  ),
];

const healthcareService = 'Healthcare & IoT Solution';

const processSteps = [
  (
    'Discover',
    'Understand business goals, target users and scope.',
    Icons.search,
    Color(0xff0084b5),
  ),
  (
    'Design',
    'Create intuitive UI/UX and accessible prototypes.',
    Icons.edit_outlined,
    Color(0xff245bff),
  ),
  (
    'Develop',
    'Write secure, scalable code with clean architecture.',
    Icons.code,
    Color(0xff6445ff),
  ),
  (
    'Test',
    'Ensure quality, performance and security.',
    Icons.verified_outlined,
    Color(0xff008b66),
  ),
  (
    'Deploy',
    'Launch and provide ongoing support.',
    Icons.bolt_outlined,
    Color(0xff0079de),
  ),
];

const projectConcepts = [
  (
    'Healthcare IoT App',
    'ECG & Vital Monitoring',
    'Real-time ECG streaming, battery telemetry and alerts.',
    'Flutter + BLE',
    'assets/site/healthcare.png',
  ),
  (
    'Business Web Platform',
    'Management & Automation',
    'An enterprise analytics and billing platform.',
    'Flutter Web',
    'assets/site/business.png',
  ),
  (
    'Wellness Mobile App',
    'Health & Fitness Solutions',
    'A mobile experience for tracking daily wellness goals.',
    'Flutter',
    'assets/site/wellness.png',
  ),
];
