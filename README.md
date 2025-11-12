# Tugas Individu 7: Elemen Dasar Flutter

## 1. Apa itu Widget Tree di Flutter?

**Widget Tree** (Pohon Widget) adalah representasi struktural dari seluruh antarmuka pengguna (UI) aplikasi Anda. Dalam Flutter, "semuanya adalah widget". UI Anda dibangun dengan menyusun widget-widget ini secara hierarkis, mirip dengan pohon keluarga.

* Ada satu **root widget** (widget akar), yang biasanya adalah `MaterialApp` atau `CupertinoApp`.
* Widget ini memiliki "anak" (children). Misalnya, `MaterialApp` memiliki properti `home` yang diisi dengan widget lain, seperti `Scaffold`.
* `Scaffold` kemudian memiliki anak-anaknya sendiri, seperti `appBar` dan `body`.
* Proses ini berlanjut ke bawah, di mana `body` mungkin berisi `Column`, yang kemudian berisi daftar widget `Text` dan `Icon`.

**Hubungan Parent-Child (Induk-Anak):**

Hubungan ini adalah inti dari layout dan state management di Flutter:

1.  **Layout (Tata Letak):** Induk (parent) memberitahukan batasan (constraints) kepada anaknya (child). Misalnya, "Kamu boleh memiliki lebar maksimal 300 piksel".
2.  **Ukuran:** Anak kemudian memutuskan ukurannya sendiri *di dalam batasan tersebut* dan memberitahukan ukurannya kembali ke induk.
3.  **Posisi:** Induk kemudian memutuskan di mana harus memposisikan anak-anaknya (misalnya, di tengah, di atas, atau dalam urutan vertikal).
4.  **Data/State:** Induk juga dapat meneruskan data (seperti state) ke anak-anaknya. Ketika data di induk berubah, anak-anak yang bergantung pada data tersebut akan otomatis dibangun ulang (rebuilt).

## 2. Widget yang Digunakan dalam Proyek Ini

*(Catatan: Silakan sesuaikan daftar ini berdasarkan widget yang **Anda** gunakan dalam kode Anda.)*

* **`MaterialApp`** Root aplikasi yang mengatur tema, rute, dan konfigurasi Material Design.
* **`Scaffold`** Struktur dasar halaman dengan AppBar, body, dan area lainnya.
* **`AppBar`** Menampilkan judul di bagian atas layar.
* **`Padding`** Memberikan jarak di sekitar widget anak.
* **`Column`** Menyusun widget anak secara vertikal.
* **`Row`** Menyusun widget anak secara horizontal.
* **`Center`** Memposisikan widget anak di tengah layar.
* **`Text`** Menampilkan teks.
* **`GridView.count`** Menampilkan daftar item dalam bentuk grid (3 kolom).
* **`Card`** Menampilkan kotak dengan bayangan untuk tampilan informasi.
* **`Container`** Pembungkus fleksibel untuk mengatur ukuran, warna, dan padding.
* **`Icon`** Menampilkan ikon bawaan dari Material Design.
* **`InkWell`** Memberi efek sentuhan dan event onTap.
* **`SnackBar`** Menampilkan notifikasi singkat di bagian bawah layar.

## 3. Apa fungsi dari widget MaterialApp?

**`MaterialApp`** adalah widget kenyamanan (convenience widget) tingkat tinggi yang membungkus sejumlah widget dan fungsionalitas yang umumnya diperlukan untuk aplikasi yang menggunakan Material Design (standar desain visual dari Google).

Fungsi utamanya adalah:

1.  **Mengatur Tema (Theming):** Menyediakan `ThemeData` global untuk seluruh aplikasi. Ini memungkinkan Anda menentukan skema warna, gaya font, dan properti visual lainnya secara konsisten yang akan diwarisi oleh semua widget di bawahnya.
2.  **Manajemen Navigasi (Routing):** Mengatur `Navigator` untuk mengelola tumpukan layar (screen) atau halaman (page). Ini memungkinkan Anda berpindah antar halaman menggunakan `Navigator.push()` dan `Navigator.pop()`.
3.  **Menentukan Halaman Utama (Home):** Melalui properti `home`, Anda menentukan widget apa yang akan ditampilkan pertama kali saat aplikasi dibuka.
4.  **Lokalisasi (Localization):** Mendukung konfigurasi untuk terjemahan dan format spesifik bahasa/regional.

