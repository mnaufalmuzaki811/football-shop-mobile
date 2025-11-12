# Tugas Individu 7 

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