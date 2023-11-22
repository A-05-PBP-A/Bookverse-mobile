### Nama Anggota :
- 2206024745 - Lucinda Laurent
- 2206819395 - Fadrian Yhoga Pratama
- 2206028365 - Alyanda Astri
- 2206083514 - Irvan Rizqy Kusuma
- 2206081502 - Ryandhika Al Afzal

# BookVerse - Dunia Literasi Terhubung 🌌👨🏻‍🚀🤖
> Akses Website di: [bookverse-a05-tk.pbp.cs.ui.ac.id](https://bookverse-a05-tk.pbp.cs.ui.ac.id/)
## **Deskripsi :** 
Perkembangan teknologi digital telah mengubah dunia dengan cara yang belum pernah kita bayangkan sebelumnya. Dengan kecepatan yang luar biasa, teknologi baru muncul dan mengubah cara kita berinteraksi, bekerja, dan hidup. Dari smartphone dan tablet hingga cloud computing dan kecerdasan buatan, teknologi digital telah menjadi bagian tak terpisahkan dari kehidupan sehari-hari kita. Namun seiring dengan perkembangan yang cepat, datang pula “bising” - informasi berlebihan, gangguan konstan, dan tantangan untuk menjaga privasi dan keamanan data kita. Media sosial sebagai contoh, meski memberikan cara baru untuk berkomunikasi dan berbagi informasi, juga dapat menjadi sumber stres dan kecemasan. Di tengah derasnya arus informasi, semangat literasi menjadi senjata kita agar terhindar dari misinformasi dan disinformasi.

Dalam kebisingan dunia digital, BookVerse hadir sebagai oase literasi yang mempesona. Ini dimulai dengan mimpi sederhana untuk menciptakan ruang di mana kata-kata tidak hanya diucapkan, tetapi dihidupkan kembali dengan semangat. Dalam BookVerse, setiap buku adalah jendela ke petualangan tak terbatas. Dengan koleksi buku yang luas, klub baca yang penuh semangat, dan koneksi global yang unik, BookVerse mendorong literasi dan merayakan keindahan dalam keberagaman bahasa dan cerita. Inilah kisah di mana buku menjadi benang merah yang menghubungkan orang dari berbagai latar belakang, dan di mana literasi membawa kita ke pemahaman yang lebih dalam tentang diri kita dan dunia di sekitar kita.

## **Manfaat BookVerse :**
BookVerse memberikan manfaat yang tak terbatas bagi pengguna. Pertama, BookVerse menginspirasi minat membaca dan mempromosikan kesadaran akan pentingnya literasi dalam masyarakat. Pengguna dapat menggali ide-ide dalam buku bersama-sama, berbagi pandangan mereka, dan memperluas wawasan mereka dengan berinteraksi dengan pembaca dari berbagai budaya. Selain itu, BookVerse memungkinkan pengguna untuk berpartisipasi dalam misi literasi global, memberikan kontribusi positif terhadap upaya meningkatkan literasi di komunitas mereka. BookVerse menjadi jendela yang menghubungkan, menginspirasi, dan memungkinkan pembaca untuk mengeksplorasi dunia lebih jauh melalui kekuatan kata-kata.

## **Modul dan Pengembang :**
1. **Admin** - [Irvan Rizqy Kusuma](https://github.com/IrvanRizqy)
Modul ini bertanggung jawab untuk semua tugas admin,, seperti menambah katalog buku, menghapus review, dll.

2. **Pinjam dan Kembalikan Buku** - [Lucinda Laurent](https://github.com/lucindalaurent)
Modul ini memungkinkan pengguna untuk melakukan peminjaman dan pengembalian buku dalam perpustakaan.

3. **Profil Pengguna** - [Ryandhika Al Afzal](https://github.com/RyanAfzal)
Modul ini berfokus pada pengelolaan profil pengguna, seperti history membaca, buku favorit, history review, dll.

4. **Profil Buku dan Review pengguna** - [Fadrian Yhoga Pratama](https://github.com/yhogaa)
Modul ini mengelola informasi buku dan ulasan yang diberikan oleh pengguna terhadap buku-buku tertentu.

5. **Daftar Buku** - [Alyanda Astri](https://github.com/astrialyanda)
Modul ini untuk menampilkan daftar buku yang tersedia dalam perpustakaan, para pengguna yang belum login juga bisa melihat daftar buku yang tersedia.

## **_Role User_ :**
### **Admin**
Admin memiliki akses penuh dan kontrol atas seluruh aplikasi "BookVerse". Ini mencakup hak-hak berikut:
- **Manajemen Buku**: Admin dapat menambahkan, mengedit, atau menghapus buku dari katalog. Ini mencakup mengunggah informasi buku baru, mengupdate detail buku yang ada, dan menghapus buku yang sudah tidak relevan.
- **Manajemen Anggota**: Admin dapat mengelola daftar anggota, termasuk menambahkan anggota baru, menghapus anggota, dan mengedit profil anggota.
- **Manajemen Review**: Admin dapat menghapus review dari pengguna.
  
### **User**
Pengguna dapat menikmati semua fitur yang disediakan oleh "BookVerse", termasuk:
- **Penelusuran Buku**: User dapat mencari buku berdasarkan judul, penulis, atau genre. User dapat melihat detail buku, mengakses sinopsis, dan mengetahui ketersediaan buku.
- **Peminjaman Buku**: User dapat meminjam buku dari katalog dengan mengajukan permohonan peminjaman. User dapat melacak buku-buku yang sedang User pinjam dan mengembalikan buku saat selesai membaca.
- **Tampilan Profile**: User dapat meliihat history buku yang sudah dipinjam, history review pada suatu buku, dan buku yang di favorite pada bagia profile
- **Review Buku**: User dapat menuliskan review untuk suatu buku yang sudah dia baca.

### **Sumber dataset katalog buku**
Berdasarkan hasil diskusi, Sumber dataset katalog buku yang kami pilih untuk mobile app kami adalah dari **Kaggle** karena menggunakan format csv sehingga memudahkan dalam pengolahan dan pertukaran data. Tampilan website dari kaggle juga menarik dan rapi serta pilihan bukunya yang sangat beragam.

## **Integrasi dengan Situs Web**
1. Mendefinisikan model yang akan digunakan saat pemanggilan web service, beserta method `toJson()` dan `fromJson()`.
2. Menambahkan dependensi `http` pada proyek aplikasi, serta menambahkan potongan kode untuk memperbolehkan akses internet pada aplikasi Flutter di file `android/app/src/main/AndroidManifest.xml`.
3. Melakukan fetch data dengan hit endpoint API menggunakan method `POST`, `GET`, `DELETE`, `PUT`, dan lain-lain yang disediakan dependensi `http`.
4. Data yang sudah di-fetch kemudian di-decode menjadi bentuk JSON.
5. Data dalam bentuk JSON dikonversi menjadi data dalam bentuk sebuah model.
6. Data dalam bentuk model tersebut ditampilkan pada aplikasi Flutter.