## 4. Perbedaan StatelessWidget dan StatefulWidget

Perbedaan utamanya terletak pada **kemampuan untuk mengelola state (keadaan) internal**.

### StatelessWidget

* **Apa itu:** Widget yang **statis** dan **immutable** (tidak dapat berubah).
* **State:** Tidak memiliki state internal. Setelah widget ini dibuat, tampilannya murni bergantung pada informasi (properti) yang diterimanya dari induknya dan konfigurasinya sendiri.
* **Kapan digunakan:** Gunakan `StatelessWidget` ketika UI yang Anda buat **tidak akan pernah berubah** secara dinamis berdasarkan interaksi pengguna atau data internal.
* **Contoh:** `Icon`, `Text` (menampilkan teks statis), `Container` dekoratif, label, atau halaman "About" yang statis.

### StatefulWidget

* **Apa itu:** Widget yang **dinamis** dan **mutable** (dapat berubah).
* **State:** Memiliki **objek `State`** internal yang terkait dengannya. Objek `State` ini dapat menyimpan data yang bisa berubah selama widget masih ada di layar.
* **Cara kerja:** Ketika data di dalam objek `State` berubah (misalnya karena pengguna menekan tombol), Anda memanggil fungsi `setState()`. Panggilan ini memberitahu Flutter bahwa state telah berubah, dan Flutter akan menjadwalkan widget tersebut untuk **dibangun ulang (rebuild)** dengan nilai state yang baru.
* **Kapan digunakan:** Gunakan `StatefulWidget` ketika UI perlu **diperbarui secara dinamis** selama runtime.
* **Contoh:** *Checkbox* (state: dicentang/tidak), *Slider* (state: nilai saat ini), *TextField* (state: teks yang diketik pengguna), atau halaman yang menampilkan data dari API (state: loading, success, error).

## 5. Apa itu BuildContext?

**`BuildContext`** adalah "konteks" atau "pegangan" (handle) yang menunjukkan **lokasi unik** sebuah widget di dalam Widget Tree.

Setiap widget memiliki `BuildContext`-nya sendiri, yang diteruskan sebagai parameter ke dalam metode `build`-nya: `Widget build(BuildContext context)`.

**Mengapa Penting?**
`BuildContext` sangat penting karena ia adalah cara bagi sebuah widget untuk **berinteraksi dengan lingkungannya**, terutama dengan widget-widget leluhurnya (ancestors) di dalam tree.

**Penggunaan di Metode `build`:**
Fungsi utamanya adalah untuk "mencari" (lookup) widget atau layanan lain yang berada *di atas* widget saat ini di dalam tree. Ini paling sering dilakukan dengan pola `[NamaLayanan].of(context)`:

* **`Theme.of(context)`**: Mencari widget `Theme` terdekat di atasnya untuk mendapatkan data tema (misalnya, warna primer).
* **`Navigator.of(context)`**: Mencari `Navigator` terdekat untuk melakukan navigasi (pindah halaman).
* **`MediaQuery.of(context)`**: Mencari data media (seperti ukuran layar, orientasi) dari `MediaQuery` terdekat.
* **`ScaffoldMessenger.of(context)`**: Mencari `ScaffoldMessenger` untuk menampilkan `SnackBar`.

Tanpa `BuildContext`, sebuah widget akan terisolasi dan tidak tahu apa-apa tentang sisa aplikasi, seperti apa tema yang sedang berlaku atau bagaimana cara pindah ke halaman lain.

## 6. Perbedaan "Hot Reload" dan "Hot Restart"

Keduanya adalah fitur yang mempercepat proses pengembangan di Flutter, tetapi bekerja dengan cara yang berbeda:

### Hot Reload

* **Apa yang dilakukan:** Menyuntikkan (inject) file kode Dart yang baru diperbarui ke dalam **Dart Virtual Machine (VM) yang sedang berjalan**.
* **Kecepatan:** Sangat cepat (biasanya kurang dari satu detik).
* **Apa yang terjadi:** Flutter akan segera membangun ulang (rebuild) Widget Tree.
* **State (Keadaan):** **State aplikasi tetap terjaga.** Misalnya, jika Anda memiliki counter di angka 10 dan Anda mengubah warna tombol, setelah Hot Reload, counter akan *tetap* di angka 10.
* **Kapan digunakan:** Paling sering digunakan. Ideal untuk iterasi cepat pada perubahan UI, layout, warna, dan logika bisnis minor.

