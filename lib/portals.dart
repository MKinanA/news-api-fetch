const bool useDummyPortal = false; // TODO: Set this to [false] after every debugging sessions

const Map<String, List<String>> portals = {
  if (useDummyPortal) 'Dummy': [
    '',
  ],
  'CNN News': [
    '',
    'Nasional',
    'Internasional',
    'Ekonomi',
    'Olahraga',
    'Teknologi',
    'Hiburan',
    'Gaya hidup',
  ],
  'Antara News': [
    'Terkini',
    'Top news',
    'Politik',
    'Hukum',
    'Ekonomi',
    'Metro',
    'Sepakbola',
    'Olahraga',
    'Humaniora',
    'Lifestyle',
    'Hiburan',
    'Dunia',
    'Infografik',
    'Tekno',
    'Otomotif',
    'Warta bumi',
    'Rilis pers',
  ],
  'Republika News': [
    '',
    'News',
    'Nusantara',
    'Khazanah',
    'Islam digest',
    'Internasional',
    'Ekonomi',
    'Sepakbola',
    'Leisure',
  ],
  'CNBC News': [
    '',
    'Market',
    'News',
    'Entrepreneur',
    'Syariah',
    'Tech',
    'Lifestyle',
  ],
  'Tempo News': [
    '',
    'Nasional',
    'Bisnis',
    'Metro',
    'Dunia',
    'Bola',
    'Sport',
    'Cantik',
    'Tekno',
    'Otomotif',
    'Nusantara',
  ],
};

extension Optimization on String {
  String get lowerAndHyphenify => toLowerCase().replaceAll(RegExp(r' '), '-');
}
