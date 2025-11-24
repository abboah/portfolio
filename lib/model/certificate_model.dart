class CertificateModel {
  final String name;
  final String organization;
  final String date;
  final String skills;
  final String credential;

  CertificateModel({
    required this.name,
    required this.organization,
    required this.date,
    required this.skills,
    required this.credential,
  });
}

List<CertificateModel> certificateList = [
  CertificateModel(
    name: 'Mobile Development Bootcamp',
    organization: 'BeistandTech',
    date: '4th February to 5th March 2023',
    skills: 'Flutter, Dart, API Integration',
    credential:
        'https://drive.google.com/file/d/13obcA5TEkVvCxOP-bnpA3G3vcoTOChck/view?usp=sharing',
  ),
];
