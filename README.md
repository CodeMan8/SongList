# Song List

Bu projede servise istek atılırak şarkı listelerini albüm ve koleksiyon detaylarını görüntüleyecebileceğimiz  bir mobil uygulama geliştirilmiştir.

### Projedeki teknolojiler ve tasarım şablonu 
  Servise istek atmak için Alamofire kütüphanesi kullanıldı. MVVM tasarım deseni kullanılarak proje yazıldı. 
  
### Servisler 
https://itunes.apple.com/search?term=jack+johnson&amp;limit=N&amp;offset=X
https://itunes.apple.com/search?term=jack+johnson

### Gereksinimeler
Projeyi çalıştırmadan önce kütüphaneler aktif edilmeli 
- pod install 
Proje dosyalarına diğer branchte ulaşabilirsiniz.

### İçerik

 
```

Detay butonu ve üst kısımdaki profil sayfası için custom view oluşturuldu ve uygulandı.

```

```
Servisten gelen response'lar modellendi. İlk sayfa için pagination uygulandı. off set ve limit değeri(20) ile ilk servise istek atıldı.

```
```

Birinci ve ikinci sekmedeki görünüm için tek bir tableview cell kullanıldı.
```
```
Son sekmedeki silme işlemi için silinen hücre tutuldu ve diğer sayfalarda bu hücrenin konumu bulunarak silme işlemi gerçekleştirildi.
TrackId değeri aynı olan hücreyi diğer tablolardanda kaldırmış olduk.
```

## Kullanılan kütüphaneler

* [Kingfisher](https://github.com/onevcat/Kingfisher/)
* [Alamofire](https://github.com/Alamofire/Alamofire/)

## Proje sahibi

Bartu Akman