### Hot Restart

* **Apa yang dilakukan:** Menghancurkan Dart VM yang sedang berjalan dan **membuat VM yang baru**. Ini seperti memulai ulang aplikasi dari awal, tetapi jauh lebih cepat daripada "Full Restart" (menutup dan membuka kembali aplikasi).
* **Kecepatan:** Lebih lambat dari Hot Reload (beberapa detik).
* **Apa yang terjadi:** Seluruh kode aplikasi dimuat ulang dari awal.
* **State (Keadaan):** **State aplikasi hilang (reset).** Aplikasi akan kembali ke keadaan awalnya (initial state). Counter Anda akan kembali ke 0.
* **Kapan digunakan:** Digunakan ketika perubahan kode terlalu besar untuk Hot Reload (misalnya, mengubah *global static fields* atau *constructors*), atau jika Hot Reload gagal, atau jika Anda memang ingin menguji alur aplikasi dari keadaan awal.

---

# Tugas Individu 8: Flutter Navigation, Layouts, Forms, and Input Elements

## 1. Perbedaan Navigator.push() dan Navigator.pushReplacement()

Perbedaan utama terletak pada **bagaimana cara mereka mengelola tumpukan (stack) navigasi halaman**:

* **`Navigator.push()`**
    * **Apa yang dilakukan:** Mendorong (push) halaman baru **di atas** halaman saat ini. Halaman lama (asal) masih ada di tumpukan, tepat di bawah halaman baru.
    * **Konsekuensi:** Pengguna dapat menekan tombol "kembali" (baik di `AppBar` atau tombol fisik/gestur perangkat) untuk kembali (pop) ke halaman sebelumnya.
    * **Contoh di Football Shop:** Ini digunakan di `menu.dart` saat menekan kartu "Create Product" dan di `left_drawer.dart` saat menekan menu "Tambah Produk". Keduanya memanggil `Navigator.push(context, ... ProductFormPage())`. Ini adalah pilihan yang tepat karena pengguna mungkin ingin **membatalkan** pengisian form dan **kembali** ke halaman utama (`MyHomePage`).

* **`Navigator.pushReplacement()`**
    * **Apa yang dilakukan:** Mendorong halaman baru dan **membuang** halaman saat ini dari tumpukan. Halaman baru tersebut **menggantikan** (replace) halaman lama.
    * **Konsekuensi:** Pengguna **tidak bisa** menekan tombol "kembali" untuk kembali ke halaman sebelumnya, karena halaman tersebut sudah tidak ada di tumpukan.
    * **Kapan digunakan di Football Shop:** Meskipun tidak digunakan secara eksplisit di kode Anda, `pushReplacement` ideal untuk situasi seperti *setelah pengguna berhasil login*. Anda tidak ingin pengguna menekan "kembali" dari homepage dan kembali ke halaman login.

## 2. Pemanfaatan Hierarchy Widget (Scaffold, AppBar, Drawer)

Struktur hierarki ini adalah kunci untuk menciptakan UI yang konsisten:

1.  **`Scaffold`**: Bertindak sebagai "kerangka" atau "rangka" utama untuk setiap halaman. Ia menyediakan slot standar untuk elemen-elemen umum. Baik `MyHomePage` (di `menu.dart`) maupun `ProductFormPage` (di `productlist_form.dart`) sama-sama menggunakan `Scaffold` sebagai widget terluarnya.
2.  **`AppBar`**: Ditempatkan di slot `appBar` milik `Scaffold`. Ini memberikan area branding dan judul yang konsisten di bagian atas setiap halaman. Meskipun judulnya berbeda ("NOPALZZZ SPORTY" vs. "Create Product"), posisinya dan fungsinya tetap sama.
3.  **`Drawer`**: Ditempatkan di slot `drawer` milik `Scaffold`. Dengan menggunakan widget `LeftDrawer` yang sama di *kedua* halaman (`MyHomePage` dan `ProductFormPage`), kita memastikan bahwa pengguna selalu memiliki akses ke menu navigasi yang sama persis, di mana pun mereka berada di dalam aplikasi.

