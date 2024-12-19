import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:news_api_fetch/models/news.dart';
import 'package:news_api_fetch/network/net_client.dart';

const bool useDummyData = false; // TODO: Set this to [false] after every debugging sessions

class NewsData with ChangeNotifier {
  final Map<String, Map<String, List<News>>> _data = useDummyData ? _dummyData : {};
  final List<News> savedNews = [];

  void forceNotifyListeners() => notifyListeners();

  Future<void> fetch({required String portal, String? category, bool forceUpdate = false, bool kDebugMode = false}) async {
    bool doNotifyListeners = false;
    if (_data[portal] == null) {
      (kDebugMode ? print : log)('_data[\'$portal\'] didn\'t exist (${null}), creating');
      _data[portal] = {};
    } else {
      (kDebugMode ? print : log)('_data[\'$portal\'] exists, skipping creation');
    }
    if (_data[portal]![category ?? ''] == null || forceUpdate) {
      (kDebugMode ? print : log)('_data[\'$portal\'][\'$category\'] ${forceUpdate ? 'exists but is requested to be updated (refetched)' : 'didn\'t exist (${null})'}, fetching via NetClient.fetchNews');
      _data[portal]![category ?? ''] = await NetClient.fetchNews(
        portal: portal,
        category: category ?? '',
      );
      doNotifyListeners = true;
    } else {
      (kDebugMode ? print : log)('_data[\'$portal\'][\'$category\'] exists, skipping fetch');
    }
    (kDebugMode ? print : log)(doNotifyListeners ? 'Some data was updated and notifyListeners is necessary, notifying listeners' : 'No necessary data was updated to notify listeners');
    if (doNotifyListeners) {
      notifyListeners();
    }
  }

  Future<void> update({required String portal, String? category, bool kDebugMode = false}) async => await fetch(portal: portal, category: category, forceUpdate: true, kDebugMode: kDebugMode);
  
  Future<List<News>> get({required String portal, String? category, bool kDebugMode = false}) async {
    await fetch(portal: portal, category: category, kDebugMode: kDebugMode);
    return _data[portal]![category ?? '']!;
  }

  List<News> getSync({required String portal, String? category}) => _data[portal]?[category ?? ''] ?? [];
}

extension IsSaved on News {
  // bool get isSaved => this._data['isSaved'] ?? false;
  // set isSaved(bool state) => _data['isSaved'] = state;

  bool isSavedIn(NewsData newsData) => newsData.savedNews.contains(this);
  void saveTo(NewsData newsData) {
    newsData.savedNews.contains(this) ? null : newsData.savedNews.add(this);
    newsData.forceNotifyListeners();
  }
  void unsaveFrom(NewsData newsData) {
    newsData.savedNews.contains(this) ? newsData.savedNews.remove(this) : null;
    newsData.forceNotifyListeners();
  }
}

