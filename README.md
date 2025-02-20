# Bilsoft Stok Risk Limit Modülü (SRLM)

## 📱 Uygulama Hakkında

Bilsoft Stok Risk Limit Modülü (SRLM), işletmenizin stok yönetimini akıllı bir şekilde takip etmenizi sağlayan modern bir Flutter uygulamasıdır. Bu uygulama ile stoklarınızı anlık olarak izleyebilir, risk limitlerini belirleyebilir ve stok hareketlerinizi detaylı bir şekilde analiz edebilirsiniz.

## 📸 Ekran Görüntüleri

### 🎥 Uygulama Önizlemesi

<img src="assets/screenshots/stok_takip.gif" alt="Stok Takip Animasyonu" width="450"/>

_Stok takip sisteminin canlı kullanımı_

### Ana Ekran

<img src="assets/screenshots/Screenshot_1740073024.png" alt="Ana Ekran - Stok Takibi" width="300"/>

_Stok takibi ana ekranı - Hızlı bakış, arama ve filtreleme özellikleri_

<img src="assets/screenshots/Screenshot_1740073045.png" alt="Ana Ekran - Stok İzleme" width="300"/>

_Stok izleme durumu ve risk takibi_

### Detay Ekranı

<img src="assets/screenshots/Screenshot_1740073822.png" alt="Detay Ekranı" width="300"/>

_Ürün detayları ve risk limiti yönetimi_

## 🚀 Temel Özellikler

### 📊 Akıllı Stok Takibi

- Giriş, çıkış ve kalan stok miktarlarını anlık görüntüleme
- Stok risk limitlerini özelleştirme
- Riskli ve güvenli stok durumlarını renk kodlarıyla izleme

### 🔍 Gelişmiş Arama ve Filtreleme

- Ürün adı veya grup bazında arama
- Özelleştirilebilir filtreler:
  - Tüm Stoklar
  - Stokta Olanlar
  - Stoğu Riskte Olanlar

### 📈 Detaylı Stok Analizi

- Her ürün için detaylı stok kartı
- Ürün bazında:
  - Barkod bilgisi
  - Grup ve birim bilgileri
  - Stok rafı takibi
  - Fiyatlandırma detayları
  - KDV bilgileri

### ⚡ Gerçek Zamanlı İzleme

- Stok takip sistemini başlatma/durdurma
- Risk durumunda anlık bildirimler
- Otomatik stok durumu güncellemeleri

## 💻 Kullanım Kılavuzu

### Ana Ekran Özellikleri

1. **Üst Panel**

   - Toplam stok sayısı
   - Güvenli stok sayısı
   - Riskli stok sayısı

2. **Arama ve Filtreleme**

   - Ürün adı veya grup ile arama
   - Stok durumuna göre filtreleme
   - Hızlı erişim filtreleri

3. **Stok İzleme**
   - Başlat/Durdur kontrolleri
   - Anlık stok durumu takibi

### Detay Ekranı Özellikleri

1. **Stok Bilgileri**

   - Giriş/Çıkış miktarları
   - Güncel bakiye
   - Risk limiti

2. **Ürün Detayları**

   - Barkod
   - Grup
   - Birim
   - Raf bilgisi

3. **Fiyatlandırma**
   - Alış fiyatı
   - Satış fiyatı
   - KDV oranı
   - KDV dahil/hariç durumu

## 🏗️ Teknik Mimari

### Clean Architecture

Uygulama, Clean Architecture prensiplerine uygun olarak geliştirilmiştir. Bu yaklaşım, kodun daha sürdürülebilir, test edilebilir ve ölçeklenebilir olmasını sağlar.

#### Katmanlar

1. **📱 Presentation Layer (UI)**

   - `features/`: Ekranlar ve widget'lar
   - `cubit/`: Durum yönetimi
   - Material 3 tasarım sistemi

2. **💼 Domain Layer**

   - `entities/`: İş mantığı modelleri
   - `repositories/`: Soyut repository tanımları

3. **💾 Data Layer**
   - `repositories/`: Repository implementasyonları
   - `datasources/`: Veri kaynakları

### 🛠️ Kullanılan Teknolojiler

- **State Management**

  - `bloc`: ^9.0.0
  - `flutter_bloc`: ^9.0.0
  - `equatable`: ^2.0.7

- **Veri Güvenliği ve Depolama**

  - `flutter_secure_storage`: ^9.2.4
  - `shared_preferences`: ^2.5.2

- **Network ve API**

  - `dio`: ^5.8.0+1
  - `jwt_decoder`: ^2.0.1

- **Dependency Injection**

  - `get_it`: ^8.0.3

- **Background İşlemler**
  - `workmanager`: ^0.5.2
  - `flutter_local_notifications`: ^18.0.1

### 📦 Proje Yapısı

```
lib/
├── core/
│   ├── constants/
│   ├── di/
│   └── utils/
├── data/
│   ├── datasources/
│   └── repositories/
├── domain/
│   ├── entities/
│   └── repositories/
└── features/
    ├── home/
    │   ├── cubit/
    │   ├── view/
    │   └── widgets/
    ├── detail/
    └── splash/
```

### 🔄 Veri Akışı

1. UI'dan gelen kullanıcı etkileşimi
2. Cubit tarafından yakalanan event
3. Repository üzerinden veri işlemleri
4. UI'ın güncellenmesi

### 🔐 Güvenlik Özellikleri

- JWT tabanlı kimlik doğrulama
- Güvenli veri depolama
- Şifrelenmiş yerel depolama

### 📱 Uygulama Özellikleri

- Arka plan görev yönetimi
- Yerel bildirimler
- Çevrimdışı veri depolama
- Gerçek zamanlı veri senkronizasyonu

## 🔄 Sürüm Geçmişi

### Versiyon 1.0.0

- İlk sürüm
- Temel stok yönetimi özellikleri
- Risk limit modülü
- Gerçek zamanlı izleme sistemi

## 📝 Lisans

© 2024 Bilsoft. Tüm hakları saklıdır.

---
