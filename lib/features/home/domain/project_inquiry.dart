class ProjectInquiry {
  const ProjectInquiry({
    required this.name,
    required this.email,
    required this.service,
    required this.overview,
  });

  final String name;
  final String email;
  final String service;
  final String overview;
}

abstract interface class ProjectInquiryGateway {
  Future<bool> openDraft(ProjectInquiry inquiry);
}