Dengan menggunakan `Scaffold` sebagai fondasi dan memasukkan `AppBar` serta `LeftDrawer` yang sama di setiap halaman, aplikasi ini secara otomatis terasa familier dan mudah dinavigasi bagi pengguna.

## 3. Kelebihan Layout Widget pada Form (Padding, SingleChildScrollView, ListView)

Menggunakan widget layout yang tepat sangat penting saat membuat form untuk memastikan pengalaman pengguna yang baik (UX) dan menghindari error teknis.

* **`Padding`**
    * **Kelebihan:** Memberi "ruang napas" visual di sekitar elemen form. Ini mencegah field input dan tombol menempel langsung ke tepi layar atau menempel satu sama lain, sehingga form terlihat lebih rapi dan mudah dibaca.
    * **Contoh Penggunaan:** Di `productlist_form.dart`, `SingleChildScrollView` memiliki `padding: const EdgeInsets.all(8.0)` untuk memberi jarak antara keseluruhan form dengan tepi layar. Di `menu.dart`, `Padding` juga digunakan di `body` `Scaffold`.

* **`SingleChildScrollView`**
    * **Kelebihan:** Ini adalah widget yang krusial untuk form. Kelebihan utamanya adalah **mencegah "Bottom Overflow Error"** (error piksel kuning-hitam). Saat pengguna mengetuk `TextFormField`, keyboard virtual akan muncul dan memakan ruang di layar. `SingleChildScrollView` memastikan bahwa *seluruh* form dapat di-scroll secara vertikal, sehingga pengguna tetap dapat melihat dan mengakses field yang mungkin tertutup oleh keyboard.
    * **Contoh Penggunaan:** Di `productlist_form.dart`, seluruh `Form` dan `Column`-nya dibungkus (wrap) oleh `SingleChildScrollView`.

* **`ListView`**
    * **Kelebihan:** Mirip dengan `SingleChildScrollView`, `ListView` menyediakan konten yang dapat di-scroll. Namun, `ListView` secara khusus dioptimalkan untuk menampilkan *daftar* item, terutama jika daftarnya bisa sangat panjang.
    * **Contoh Penggunaan:** Di `left_drawer.dart`, menu navigasi (`DrawerHeader`, `ListTile`, `ListTile`) ditempatkan di dalam `ListView`. Ini memastikan bahwa jika menu navigasi suatu hari nanti memiliki banyak item, menu tersebut dapat di-scroll dan tidak akan overflow.

## 4. Penyesuaian Warna Tema (Theme)

Identitas visual yang konsisten dicapai dengan mendefinisikan skema warna terpusat di widget root aplikasi, yaitu `MaterialApp`.

1.  **Definisi Terpusat:** Di file `main.dart`, widget `MyApp` mengembalikan `MaterialApp`. Di sinilah kita mengatur properti `theme`.
2.  **`ThemeData` dan `colorScheme`:** Kita memberikan `ThemeData` ke properti `theme`. Di dalamnya, kita mengatur `colorScheme` menggunakan `ColorScheme.fromSwatch(primarySwatch: Colors.blue)`. Ini memberitahu Flutter untuk secara otomatis menghasilkan seluruh palet warna (warna primer, warna sekunder, warna latar, warna teks, dll.) hanya berdasarkan satu warna dasar (`Colors.blue`).
3.  **Penggunaan di Widget Lain:** Keuntungannya adalah widget lain di seluruh aplikasi dapat "meminta" warna tema ini. Contohnya, `AppBar` di `MyHomePage` (`menu.dart`) mengatur warnanya menggunakan `backgroundColor: Theme.of(context).colorScheme.primary`.
4.  **Konsistensi:** Jika kita ingin mengubah brand toko dari biru menjadi hijau, kita hanya perlu mengubah `primarySwatch: Colors.blue` di `main.dart` menjadi `primarySwatch: Colors.green`. `AppBar` di `MyHomePage` akan otomatis ikut berubah menjadi hijau tanpa perlu diedit manual, karena ia mengambil warna dari tema.

---