Map<String, Map<String, List<News>>> _dummyData = {
  'dummy': {
    '': [
      News({
        'title': 'Cool cat makes an appearance in local location at a certain time during the day',
        'link': 'https://example.com/',
        'contentSnippet': 'Cool cat makes an appearance in local location at a certain time during the day. Locals were unsure of the cat\'s motive, but nobody eventually cared.',
        'isoDate': '2000-01-01T00:00:00.000Z',
        'image': {
          'asset': 'debug_assets/1.jpg',
        },
      }),
      News({
        'title': 'A new discovery of an isolated island in the middle of nowhere where nothing is anywhere',
        'link': 'https://example.com/',
        'contentSnippet': 'A new discovery of an isolated island in the middle of nowhere where nothing is anywhere. Scientists think this would be the biggest discovery of the second, or perhaps even minute!',
        'isoDate': '2000-01-01T00:00:00.000Z',
        'image': {
          'asset': 'debug_assets/2.jpg',
        },
      }),
      News({
        'title': 'Top tips to start your professional programming journey with nothing but a simple setup in your own room',
        'link': 'https://example.com/',
        'contentSnippet': 'Top tips to start your professional programming journey with nothing but a simple setup in your own room. You will need a computer, a chair, a desk, and a sincere intention.',
        'isoDate': '2000-01-01T00:00:00.000Z',
        'image': {
          'asset': 'debug_assets/3.jpeg',
        },
      }),
      News({
        'title': 'Cool cat makes an appearance in local location at a certain time during the day',
        'link': 'https://example.com/',
        'contentSnippet': 'Cool cat makes an appearance in local location at a certain time during the day. Locals were unsure of the cat\'s motive, but nobody eventually cared.',
        'isoDate': '2000-01-01T00:00:00.000Z',
        'image': {
          'asset': 'debug_assets/1.jpg',
        },
      }),
      News({
        'title': 'A new discovery of an isolated island in the middle of nowhere where nothing is anywhere',
        'link': 'https://example.com/',
        'contentSnippet': 'A new discovery of an isolated island in the middle of nowhere where nothing is anywhere. Scientists think this would be the biggest discovery of the second, or perhaps even minute!',
        'isoDate': '2000-01-01T00:00:00.000Z',
        'image': {
          'asset': 'debug_assets/2.jpg',
        },
      }),
      News({
        'title': 'Top tips to start your professional programming journey with nothing but a simple setup in your own room',
        'link': 'https://example.com/',
        'contentSnippet': 'Top tips to start your professional programming journey with nothing but a simple setup in your own room. You will need a computer, a chair, a desk, and a sincere intention.',
        'isoDate': '2000-01-01T00:00:00.000Z',
        'image': {
          'asset': 'debug_assets/3.jpeg',
        },
      }),
      News({
        'title': 'Cool cat makes an appearance in local location at a certain time during the day',
        'link': 'https://example.com/',
        'contentSnippet': 'Cool cat makes an appearance in local location at a certain time during the day. Locals were unsure of the cat\'s motive, but nobody eventually cared.',
        'isoDate': '2000-01-01T00:00:00.000Z',
        'image': {
          'asset': 'debug_assets/1.jpg',
        },
      }),
      News({
        'title': 'A new discovery of an isolated island in the middle of nowhere where nothing is anywhere',
        'link': 'https://example.com/',
        'contentSnippet': 'A new discovery of an isolated island in the middle of nowhere where nothing is anywhere. Scientists think this would be the biggest discovery of the second, or perhaps even minute!',
        'isoDate': '2000-01-01T00:00:00.000Z',
        'image': {
          'asset': 'debug_assets/2.jpg',
        },
      }),
      News({
        'title': 'Top tips to start your professional programming journey with nothing but a simple setup in your own room',
        'link': 'https://example.com/',
        'contentSnippet': 'Top tips to start your professional programming journey with nothing but a simple setup in your own room. You will need a computer, a chair, a desk, and a sincere intention.',
        'isoDate': '2000-01-01T00:00:00.000Z',
        'image': {
          'asset': 'debug_assets/3.jpeg',
        },
      }),
    ],
  },
  'cnn-news': {
    '': [
      News({
        "title": "[DUMMY] Everblast Festival 2024 Hadirkan Two Doors Cinema Club, 311 hingga ERK",
        "link": "https://www.cnnindonesia.com/hiburan/20241106135323-232-1163589/everblast-festival-2024-hadirkan-two-doors-cinema-club-311-hingga-erk",
        "contentSnippet": "Untuk kedua kalinya, Everblast Festival 2024 akan hadir di Gambir Expo Kemayoran Jakarta pada 30 November mendatang.",
        "isoDate": "2024-11-06T06:59:45.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/11/06/bnr-everblast-2024_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/11/06/bnr-everblast-2024_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Kapolda Buka Suara soal Belum Ungkap Identitas Tersangka Judol Komdigi",
        "link": "https://www.cnnindonesia.com/nasional/20241106135340-12-1163588/kapolda-buka-suara-soal-belum-ungkap-identitas-tersangka-judol-komdigi",
        "contentSnippet": "Kapolda Metro Jaya Irjen Karyoto hanya mengatakan penyidik akan segera mengungkap kasus tersebut dalam waktu dekat.",
        "isoDate": "2024-11-06T06:57:37.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2023/11/27/kapolda-metro-jaya-irjen-karyoto_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2023/11/27/kapolda-metro-jaya-irjen-karyoto_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Tuai Kritik, Kenapa Pemilu AS Masih Pakai Sistem Electoral College?",
        "link": "https://www.cnnindonesia.com/internasional/20241105154724-134-1163233/tuai-kritik-kenapa-pemilu-as-masih-pakai-sistem-electoral-college",
        "contentSnippet": "Jika kandidat tertentu memenangkan suara dari popular vote di Pemilu AS, tetapi dia kalah di electoral college, maka tak bisa jadi presiden AS.",
        "isoDate": "2024-11-06T06:55:43.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/11/05/pemungutan-suara-pilpres-as_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/11/05/pemungutan-suara-pilpres-as_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Dua Jam Bertemu, Prabowo dan PM Singapura Bahas Food Estate hingga IKN",
        "link": "https://www.cnnindonesia.com/nasional/20241106133842-20-1163579/dua-jam-bertemu-prabowo-dan-pm-singapura-bahas-food-estate-hingga-ikn",
        "contentSnippet": "Prabowo menerima kunjungan Perdana Menteri (PM) Singapura di Istana Merdeka Jakarta, Rabu (6/11).",
        "isoDate": "2024-11-06T06:52:03.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/11/06/pertemuan-prabowo-lawrence-wong-1_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/11/06/pertemuan-prabowo-lawrence-wong-1_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Kejagung Dalami Peran Pejabat 'R' di Kasus Suap Ronald Tannur",
        "link": "https://www.cnnindonesia.com/nasional/20241106124237-12-1163550/kejagung-dalami-peran-pejabat-r-di-kasus-suap-ronald-tannur",
        "contentSnippet": "Kejagung mendalami peran pejabat Pengadilan Negeri (PN) Surabaya berinisial R dalam kasus suap pemberian vonis bebas terhadap Gregorius Ronald Tannur.",
        "isoDate": "2024-11-06T06:51:09.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/10/25/konferensi-pers-kejagung-ri-kasus-ronald-tannur_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/10/25/konferensi-pers-kejagung-ri-kasus-ronald-tannur_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] 90 Persen Suara Masuk, Trump Menang di Pennsylvania",
        "link": "https://www.cnnindonesia.com/internasional/20241106133902-134-1163585/90-persen-suara-masuk-trump-menang-di-pennsylvania",
        "contentSnippet": "Calon presiden Amerika Serikat Donald Trump menang di Pennsylvania versi perhitungan media New York Times, Rabu (6/11).",
        "isoDate": "2024-11-06T06:49:56.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/11/06/usa-electiontrump_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/11/06/usa-electiontrump_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Ahmad Ali-Rusdy Mastura Cekcok Sebelum Debat Pilgub, Polda Buka Suara",
        "link": "https://www.cnnindonesia.com/nasional/20241106131603-617-1163575/ahmad-ali-rusdy-mastura-cekcok-sebelum-debat-pilgub-polda-buka-suara",
        "contentSnippet": "Polda Sulsel pun mengonfirmasi rekaman viral cekcok Ahmad Ali dan Rusdy Mastura, dan mengimbau massa agar tetap kondusif saat Pilkada serentak 2024.",
        "isoDate": "2024-11-06T06:45:52.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/09/24/pilgub-sulteng-ahmad-ali-nomor-1-anwa-nomor-2-dan-petahana-nomor-3_169.png?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/09/24/pilgub-sulteng-ahmad-ali-nomor-1-anwa-nomor-2-dan-petahana-nomor-3_169.png?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Update Pemilu AS, Ini Daftar Negara Bagian Harris Unggul di Pilpres",
        "link": "https://www.cnnindonesia.com/internasional/20241106123314-134-1163543/update-pemilu-as-ini-daftar-negara-bagian-harris-unggul-di-pilpres",
        "contentSnippet": "Pemilihan presiden Amerika Serikat atau pilpres AS 2024 sudah resmi digelar pada Selasa (5/11) kemarin.",
        "isoDate": "2024-11-06T06:45:18.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/10/29/kamala-harris_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/10/29/kamala-harris_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Profil Syakir Sulaiman, Mantan Timnas U-23 yang Ditangkap Polisi",
        "link": "https://www.cnnindonesia.com/olahraga/20241106133553-142-1163578/profil-syakir-sulaiman-mantan-timnas-u-23-yang-ditangkap-polisi",
        "contentSnippet": "Nahas betul nasib Syakir Sulaiman setelah memutuskan gantung sepatu. Eks pemain Timnas Indonesia U-23 ini ditangkap polisi pada Selasa (5/11).",
        "isoDate": "2024-11-06T06:41:19.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/11/06/syakir-sulaiman-eks-pemain-timnas-indonesia-u-23-ditangkap-polisi-1_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/11/06/syakir-sulaiman-eks-pemain-timnas-indonesia-u-23-ditangkap-polisi-1_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Survei Litbang Kompas: Andika Perkasa Unggul di Jateng, Pramono di DKI",
        "link": "https://www.cnnindonesia.com/nasional/20241106132304-617-1163576/survei-litbang-kompas-andika-perkasa-unggul-di-jateng-pramono-di-dki",
        "contentSnippet": "Calon-calon Pilkada 2024 yang tak diunggulkan selama ini, seperti Andika Perkasa dan Pramono Anung, mulai menyalip kandidat terkuat.",
        "isoDate": "2024-11-06T06:34:47.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/11/04/kalah-tipis-di-survei-litbang-kompas-luthfi-yasin-yakin-masyarakat-jateng-cerdas_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/11/04/kalah-tipis-di-survei-litbang-kompas-luthfi-yasin-yakin-masyarakat-jateng-cerdas_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Daftar Negara Bagian Kunci Pilpres AS",
        "link": "https://www.cnnindonesia.com/internasional/20241106113758-134-1163518/daftar-negara-bagian-kunci-pilpres-as",
        "contentSnippet": "Berikut daftar pemilih elektoral dari setiap swing state yang ada di pilpres AS.",
        "isoDate": "2024-11-06T06:34:43.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/11/06/pilpres-as-2024-4_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/11/06/pilpres-as-2024-4_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Cara Beli Pertamax Murah di Hari Senin dan Jumat",
        "link": "https://www.cnnindonesia.com/otomotif/20241106115159-584-1163522/cara-beli-pertamax-murah-di-hari-senin-dan-jumat",
        "contentSnippet": "Membeli Bahan Bakar Minyak (BBM) jenis Pertamax mendapatkan potongan harga di hari Senin dan Jumat.",
        "isoDate": "2024-11-06T06:34:09.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2023/07/24/pertamax-green-95-14_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2023/07/24/pertamax-green-95-14_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Razman Duga Polisi Tak Profesional di Kasus Nikita Mirzani vs Vadel",
        "link": "https://www.cnnindonesia.com/hiburan/20241106125334-234-1163562/razman-duga-polisi-tak-profesional-di-kasus-nikita-mirzani-vs-vadel",
        "contentSnippet": "Razman Arif Nasution mengajukan laporan dugaan penyidik tidak profesional menangani kasus yang menjerat Vadel Badjideh.",
        "isoDate": "2024-11-06T06:30:18.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/10/04/razman-arif-nasution_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/10/04/razman-arif-nasution_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Total Utang 1 Juta UMKM yang Dihapus Prabowo Tembus Rp10 T",
        "link": "https://www.cnnindonesia.com/ekonomi/20241106093635-78-1163451/total-utang-1-juta-umkm-yang-dihapus-prabowo-tembus-rp10-t",
        "contentSnippet": "Menteri Usaha Mikro, Kecil, Menengah (UMKM) Maman Abdurrahman buka-bukaan soal nilai utang pengusaha cilik yang akan dihapus oleh Presiden Prabowo Subianto.",
        "isoDate": "2024-11-06T06:29:36.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2017/11/27/6e370bf3-629d-4d0f-8651-430b3228bd5a_169.jpg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2017/11/27/6e370bf3-629d-4d0f-8651-430b3228bd5a_169.jpg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] VIDEO: Jutaan Warga AS Pilih Presiden, Bakal Catat Sejarah Baru",
        "link": "https://www.cnnindonesia.com/internasional/20241106082648-139-1163433/video-jutaan-warga-as-pilih-presiden-bakal-catat-sejarah-baru",
        "contentSnippet": "Pemilihan Presiden AS 2024 tengah berlangsung saat puluhan juta warga AS memberikan suara mereka.",
        "isoDate": "2024-11-06T06:23:27.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/11/06/thumbnail-video-2_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/11/06/thumbnail-video-2_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] KPK Geledah Sejumlah Lokasi Cari Gubernur Sahbirin Noor, Hasil Nihil",
        "link": "https://www.cnnindonesia.com/nasional/20241106130630-12-1163567/kpk-geledah-sejumlah-lokasi-cari-gubernur-sahbirin-noor-hasil-nihil",
        "contentSnippet": "KPK sudah menggeledah sejumlah tempat yang diduga menjadi tempat persembunyian Gubernur Kalimantan Selatan (Kalsel) Sahbirin Noor alias Paman Birin.",
        "isoDate": "2024-11-06T06:18:16.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/11/05/sahbirin-noor_169.png?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/11/05/sahbirin-noor_169.png?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Trump Menang di 2 Swing States, Georgia dan North Carolina",
        "link": "https://www.cnnindonesia.com/internasional/20241106130641-134-1163568/trump-menang-di-2-swing-states-georgia-dan-north-carolina",
        "contentSnippet": "Capres dari Partai Republik Donald Trump diprediksi menang di negara bagian Georgia dan North Carolina dalam pemilihan presiden atau Pilpres AS 2024.",
        "isoDate": "2024-11-06T06:17:52.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/09/11/debat-pilpres-as-mulai-kamala-harris-langsung-serang-trump-4_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/09/11/debat-pilpres-as-mulai-kamala-harris-langsung-serang-trump-4_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Dua Warga Aceh Terlibat Penyelundupan Imigran Rohingya",
        "link": "https://www.cnnindonesia.com/nasional/20241106124543-12-1163551/dua-warga-aceh-terlibat-penyelundupan-imigran-rohingya",
        "contentSnippet": "Dua warga Aceh dan satu warga Myanmar ditangkap karena penyelundupan imigran Rohingya. Di tempat lain, Polda Sumut menangkap dua pelaku TPPO ke Malaysia.",
        "isoDate": "2024-11-06T06:14:20.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/10/31/rombongan-imigran-rohingya-kembali-mendarat-di-pantai-aceh-4_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/10/31/rombongan-imigran-rohingya-kembali-mendarat-di-pantai-aceh-4_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] BRI Peduli Tanggap Bantu Korban Erupsi Gunung Lewotobi Laki-laki",
        "link": "https://www.cnnindonesia.com/ekonomi/20241106130312-625-1163564/bri-peduli-tanggap-bantu-korban-erupsi-gunung-lewotobi-laki-laki",
        "contentSnippet": "Gerak cepat BRI Peduli diwujudkan lewat Tim Elang Relawan BRI serta Insan BRILian Unit Kerja Boru yang turun langsung membantu warga terdampak.",
        "isoDate": "2024-11-06T06:09:28.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/11/06/bri_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/11/06/bri_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] PPATK: Pemain Judi Online Makin Muda, Ada di Bawah 10 Tahun",
        "link": "https://www.cnnindonesia.com/nasional/20241106130544-12-1163566/ppatk-pemain-judi-online-makin-muda-ada-di-bawah-10-tahun",
        "contentSnippet": "PPATK menyatakan pemain judi online kini kian masif di hampir semua kalangan usia. Ada anak berusia di bawah 10 tahun ikut bermain.",
        "isoDate": "2024-11-06T06:09:22.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/06/15/ilustrasi-judi-online-6_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/06/15/ilustrasi-judi-online-6_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Sinergi BRI dan HIPMI Dorong Pengusaha Muda Naik Kelas",
        "link": "https://www.cnnindonesia.com/ekonomi/20241106125408-625-1163560/sinergi-bri-dan-hipmi-dorong-pengusaha-muda-naik-kelas",
        "contentSnippet": "Kerja sama BRI dan HIPMI membuka peluang bagi anggota HIPMI untuk mendapatkan akses permodalan dan layanan perbankan yang lebih luas dan terjangkau.",
        "isoDate": "2024-11-06T06:06:08.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/11/06/bnr-bri-35375-6-november-2024_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/11/06/bnr-bri-35375-6-november-2024_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Gregoria Mariska Sudah 100 Persen Pulih dari Cedera",
        "link": "https://www.cnnindonesia.com/olahraga/20241106123708-170-1163545/gregoria-mariska-sudah-100-persen-pulih-dari-cedera",
        "contentSnippet": "Gregoria Mariska Tunjung menyatakan telah pulih sepenuhnya dari cedera pinggang yang dialaminya saat bertanding di semifinal Denmark Open 2024, Oktober lalu.",
        "isoDate": "2024-11-06T06:02:38.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/11/06/gregoria-mariska-tunjung_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/11/06/gregoria-mariska-tunjung_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Demi Jualan iPhone 16, Apple Dirumorkan Mau Bangun Pabrik di Bandung",
        "link": "https://www.cnnindonesia.com/teknologi/20241106125618-206-1163563/demi-jualan-iphone-16-apple-dirumorkan-mau-bangun-pabrik-di-bandung",
        "contentSnippet": "Apple dikabarkan akan membangun pabrik di Bandung demi bisa jualan iPhone 16 di Indonesia.",
        "isoDate": "2024-11-06T06:01:52.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/09/10/penampakan-iphone-16-resmi-meluncur_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/09/10/penampakan-iphone-16-resmi-meluncur_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Kemenkes: Kado Ultah Medical Check Up Termasuk Skrining Masalah Tiroid",
        "link": "https://www.cnnindonesia.com/gaya-hidup/20241105175424-255-1163313/kemenkes-kado-ultah-medical-check-up-termasuk-skrining-masalah-tiroid",
        "contentSnippet": "Wakil Menteri Kesehatan Dante Saksono menyebut, program medical check up gratis di hari ulang tahun termasuk di dalamnya skrining gangguan tiroid.",
        "isoDate": "2024-11-06T06:00:10.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/08/09/wakil-menteri-kesehatan-dante-saksono-harbuwono_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/08/09/wakil-menteri-kesehatan-dante-saksono-harbuwono_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Pengertian Migrasi Penduduk, Penyebab, dan Jenis-jenisnya",
        "link": "https://www.cnnindonesia.com/edukasi/20241101141845-569-1161990/pengertian-migrasi-penduduk-penyebab-dan-jenis-jenisnya",
        "contentSnippet": "Migrasi adalah salah satu bentuk mobilitas penduduk. Simak pengertian, faktor penyebab, dan jenis-jenis migrasi.",
        "isoDate": "2024-11-06T06:00:00.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/04/06/muka-lelah-para-bocah-saat-ikut-mudik-lebaran-10_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/04/06/muka-lelah-para-bocah-saat-ikut-mudik-lebaran-10_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Update Pemilu AS, Ini Daftar Negara Bagian Trump Unggul di Pilpres",
        "link": "https://www.cnnindonesia.com/internasional/20241106120125-134-1163527/update-pemilu-as-ini-daftar-negara-bagian-trump-unggul-di-pilpres",
        "contentSnippet": "Pemilihan presiden Amerika Serikat atau pilpres AS 2024 sudah resmi digelar pada Selasa (5/11) kemarin.",
        "isoDate": "2024-11-06T05:59:33.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/09/11/debat-perdana-duel-trump-vs-kamala-harris-di-pilpres-as-2024-13_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/09/11/debat-perdana-duel-trump-vs-kamala-harris-di-pilpres-as-2024-13_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] 3 Hakim PN Surabaya-Zarof Ricar Kembali Diperiksa Kasus Ronald Tannur",
        "link": "https://www.cnnindonesia.com/nasional/20241106123315-12-1163547/3-hakim-pn-surabaya-zarof-ricar-kembali-diperiksa-kasus-ronald-tannur",
        "contentSnippet": "Tiga Majelis Hakim PN Surabaya dan eks pejabat Mahkamah Agung Zarof Ricar kembali diperiksa selaku tersangka kasus suap vonis bebas Gregorius Ronald Tannur.",
        "isoDate": "2024-11-06T05:49:07.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/10/24/penangkapan-hakim-pemberi-vonis-bebas-ronald-tannur-3_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/10/24/penangkapan-hakim-pemberi-vonis-bebas-ronald-tannur-3_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Update Hasil Pemilu AS, Trump Menang Swing State di North Carolina",
        "link": "https://www.cnnindonesia.com/internasional/20241106123346-134-1163544/update-hasil-pemilu-as-trump-menang-swing-state-di-north-carolina",
        "contentSnippet": "Trump memenangkan seluruh suara elektoral di salah satu negara swing state, North Carolina.",
        "isoDate": "2024-11-06T05:44:18.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/07/19/trump-resmi-jadi-capres-partai-republik-2_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/07/19/trump-resmi-jadi-capres-partai-republik-2_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] AXA Mandiri Luncurkan Asuransi Mandiri Masa Depan Sejahtera",
        "link": "https://www.cnnindonesia.com/ekonomi/20241106123709-625-1163546/axa-mandiri-luncurkan-asuransi-mandiri-masa-depan-sejahtera",
        "contentSnippet": "Asuransi Mandiri Masa Depan Sejahtera ini akan membantu melindungi nasabah, sekaligus mewujudkan pendidikan berkualitas hingga jenjang universitas untuk anak.",
        "isoDate": "2024-11-06T05:39:29.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/11/06/axa-mandiri_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/11/06/axa-mandiri_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Warga Cirebon Tolak Pendirian Gereja, Pj Walkot dan DPRD Buka Suara",
        "link": "https://www.cnnindonesia.com/nasional/20241106121247-20-1163535/warga-cirebon-tolak-pendirian-gereja-pj-walkot-dprd-buka-suara",
        "contentSnippet": "Pj Wali Kota Cirebon hingga Ketua DPRD Kota Cirebon buka suara terkait insiden penolakan pendirian gereja di Pegambiran.",
        "isoDate": "2024-11-06T05:38:36.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2021/04/05/ilustrasi-pluralisme_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2021/04/05/ilustrasi-pluralisme_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Syakir Sulaiman Eks Timnas U-23 Ditangkap, Diduga Jual Obat Terlarang",
        "link": "https://www.cnnindonesia.com/olahraga/20241106122348-142-1163538/syakir-sulaiman-eks-timnas-u-23-ditangkap-diduga-jual-obat-terlarang",
        "contentSnippet": "Mantan pemain Timnas Indonesia U-23 Syakir Sulaiman ditangkap polisi usai diduga jadi pengedar obat-obatan terlarang.",
        "isoDate": "2024-11-06T05:36:46.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2016/01/25/c89c7d4e-00e2-4d92-8a1a-f69476d9410c_169.jpg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2016/01/25/c89c7d4e-00e2-4d92-8a1a-f69476d9410c_169.jpg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Ide RK Benahi DKI: Jadi Kota Wisata dan Beri Kredit Tanpa Bunga",
        "link": "https://www.cnnindonesia.com/ekonomi/20241106120708-532-1163529/ide-rk-benahi-dki-jadi-kota-wisata-dan-beri-kredit-tanpa-bunga",
        "contentSnippet": "Ridwan Kamil ingin membenahi Jakarta dengan menyulap DKI jadi kota wisata hingga memberi kredit tanpa bunga bagi masyarakat bawah.",
        "isoDate": "2024-11-06T05:36:09.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/10/24/calon-gubernur-dki-jakarta-nomor-urut-1-ridwan-kamil-menyapa-pedagang-dan-warga-di-pasar-kebayoran-lama-3_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/10/24/calon-gubernur-dki-jakarta-nomor-urut-1-ridwan-kamil-menyapa-pedagang-dan-warga-di-pasar-kebayoran-lama-3_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] PPATK: Transaksi Judi Online Naik 237,48 Persen di 2024",
        "link": "https://www.cnnindonesia.com/nasional/20241106122710-12-1163540/ppatk-transaksi-judi-online-naik-23748-persen-di-2024",
        "contentSnippet": "PPATK mencatat kenaikan transaksi judi online (judol) yang mencapai 237,48 persen sepanjang semester pertama 2024.",
        "isoDate": "2024-11-06T05:34:53.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/11/02/bareskrim-ungkap-kasus-judi-online-3_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/11/02/bareskrim-ungkap-kasus-judi-online-3_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Imajinasi RK soal Reklamasi Ancol: Buat CBD, Pusat Pemerintahan Pindah",
        "link": "https://www.cnnindonesia.com/nasional/20241106122244-617-1163537/imajinasi-rk-soal-reklamasi-ancol-buat-cbd-pusat-pemerintahan-pindah",
        "contentSnippet": "Calon Gubernur Jakarta Nomor Urut 1 Ridwan Kamil akan membuat 200 hektare reklamasi di Ancol yang akan digunakan untuk sentral bisnis dan pusat pemerintahan.",
        "isoDate": "2024-11-06T05:32:37.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2021/01/09/pulau-reklamasi-1_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2021/01/09/pulau-reklamasi-1_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Paul Rudd Mampir ke TPS, Bagi-bagi Minuman dan Camilan",
        "link": "https://www.cnnindonesia.com/hiburan/20241106115427-234-1163525/paul-rudd-mampir-ke-tps-bagi-bagi-minuman-dan-camilan",
        "contentSnippet": "Paul Rudd tertangkap kamera sedang bagi-bagi minuman dan makanan ringan di tempat pemungutan suara (TPS) di Pennsylvania pada hari pemilihan umum AS 2024.",
        "isoDate": "2024-11-06T05:30:51.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2021/05/31/paul-rudd_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2021/05/31/paul-rudd_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Isi Garasi Basuki yang Baru Dilantik Jadi Kepala OIKN",
        "link": "https://www.cnnindonesia.com/otomotif/20241106105647-579-1163496/isi-garasi-basuki-yang-baru-dilantik-jadi-kepala-oikn",
        "contentSnippet": "Basuki memiliki motor Royal Enfield Bullet Classic lansiran 2017 yang nilainya ditaksir Rp40 juta.",
        "isoDate": "2024-11-06T05:30:45.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/11/05/pelantikan-basuki-hadimuljono-sebagai-kepala-oikn_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/11/05/pelantikan-basuki-hadimuljono-sebagai-kepala-oikn_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Pemuda di Cirebon Bakar Rumah Orang Tua karena Tak Dibelikan Motor",
        "link": "https://www.cnnindonesia.com/nasional/20241106113456-12-1163517/pemuda-di-cirebon-bakar-rumah-orang-tua-karena-tak-dibelikan-motor",
        "contentSnippet": "Atas perbuatannya, RC (21) dijerat Pasal 187 KUHP ayat 1 tentang tindak pidana pembakaran dengan ancaman hukuman di atas lima tahun penjara.",
        "isoDate": "2024-11-06T05:26:08.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2023/12/24/ilustrasi-kebakaran-pabrik_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2023/12/24/ilustrasi-kebakaran-pabrik_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Tim Cahill Latih Timnas Malaysia?",
        "link": "https://www.cnnindonesia.com/olahraga/20241106120717-142-1163531/tim-cahill-latih-timnas-malaysia",
        "contentSnippet": "Spekulasi legenda sepak bola Australia, Tim Cahill, melatih timnas Malaysia ramai diberitakan media-media setempat.",
        "isoDate": "2024-11-06T05:17:35.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/11/06/legenda-timnas-australia-tim-cahill_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/11/06/legenda-timnas-australia-tim-cahill_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] China Perluas Akses Masuk Bebas Visa untuk 9 Negara, Ada Indonesia?",
        "link": "https://www.cnnindonesia.com/gaya-hidup/20240325173826-269-1078827/china-perluas-akses-masuk-bebas-visa-untuk-9-negara-ada-indonesia",
        "contentSnippet": "China bakal memperluas akses masuk bebas visa ke negaranya untuk pelancong yang berasal dari 9 negara tambahan.",
        "isoDate": "2024-11-06T05:15:19.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2023/04/14/ilustrasi-peta-china_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2023/04/14/ilustrasi-peta-china_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Trump Diprediksi Ungguli Suara Electoral College Pilpres AS 2024",
        "link": "https://www.cnnindonesia.com/internasional/20241106113837-134-1163519/trump-diprediksi-ungguli-suara-electoral-college-pilpres-as-2024",
        "contentSnippet": "Hasil prediksi memperkirakan Donald Trump akan unggul di electoral college hingga menangkan suara mayoritas di negara swing state.",
        "isoDate": "2024-11-06T05:10:48.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/11/06/usa-electiontrump_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/11/06/usa-electiontrump_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] RK Cerita Pengalaman Buruk Nonton Konser di JIS: Pulang 7 Jam",
        "link": "https://www.cnnindonesia.com/nasional/20241106115045-617-1163521/rk-cerita-pengalaman-buruk-nonton-konser-di-jis-pulang-7-jam",
        "contentSnippet": "Ridwan Kamil mengaku pernah mendapat pengalaman buruk saat nonton konser Dewa 19 di JIS. Ia ingin memperbaiki infrastruktur penunjang.",
        "isoDate": "2024-11-06T05:07:02.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/03/02/ribuan-fan-mulai-padati-jis-untuk-nantikan-konser-ed-sheeran_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/03/02/ribuan-fan-mulai-padati-jis-untuk-nantikan-konser-ed-sheeran_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] PGRI Minta Pemerintah Kaji Ulang Kurikulum Merdeka Belajar Nadiem",
        "link": "https://www.cnnindonesia.com/nasional/20241106112918-20-1163516/pgri-minta-pemerintah-kaji-ulang-kurikulum-merdeka-belajar-nadiem",
        "contentSnippet": "Persatuan Guru Republik Indonesia (PGRI) meminta pemerintah mengkaji ulang kurikulum Merdeka Belajar yang diterapkan Mendikbudristek Nadiem Makarim.",
        "isoDate": "2024-11-06T05:01:32.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2020/07/24/ilustrasi-logo-pgri_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2020/07/24/ilustrasi-logo-pgri_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Pengusaha Bakal Dampingi Prabowo ke Luar Negeri",
        "link": "https://www.cnnindonesia.com/ekonomi/20241106101208-92-1163478/pengusaha-bakal-dampingi-prabowo-ke-luar-negeri",
        "contentSnippet": "Ketua Kadin Indonesia Anindya Bakrie akan mendampingi lawatan perdana Presiden Prabowo Subianto ke luar negeri selama dua pekan lebih.",
        "isoDate": "2024-11-06T05:00:32.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/09/15/polemik-munaslub-kadin-23_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/09/15/polemik-munaslub-kadin-23_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Pakar Prediksi Harris Menang, Bayi Kuda Nil Pilih Trump, Siapa Benar?",
        "link": "https://www.cnnindonesia.com/internasional/20241105154328-134-1163227/pakar-prediksi-harris-menang-bayi-kuda-nil-pilih-trump-siapa-benar",
        "contentSnippet": "Pakar politik yang pernah benar 9 kali dalam memprediksi pemenang pemilihan presiden (pilpres) Amerika Serikat mengungkap prediksinya untuk Pilpres AS 2024.",
        "isoDate": "2024-11-06T04:55:34.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/07/25/kamala-harris-vs-donald-trump_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/07/25/kamala-harris-vs-donald-trump_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Yasonna Desak Revisi UU Narkoba, Bandar dan Pemakai Dipisah Lapas",
        "link": "https://www.cnnindonesia.com/nasional/20241106101253-20-1163512/yasonna-desak-revisi-uu-narkoba-bandar-dan-pemakai-dipisah-lapas",
        "contentSnippet": "Anggota Komisi XIII Yasonna Laoly mendorong Kementerian Imigrasi dan Pemasyarakatan memisahkan lembaga pemasyarakatan bagi bandar, kurir, dan pengguna narkoba.",
        "isoDate": "2024-11-06T04:53:45.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2019/09/20/633efb49-5e37-4e80-b42e-c547fa7fd15d_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2019/09/20/633efb49-5e37-4e80-b42e-c547fa7fd15d_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] IShowSpeed Ajari Pogba Bahasa Indonesia: Santai, Awas, Minggir Miskin",
        "link": "https://www.cnnindonesia.com/olahraga/20241106112318-142-1163515/ishowspeed-ajari-pogba-bahasa-indonesia-santai-awas-minggir-miskin",
        "contentSnippet": "Youtuber asal Amerika Serikat IShowSpeed menjadi sorotan lantaran mengajari Paul Pogba beberapa kosa kata bahasa Indonesia.",
        "isoDate": "2024-11-06T04:44:11.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2023/05/12/juventus-vs-sevilla-4_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2023/05/12/juventus-vs-sevilla-4_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] RK Mau Perbanyak Konser di Jakarta, Janji Perbaiki Infrastruktur",
        "link": "https://www.cnnindonesia.com/nasional/20241106111620-617-1163503/rk-mau-perbanyak-konser-di-jakarta-janji-perbaiki-infrastruktur",
        "contentSnippet": "Ridwan Kamil ingin ada lebih banyak konser konser bertaraf internasional jika terpilih pada Pilkada 2024.",
        "isoDate": "2024-11-06T04:38:20.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2023/01/31/ridwan-kamil-2_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2023/01/31/ridwan-kamil-2_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Menbud Fadli Zon: Inggris Tak Mau Kembalikan Benda Sejarah Indonesia",
        "link": "https://www.cnnindonesia.com/nasional/20241106111035-20-1163502/menbud-fadli-zon-inggris-tak-mau-kembalikan-benda-sejarah-indonesia",
        "contentSnippet": "Menteri Kebudayaan Fadli Zon menyebut Inggris tak mau mengembalikan benda-benda bersejarah Indonesia yang kini masih berada di Negara Raja Charles III tersebut.",
        "isoDate": "2024-11-06T04:31:47.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/10/21/jajaran-menteri-kabinet-merah-putih-13_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/10/21/jajaran-menteri-kabinet-merah-putih-13_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Viral Masak Mi Instan Direbus dengan Kemasannya, Awas Bahaya",
        "link": "https://www.cnnindonesia.com/gaya-hidup/20241106094358-262-1163462/viral-masak-mi-instan-direbus-dengan-kemasannya-awas-bahaya",
        "contentSnippet": "Media sosial tengah ramai sebuah sebuah video yang memperlihatkan seorang pedagang merebus mi instan bersamaan dengan kemasan plastiknya. Apakah aman?",
        "isoDate": "2024-11-06T04:30:59.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2021/01/28/ilustrasi-mie-instan_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2021/01/28/ilustrasi-mie-instan_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Sule Jawab Kekhawatiran Soal Rumah Tangga Rizky Febian dan Mahalini",
        "link": "https://www.cnnindonesia.com/hiburan/20241106110252-234-1163498/sule-jawab-kekhawatiran-soal-rumah-tangga-rizky-febian-dan-mahalini",
        "contentSnippet": "Sule menjawab kekhawatiran soal nasib rumah tangga Rizky Febian dan Mahalini di masa depan.",
        "isoDate": "2024-11-06T04:30:02.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2023/09/19/sule_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2023/09/19/sule_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Apakah Warga Negara Asing Bisa Ikut 'Nyoblos' Pilpres AS?",
        "link": "https://www.cnnindonesia.com/internasional/20241106111727-134-1163505/apakah-warga-negara-asing-bisa-ikut-nyoblos-pilpres-as",
        "contentSnippet": "Apakah WNA bisa ikut nyoblos untuk pemilihan presiden (pilpres) AS?",
        "isoDate": "2024-11-06T04:28:25.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/11/06/pilpres-as-2024-7_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/11/06/pilpres-as-2024-7_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Pakai Software Gratis, Pria Ini Temukan Bilangan Prima Terbesar",
        "link": "https://www.cnnindonesia.com/teknologi/20241106104241-199-1163491/pakai-software-gratis-pria-ini-temukan-bilangan-prima-terbesar",
        "contentSnippet": "Seorang mantan karyawan Nvidia dan ilmuwan amatir berhasil menemukan bilangan prima terbesar di dunia. Bagaimana dia menemukannya?",
        "isoDate": "2024-11-06T04:27:14.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2015/01/08/95355823-d89e-4243-af7f-448d8f4cfd0e_169.jpg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2015/01/08/95355823-d89e-4243-af7f-448d8f4cfd0e_169.jpg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Usai Diuji Coba, BPJS Kesehatan Syarat Buat SIM Berlaku Desember 2024",
        "link": "https://www.cnnindonesia.com/otomotif/20241106111233-579-1163501/usai-diuji-coba-bpjs-kesehatan-syarat-buat-sim-berlaku-desember-2024",
        "contentSnippet": "Saat ini syarat kesertaaan Badan Penyelenggara Jaminan Sosial (BPJS) Kesehatan untuk membuat maupun memperpanjang SIM masih dalam tahap uji coba.",
        "isoDate": "2024-11-06T04:22:48.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/08/20/sim-format-baru-3_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/08/20/sim-format-baru-3_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Zulhas Buka Suara soal Dugaan Kasus Korupsi Impor Gula Tom Lembong",
        "link": "https://www.cnnindonesia.com/ekonomi/20241106102141-92-1163484/zulhas-buka-suara-soal-dugaan-kasus-korupsi-impor-gula-tom-lembong",
        "contentSnippet": "Menko Pangan Zulkifli Hasan (Zulhas) buka suara terkait kasus korupsi impor gula yang menjerat mantan menteri perdagangan Thomas Trikasih Lembong (Tom Lembong).",
        "isoDate": "2024-11-06T04:15:10.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/07/06/menteri-perdagangan-ri-zulkifli-hasan-1_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/07/06/menteri-perdagangan-ri-zulkifli-hasan-1_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Program Mendikdasmen Mu'ti: Matematika Sejak TK - Kualifikasi Guru",
        "link": "https://www.cnnindonesia.com/nasional/20241106105452-20-1163495/program-mendikdasmen-muti-matematika-sejak-tk-kualifikasi-guru",
        "contentSnippet": "Dalam raker dengan Komisi X DPR, Mendikdasmen mengaku pengajaran matematika sejak TK sudah dipraktikkan dalam kunjungannya ke TK di lingkungan TNI AU.",
        "isoDate": "2024-11-06T04:13:48.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/10/15/abdul-muti-2_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/10/15/abdul-muti-2_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Ancelotti Khawatir Real Madrid Kalah Terus",
        "link": "https://www.cnnindonesia.com/olahraga/20241106103934-142-1163489/ancelotti-khawatir-real-madrid-kalah-terus",
        "contentSnippet": "Musim ini Real Madrid sudah menelan tiga kekalahan dari 15 pertandingan. Musim lalu Los Blancos hanya kalah dua kali sepanjang musim.",
        "isoDate": "2024-11-06T04:12:22.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/11/06/real-madrid-vs-ac-milan-8_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/11/06/real-madrid-vs-ac-milan-8_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] TNI Sebut OPM Tembak dan Tikam Warga Sipil di Papua",
        "link": "https://www.cnnindonesia.com/nasional/20241106105019-12-1163493/tni-sebut-opm-tembak-dan-tikam-warga-sipil-di-papua",
        "contentSnippet": "Kodam XVII/Cenderawasih menyatakan Organisasi Papua Merdeka (OPM) menembak dan menikam dua warga sipil di Papua dalam beberapa hari belakangan.",
        "isoDate": "2024-11-06T04:07:45.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2023/04/14/pesawat-asian-one-ditembak-di-kabupaten-puncak-papua-1_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2023/04/14/pesawat-asian-one-ditembak-di-kabupaten-puncak-papua-1_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Memahami Pengertian dan Contoh Kalimat Negasi Bahasa Indonesia",
        "link": "https://www.cnnindonesia.com/edukasi/20241105085519-569-1163045/memahami-pengertian-dan-contoh-kalimat-negasi-bahasa-indonesia",
        "contentSnippet": "Dalam komunikasi, manusia menggunakan kalimat negasi untuk menyangkal atau mengingkari sesuatu. Simak pengertian dan contoh kalimat negasi bahasa Indonesia.",
        "isoDate": "2024-11-06T04:00:20.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2015/07/21/c039775b-06aa-414f-aca2-47d7c894dab3_169.jpg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2015/07/21/c039775b-06aa-414f-aca2-47d7c894dab3_169.jpg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Penguasa Pasar Motor Angkat Bicara Pencapaian Penjualan 2024",
        "link": "https://www.cnnindonesia.com/otomotif/20241106104609-595-1163492/penguasa-pasar-motor-angkat-bicara-pencapaian-penjualan-2024",
        "contentSnippet": "Kenaikan penjualan sepeda motor tahun ini disebabkan oleh faktor stabilitas ekonomi, kondisi pertanian, komoditas, serta bantuan pemerintah.",
        "isoDate": "2024-11-06T04:00:09.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/10/09/ahm-luncurkan-honda-icon-e-dan-cuv-e-12_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/10/09/ahm-luncurkan-honda-icon-e-dan-cuv-e-12_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] PGRI Dukung Rencana Penerapan Kembali Ujian Nasional",
        "link": "https://www.cnnindonesia.com/nasional/20241106101902-20-1163490/pgri-dukung-rencana-penerapan-kembali-ujian-nasional",
        "contentSnippet": "Persatuan Guru Republik Indonesia (PGRI) mendukung rencana penerapan kembali ujian nasional (UN) sebagai syarat kelulusan yang sempat dihapus Nadiem pada 2021.",
        "isoDate": "2024-11-06T03:56:54.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2020/07/24/ilustrasi-logo-pgri_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2020/07/24/ilustrasi-logo-pgri_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Malaysia Usul Usir Israel dari Keanggotaan PBB",
        "link": "https://www.cnnindonesia.com/internasional/20241106103137-106-1163487/malaysia-siapkan-draf-resolusi-coret-israel-dari-pbb",
        "contentSnippet": "PM Malaysia, Anwar Ibrahim mengumumkan Kuala Lumpur tengah menyiapkan draf resolusi terkait agresi Israel di Palestina untuk diajukan ke Majelis Umum PBB",
        "isoDate": "2024-11-06T03:51:02.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2023/10/25/anwar-ibrahim-ikut-demo-bela-palestina_169.png?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2023/10/25/anwar-ibrahim-ikut-demo-bela-palestina_169.png?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] KPK Periksa Wakil Ketua DPRD Probolinggo Telusuri Aliran Dana Hibah",
        "link": "https://www.cnnindonesia.com/nasional/20241106095622-12-1163467/kpk-periksa-wakil-ketua-dprd-probolinggo-telusuri-aliran-dana-hibah",
        "contentSnippet": "KPK menelusuri aliran uang diduga terkait dengan korupsi dana hibah yang diterima oleh Anggota DPRD Provinsi Jawa Timur 2019-2024 berinisial AS.",
        "isoDate": "2024-11-06T03:46:55.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2017/02/20/20ed4631-125c-483d-a296-335d47a811b6_169.jpg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2017/02/20/20ed4631-125c-483d-a296-335d47a811b6_169.jpg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] FOTO: Pemeriksaan Hakim Pemberi Vonis Bebas Ronald Tannur di Kejagung",
        "link": "https://www.cnnindonesia.com/nasional/20241106090520-14-1163438/foto-pemeriksaan-hakim-pemberi-vonis-bebas-ronald-tannur-di-kejagung",
        "contentSnippet": "Selain diperiksa di gedung Kejagung, tiga hakim PN Surabaya tersangka dugaan suap vonis bebas Ronald Tannur pun dipindahkan penahanannya ke Jakarta.",
        "isoDate": "2024-11-06T03:46:32.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/11/06/pemeriksaan-eks-pejabat-ma-zarof-ricar-di-kejagung-2_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/11/06/pemeriksaan-eks-pejabat-ma-zarof-ricar-di-kejagung-2_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Lebih Jauh Mengenal Bakteri yang Ditemukan dalam Jajanan Latiao",
        "link": "https://www.cnnindonesia.com/gaya-hidup/20241106092026-255-1163447/lebih-jauh-mengenal-bakteri-yang-ditemukan-dalam-jajanan-latiao",
        "contentSnippet": "Jajanan asal China, Latiao, kini ditarik dari peredarannya di Indonesia. Pasalnya, jajanan tersebut mengandung bakteri berbahaya Bacelius cerius.",
        "isoDate": "2024-11-06T03:45:38.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2021/11/30/ilustrasi-haid-menstruasi-1_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2021/11/30/ilustrasi-haid-menstruasi-1_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Man City Kalah 3 Kali Beruntun, Alarm Bahaya bagi Guardiola",
        "link": "https://www.cnnindonesia.com/olahraga/20241106103055-142-1163486/man-city-kalah-3-kali-beruntun-alarm-bahaya-bagi-guardiola",
        "contentSnippet": "Pelatih Manchester City Pep Guardiola semakin tertantang melakukan perubahan setelah The Citizens menelan tiga kekalahan beruntun di berbagai kompetisi.",
        "isoDate": "2024-11-06T03:43:50.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/11/06/sporting-cp-vs-manchester-city-2_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/11/06/sporting-cp-vs-manchester-city-2_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Pebisnis Minta Pemerintah Buat Aturan Harga Minimum Baju di E-Commerce",
        "link": "https://www.cnnindonesia.com/ekonomi/20241104195306-92-1162975/pebisnis-minta-pemerintah-buat-aturan-harga-minimum-baju-di-e-commerce",
        "contentSnippet": "Asosiasi Pertekstilan Indonesia (API) meminta pemerintah menerapkan aturan harga minimum produk baik di e-commerce maupun di pusat perbelanjaan tekstil.",
        "isoDate": "2024-11-06T03:35:24.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/03/04/ilustrasi-foto-toko-pakaian-jelang-ramadan_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/03/04/ilustrasi-foto-toko-pakaian-jelang-ramadan_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Sinopsis The Lyle and Erik Menendez Story, Kasus Anak Bunuh Orang Tua",
        "link": "https://www.cnnindonesia.com/hiburan/20241106094844-220-1163465/sinopsis-the-lyle-and-erik-menendez-story-kasus-anak-bunuh-orang-tua",
        "contentSnippet": "Bertajuk The Lyle and Erik Menendez Story, serial Monsters akan membahas salah satu pelaku pembunuhan paling drama dan kontroversial dalam sejarah AS.",
        "isoDate": "2024-11-06T03:30:14.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/11/04/monsters-the-lyle-and-erik-menendez-story_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/11/04/monsters-the-lyle-and-erik-menendez-story_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] FOTO: Jalan Penghubung Tangerang-Bogor Putus Akibat Longsor",
        "link": "https://www.cnnindonesia.com/nasional/20241106100610-22-1163471/foto-jalan-penghubung-tangerang-bogor-putus-akibat-longsor",
        "contentSnippet": "Longsor di Pagedangan, Tangerang, menyebabkan jalan penghubung dengan Bogor terputus.",
        "isoDate": "2024-11-06T03:30:00.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/11/06/tanah-longsor-di-pagedangan-tangerang-5_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/11/06/tanah-longsor-di-pagedangan-tangerang-5_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Prabowo Terima Kunjungan PM Singapura Lawrence Wong di Istana Jakarta",
        "link": "https://www.cnnindonesia.com/internasional/20241106101826-106-1163483/prabowo-terima-kunjungan-pm-singapura-lawrence-wong-di-istana-jakarta",
        "contentSnippet": "Presiden Prabowo Subianto menerima kunjungan Perdana Menteri (PM) Singapura Lawrence Wong di Istana Merdeka Jakarta, Rabu (6/11).",
        "isoDate": "2024-11-06T03:25:30.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/11/06/presiden-prabowo-terima-kunjungan-pm-singapura-lawrence-wong_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/11/06/presiden-prabowo-terima-kunjungan-pm-singapura-lawrence-wong_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Timnas Malaysia Semakin Terpuruk usai Gagal di Piala AFF Futsal",
        "link": "https://www.cnnindonesia.com/olahraga/20241106101603-142-1163481/timnas-malaysia-semakin-terpuruk-usai-gagal-di-piala-aff-futsal",
        "contentSnippet": "Sepak bola Malaysia semakin terpuruk setelah timnas futsal Malaysia mengalami kegagalan di Piala AFF Futsal 2024 dengan tidak lolos ke semifinal.",
        "isoDate": "2024-11-06T03:23:15.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2023/10/10/kualifikasi-piala-asia-futsal-2024-4_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2023/10/10/kualifikasi-piala-asia-futsal-2024-4_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Gelar INKOMPASS Challenge, Sampoerna Siap Lahirkan Inovator Muda",
        "link": "https://www.cnnindonesia.com/ekonomi/20241106101208-625-1163479/gelar-inkompass-challenge-sampoerna-siap-lahirkan-inovator-muda",
        "contentSnippet": "INKOMPASS Innovation Challenge adalah kompetisi pencarian ide bisnis disruptif yang mendukung Sampoerna Retail Community (SRC) untuk memberi dampak positif.",
        "isoDate": "2024-11-06T03:17:30.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/11/06/sampoerna_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/11/06/sampoerna_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Dua Ormas Bentrok di Setu Tangsel, Posko Dibakar Massa",
        "link": "https://www.cnnindonesia.com/nasional/20241106100208-12-1163468/dua-ormas-bentrok-di-setu-tangsel-posko-dibakar-massa",
        "contentSnippet": "Dua ormas bentrok di Setu, Tangerang Selatan, Selasa (5/11) malam. Satu posko ormas dibakar massa.",
        "isoDate": "2024-11-06T03:15:02.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2022/03/30/ilustrasi-tawuran-sahur_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2022/03/30/ilustrasi-tawuran-sahur_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Profil Yoav Gallant, Menhan Israel yang 2 Kali Dipecat Netanyahu",
        "link": "https://www.cnnindonesia.com/internasional/20241106093613-120-1163450/profil-yoav-gallant-menhan-israel-yang-2-kali-dipecat-netanyahu",
        "contentSnippet": "PM Israel Netanyahu pecat menhan Yoav Gallant gara-gara hilang kepercayaan dan cekcok selama agresi di Gaza.",
        "isoDate": "2024-11-06T03:10:13.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/11/06/israel-palestiniansgallant-1_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/11/06/israel-palestiniansgallant-1_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] UABS Mulai Rakit Baterai di RI, Suplai Mobil Listrik MG",
        "link": "https://www.cnnindonesia.com/otomotif/20241106100511-603-1163470/uabs-mulai-rakit-baterai-di-ri-suplai-mobil-listrik-mg",
        "contentSnippet": "PT Unified Automotive Battery System Indonesia (UABS Indonesia) mengumumkan mulai merakit baterai mobil listrik di Indonesia.",
        "isoDate": "2024-11-06T03:09:38.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/11/05/pabrik-baterai-morris-garage-1_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/11/05/pabrik-baterai-morris-garage-1_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Debat Kedua Bobby Vs Edy di Sumut Malam Ini, Bicara Daya Saing Daerah",
        "link": "https://www.cnnindonesia.com/nasional/20241106095341-617-1163466/debat-kedua-bobby-vs-edy-di-sumut-malam-ini-bicara-daya-saing-daerah",
        "contentSnippet": "Tema debat kedua Pilgub Sumut antara Bobby dan Edy Rahmayadi malam ini adalah Peningkatan Daya Saing Daerah dan Pembangunan Berkelanjutan.",
        "isoDate": "2024-11-06T03:07:15.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/11/06/malam-ini-debat-kedua-pilgub-sumut-bobby-nasution-lawan-edy-rahmayadi-1_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/11/06/malam-ini-debat-kedua-pilgub-sumut-bobby-nasution-lawan-edy-rahmayadi-1_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Mbappe Makin Suram usai Real Madrid Digebuk Milan",
        "link": "https://www.cnnindonesia.com/olahraga/20241106094425-142-1163463/mbappe-makin-suram-usai-real-madrid-digebuk-milan",
        "contentSnippet": "Masa depan Kylian Mbappe di Real Madrid makin suram usai raksasa Spanyol itu dipecundangi AC Milan dalam lanjutan Liga Champions di Stadion Santiago Bernabeu.",
        "isoDate": "2024-11-06T03:03:47.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/11/06/real-madrid-vs-ac-milan-10_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/11/06/real-madrid-vs-ac-milan-10_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Pemerintah Ungkap Kapan iPhone 16 Bisa Dijual di RI, Ini Bocorannya",
        "link": "https://www.cnnindonesia.com/teknologi/20241106094148-206-1163452/pemerintah-ungkap-kapan-iphone-16-bisa-dijual-di-ri-ini-bocorannya",
        "contentSnippet": "Menteri Koordinator Perekonomian Airlangga Hartarto mengungkap kapan iPhone 16 bisa dijual di Indonesia. Ini bocorannya.",
        "isoDate": "2024-11-06T03:01:48.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/10/30/rapat-kebijakan-subsidi-pemerintah-3_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/10/30/rapat-kebijakan-subsidi-pemerintah-3_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Apa Benar Makanan Pedas Bisa Meningkatkan Kekebalan Tubuh?",
        "link": "https://www.cnnindonesia.com/gaya-hidup/20241106081312-255-1163427/apa-benar-makanan-pedas-bisa-meningkatkan-kekebalan-tubuh",
        "contentSnippet": "Makanan pedas konon memiliki banyak manfaat kesehatan.",
        "isoDate": "2024-11-06T03:00:12.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/03/14/ilustrasi-sambal_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/03/14/ilustrasi-sambal_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Pramono-RK Bersaing Ketat di Jakarta, Peta Politik Masih Bisa Berubah?",
        "link": "https://www.cnnindonesia.com/nasional/20241106092344-617-1163449/pramono-rk-bersaing-ketat-di-jakarta-peta-politik-masih-bisa-berubah",
        "contentSnippet": "Elektabilitas Pramono dan Ridwan Kamil bersaing ketat jelang pencoblosan Pilgub Jakarta 2024. Apa mungkin berlangsung dua putaran?",
        "isoDate": "2024-11-06T02:53:09.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/09/29/bingkai-sepekan-edisi-30-september-2024-3_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/09/29/bingkai-sepekan-edisi-30-september-2024-3_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Berapa Biaya Kampanye Pilpres AS?",
        "link": "https://www.cnnindonesia.com/ekonomi/20241106073821-532-1163418/berapa-biaya-kampanye-pilpres-as",
        "contentSnippet": "Menjadi presiden Amerika Serikat membutuhkan banyak uang salah satunya untuk dana kampanye.",
        "isoDate": "2024-11-06T02:51:06.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/11/05/pilpres-as-2024-1_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/11/05/pilpres-as-2024-1_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] VIDEO: Ancaman Bom di TPS Georgia, Rusia Dituduh Jadi Dalang",
        "link": "https://www.cnnindonesia.com/internasional/20241106075137-139-1163422/video-ancaman-bom-di-tps-georgia-rusia-dituduh-jadi-dalang",
        "contentSnippet": "Dua TPS di Fulton County, Georgia sempat ditutup usai ancaman bom palsu pada Selasa (5/11).",
        "isoDate": "2024-11-06T02:50:20.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/11/06/thumbnail-video-1_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/11/06/thumbnail-video-1_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Marselino Masuk Skuad, Pelatih Oxford United Akui Lakukan Perubahan",
        "link": "https://www.cnnindonesia.com/olahraga/20241106094231-142-1163453/marselino-masuk-skuad-pelatih-oxford-united-akui-lakukan-perubahan",
        "contentSnippet": "Pelatih Oxford United Des Buckingham mengaku melakukan perubahan saat timnya mengalahkan Hull City 1-0 pada lanjutan Championship.",
        "isoDate": "2024-11-06T02:45:16.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/08/20/pelatih-oxford-united-des-buckingham_169.png?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/08/20/pelatih-oxford-united-des-buckingham_169.png?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Update Banjir Sukabumi: 69 Titik Kena Dampak",
        "link": "https://www.cnnindonesia.com/nasional/20241106092257-20-1163448/update-banjir-sukabumi-69-titik-kena-dampak",
        "contentSnippet": "BPBD Jawa Barat melaporkan ada 69 titik ruas jalan dan pemukiman yang terdampak akibat bencana banjir dan longsor di Kota Sukabumi.",
        "isoDate": "2024-11-06T02:35:09.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2020/09/22/banjir-bandang-sukabumi-5_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2020/09/22/banjir-bandang-sukabumi-5_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Daniel Craig Mau Knives Out 3 Lebih Lama di Bioskop Sebelum Netflix",
        "link": "https://www.cnnindonesia.com/hiburan/20241105142927-220-1163200/daniel-craig-mau-knives-out-3-lebih-lama-di-bioskop-sebelum-netflix",
        "contentSnippet": "Daniel Craig ingin film Knives Out 3, Wake Up Dead Man: A Knives Out Mystery, tayang lebih lama di bioskop sebelum rilis di Netflix.",
        "isoDate": "2024-11-06T02:34:52.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2021/10/07/daniel-craig-catatkan-namanya-di-hollywood-walk-of-fame-1_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2021/10/07/daniel-craig-catatkan-namanya-di-hollywood-walk-of-fame-1_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Rupiah Tenggelam ke Rp15.845 Tertekan Keunggulan Trump di Pilpres AS",
        "link": "https://www.cnnindonesia.com/ekonomi/20241106090829-78-1163445/rupiah-tenggelam-ke-rp15845-tertekan-keunggulan-trump-di-pilpres-as",
        "contentSnippet": "Nilai tukar rupiah berada di level Rp15.845 per dolar AS pada Rabu (6/11) pagi. Mata uang Garuda melemah 97 poin atau 0,62 persen dari perdagangan sebelumnya.",
        "isoDate": "2024-11-06T02:34:37.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2022/09/28/nilai-tukar-rupiah-terendah-sepanjang-2022-9_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2022/09/28/nilai-tukar-rupiah-terendah-sepanjang-2022-9_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Pakar Respons Fenomena Kriminalisasi Guru yang Mendisiplinkan Murid",
        "link": "https://www.cnnindonesia.com/nasional/20241105160339-12-1163254/pakar-respons-fenomena-kriminalisasi-guru-yang-mendisiplinkan-murid",
        "contentSnippet": "Aparat harus meninggalkan instrumen pidana sebagai sarana pembalasan terhadap guru yang mendisplinkan murid di sekolahnya.",
        "isoDate": "2024-11-06T02:25:06.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/04/25/ilustrasi-guru_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/04/25/ilustrasi-guru_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Kapan Hasil Pilpres Amerika Serikat Diumumkan?",
        "link": "https://www.cnnindonesia.com/internasional/20241106085251-134-1163435/kapan-hasil-pilpres-amerika-serikat-diumumkan",
        "contentSnippet": "Pemungutan suara Pilpres AS masih berlangsung seiring pula perhitungan suara di sejumlah negara bagian.",
        "isoDate": "2024-11-06T02:20:00.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/11/05/tps-pilpres-di-as_169.png?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/11/05/tps-pilpres-di-as_169.png?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Kata-kata Ruben Amorim Usai Sporting Gebuk Man City 4-1",
        "link": "https://www.cnnindonesia.com/olahraga/20241106090123-142-1163436/kata-kata-ruben-amorim-usai-sporting-gebuk-man-city-4-1",
        "contentSnippet": "Pelatih Sporting Lisbon Ruben Amorim mengungkapkan perasaannya usai mengalahkan Manchester City 4-1 pada lanjutan Liga Champions, Rabu (6/11) dini hari WIB.",
        "isoDate": "2024-11-06T02:15:18.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/11/06/sporting-cp-vs-manchester-city-1_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/11/06/sporting-cp-vs-manchester-city-1_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] BPJS Kesehatan jadi Syarat Bikin SIM Mulai Berlaku November 2024",
        "link": "https://www.cnnindonesia.com/otomotif/20241106090210-579-1163437/bpjs-kesehatan-jadi-syarat-bikin-sim-mulai-berlaku-november-2024",
        "contentSnippet": "Salah satu persyaratan untuk penerbitan SIM Ranmor Perseorangan dan SIM Ranmor Umum meliputi pelampiran tanda bukti kepesertaan aktif dalam program JKN.",
        "isoDate": "2024-11-06T02:05:35.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/08/20/sim-format-baru-1_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/08/20/sim-format-baru-1_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Menkomdigi Gandeng Google hingga TikTok untuk Berantas Judol",
        "link": "https://www.cnnindonesia.com/teknologi/20241105175019-192-1163312/menkomdigi-gandeng-google-hingga-tiktok-untuk-berantas-judol",
        "contentSnippet": "Menkomdigi Meutya Hafid mengaku bakal menggandeng sejumlah pihak, termasuk perusahaan-perusahaan media sosial, untuk ikut memberantas praktik judi online.",
        "isoDate": "2024-11-06T02:01:03.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/10/21/jajaran-kabinet-merah-putih-20_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/10/21/jajaran-kabinet-merah-putih-20_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] 30 Contoh Soal PPPK Arsiparis 2024 dan Kunci Jawabannya",
        "link": "https://www.cnnindonesia.com/edukasi/20241028115836-561-1160341/30-contoh-soal-pppk-arsiparis-2024-dan-kunci-jawabannya",
        "contentSnippet": "Berikut kumpulan contoh soal PPPK Arsiparis dan jawabannya yang bisa dipelajari pelamar agar lebih siap dalam menghadapi tes.",
        "isoDate": "2024-11-06T02:00:30.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2015/03/05/5af8eeb1-7010-44bb-8d71-5e8f10bc03ba_169.jpg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2015/03/05/5af8eeb1-7010-44bb-8d71-5e8f10bc03ba_169.jpg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Masuk Musim Hujan Tembok Rembes, Lakukan 4 Cara Ini",
        "link": "https://www.cnnindonesia.com/gaya-hidup/20241106071414-277-1163415/masuk-musim-hujan-tembok-rembes-lakukan-4-cara-ini",
        "contentSnippet": "Musim hujan telah tiba, masalah klasik seperti bocor atap hingga dinding juga akan kembali hadir.",
        "isoDate": "2024-11-06T02:00:29.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2022/11/15/ilustrasi-dinding-rumah-retak_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2022/11/15/ilustrasi-dinding-rumah-retak_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Banyak Pompa Pengendali Banjir Jakarta Rusak Terlilit Ban-Celana Jeans",
        "link": "https://www.cnnindonesia.com/nasional/20241106080552-20-1163424/banyak-pompa-pengendali-banjir-jakarta-rusak-terlilit-ban-celana-jeans",
        "contentSnippet": "Kasudin Jakbar melaporkan 10 persen pompa permanen pengendalian banjir di Jakarta Barat rusak akibat sampah pakaian dan lainnya.",
        "isoDate": "2024-11-06T02:00:28.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/07/03/banjir-dan-genangan-air-melanda-sejumlah-titik-di-kawasan-bangka-dan-kemang-raya-8_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/07/03/banjir-dan-genangan-air-melanda-sejumlah-titik-di-kawasan-bangka-dan-kemang-raya-8_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Penghitungan Suara Pilpres AS Dimulai, Trump Ungguli Kamala Harris",
        "link": "https://www.cnnindonesia.com/internasional/20241106084405-134-1163434/penghitungan-suara-pilpres-as-dimulai-trump-ungguli-kamala-harris",
        "contentSnippet": "Penghitungan suara pilpres AS dimulai, Trump ungguli Kamala Harris dengan perolehan 18 juta suara.",
        "isoDate": "2024-11-06T01:55:30.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/07/25/kamala-harris-vs-donald-trump_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/07/25/kamala-harris-vs-donald-trump_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Amorim Kirim Sinyal Bahaya usai Sporting Hancurkan Man City",
        "link": "https://www.cnnindonesia.com/olahraga/20241106082812-142-1163431/amorim-kirim-sinyal-bahaya-usai-sporting-hancurkan-man-city",
        "contentSnippet": "Ruben Amorim kirim sinyal bahaya usai berhasil mengantar Sporting Lisbon menang 4-1 atas Manchester City pada lanjutan Liga Champions.",
        "isoDate": "2024-11-06T01:50:17.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/11/06/sporting-cp-vs-manchester-city_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/11/06/sporting-cp-vs-manchester-city_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Harga Minyak Naik 1 Persen Imbas Terhempas Ancaman Badai Rafael",
        "link": "https://www.cnnindonesia.com/ekonomi/20241106081414-85-1163428/harga-minyak-naik-1-persen-imbas-terhempas-ancaman-badai-rafael",
        "contentSnippet": "Harga minyak naik 1 pada Selasa (5/11) terdorong oleh Badai Tropis Rafael di AS yang meningkatkan kekhawatiran pasar atas menurunnya pasokan.",
        "isoDate": "2024-11-06T01:50:15.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2019/11/12/60af346e-9af3-4645-8454-ca775bda60b2_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2019/11/12/60af346e-9af3-4645-8454-ca775bda60b2_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Litbang Kompas: Sentimen Identitas Bikin Bobby Unggul dari Edy",
        "link": "https://www.cnnindonesia.com/nasional/20241106082928-617-1163432/litbang-kompas-sentimen-identitas-bikin-bobby-unggul-dari-edy",
        "contentSnippet": "Litbang Kompas mencatat sentimen identitas jadi faktor yang membuat Bobby unggul dari Edy Rahmayadi di Pilgub Sumut 2024.",
        "isoDate": "2024-11-06T01:47:36.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/09/19/bobby-nasution-bertemu-edy-rahmayadi-di-acara-syukuran-anggota-dprd-sumut_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/09/19/bobby-nasution-bertemu-edy-rahmayadi-di-acara-syukuran-anggota-dprd-sumut_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Netanyahu Tunjuk Eks Rival Gideon Saar Jadi Menlu Baru Israel",
        "link": "https://www.cnnindonesia.com/internasional/20241106081840-120-1163429/netanyahu-tunjuk-eks-rival-gideon-saar-jadi-menlu-baru-israel",
        "contentSnippet": "Gideon Saar ditunjuk jadi menlu baru gantikan Israel Katz, usai Netanyahu pecat menteri pertahanan Yoav Gallant.",
        "isoDate": "2024-11-06T01:35:05.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/11/06/mideast-israel-vote-netanyahu_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/11/06/mideast-israel-vote-netanyahu_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Siapa Penulis Laporan Internal Kontroversial HYBE?",
        "link": "https://www.cnnindonesia.com/hiburan/20241104141851-227-1162824/siapa-penulis-laporan-internal-kontroversial-hybe",
        "contentSnippet": "Berikut penjelasan soal penulis laporan internal kontroversional HYBE yang berisi hinaan kepada banyak idol K-pop.",
        "isoDate": "2024-11-06T01:30:02.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2024/10/26/ilustrasi-gedung-hybe-1_169.jpeg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2024/10/26/ilustrasi-gedung-hybe-1_169.jpeg?w=360&q=100"
        },
      }),
      News({
        "title": "[DUMMY] Transmigrasi Papua Dirancang untuk Perpindahan Warga di Dalam Provinsi",
        "link": "https://www.cnnindonesia.com/nasional/20241106075906-32-1163426/transmigrasi-papua-dirancang-untuk-perpindahan-warga-di-dalam-provinsi",
        "contentSnippet": "Menteri Transmigrasi Iftitah Sulaiman menyatakan peraturan saat ini tidak memungkinkan untuk mewujudkan program transmigrasi dari luar Pulau Papua ke Papua.",
        "isoDate": "2024-11-06T01:29:44.000Z",
        "image": {
          "small": "https://akcdn.detik.net.id/visual/2015/08/18/3cee8591-eff6-449a-8faa-d4918057b21a_169.jpg?w=360&q=90",
          "large": "https://akcdn.detik.net.id/visual/2015/08/18/3cee8591-eff6-449a-8faa-d4918057b21a_169.jpg?w=360&q=100"
        },
      }),
    ],
  },
};
