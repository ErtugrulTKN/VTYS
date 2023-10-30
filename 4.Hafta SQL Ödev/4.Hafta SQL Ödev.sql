-- Bilgisayar Programcýlýðý
-- 2. Sýnýf 1. Öðretim
-- No: 223010710056
-- Ertuðrul Yusuf Tekin

CREATE TABLE UYELER(
  UYE_NO INT IDENTITY(1,1),
  UYE_ADI VARCHAR(30),
  UYE_SOYADI VARCHAR(20),
  CINSIYET VARCHAR(10),
  TELEFON VARCHAR(15),
  EPOSTA VARCHAR(50),
  ADRES_NO INT,
  PRIMARY KEY("UYE_NO")
  );

CREATE TABLE ADRESLER(
  ADRES_NO INT IDENTITY(1,1),
  CADDE VARCHAR(30),
  MAHALLE VARCHAR(30),
  BINA_NO INT,
  SEHIR VARCHAR(30),
  POSTA_KODU INT,
  ULKE VARCHAR(30),
  PRIMARY KEY("ADRES_NO")
  );

ALTER TABLE UYELER ADD CONSTRAINT "ADRESLER_UYELER"
FOREIGN KEY (ADRES_NO) REFERENCES ADRESLER(ADRES_NO);

CREATE TABLE EMANET(
  EMANET_NO INT IDENTITY(1,1),
  ISBN BIGINT NOT NULL,
  UYE_NO INT NOT NULL,
  KUTUPHANE_NO INT NOT NULL,
  EMANET_TARIHI DATETIME,
  TESLIM_TARIHI DATETIME,
  PRIMARY KEY("EMANET_NO")
  );

  CREATE TABLE KITAPLAR(
    ISBN VARCHAR(20),
	KITAP_ADI VARCHAR(30),
	YAYIN_TARIHI DATETIME,
	S_SAYISI INT,
	PRIMARY KEY("ISBN")
);

CREATE TABLE YAZARLAR(
	YAZAR_NO INT IDENTITY(1,1),
	YAZAR_ADI VARCHAR(20),
	YAZAR_SOYADI VARCHAR(20),
	PRIMARY KEY ("YAZAR_NO")
);

CREATE TABLE KATEGORILER(
	KATEGORI_NO INT IDENTITY(1,1),
	KATEGORI_ADI VARCHAR(20),
	PRIMARY KEY ("KATEGORI_NO")
);

CREATE TABLE KUTUPHANE(
	KUTUPHANE_NO INT IDENTITY(1,1),
	KUTUPHANE_ADI VARCHAR(20),
	ACIKLAMA VARCHAR(20),
	ADRES_NO INT,
	PRIMARY KEY ("KUTUPHANE_NO")
);

CREATE TABLE KITAP_KUTUPHANE(
	KUTUPHANE_NO INT NOT NULL,
	ISBN VARCHAR(20) NOT NULL,
	MIKTAR INT,
	CONSTRAINT "KITAP_KUTUPHANE_PK" PRIMARY KEY ("KUTUPHANE_NO", "ISBN"),
	CONSTRAINT "KITAP_KUTUPHANE_FK" FOREIGN KEY ("KUTUPHANE_NO") REFERENCES KATEGORILER(KATEGORI_NO)

);

ALTER TABLE KITAP_KUTUPHANE ADD CONSTRAINT "KITAP_KUTUPHANE_KITAPLAR_FK" FOREIGN KEY ("ISBN") REFERENCES KITAPLAR(ISBN);

CREATE TABLE KITAP_KATEGORI(
	ISBN VARCHAR(20) NOT NULL,
	KATEGORI_NO INT NOT NULL,
	CONSTRAINT "KITAP_KATEGORI_PK" PRIMARY KEY ("KATEGORI_NO", "ISBN")
);

CREATE TABLE KITAP_YAZAR(
	ISBN VARCHAR(20) NOT NULL,
	YAZAR_NO INT NOT NULL,
	CONSTRAINT "KITAP_YAZAR_PK" PRIMARY KEY ("YAZAR_NO", "ISBN")
);

-- 2.Soru UYELER, ADRESLER, KUTUPHANE, Emanet, KÝTAPLAR, YAZARLAR, KATEGORÝLER, 
-- KITAP_KUTUPHANE, KITAP_KATEGORI, KITAP_YAZAR tablolarýna 1 kayýt ekleyiniz, 
-- güncelleyiniz ve siliniz.INSERT INTO UYELER VALUES(1,'Ahmet','Demir','Erkek','05357672954','abc@mail.com','Kayseri');
INSERT INTO ADRESLER VALUES(1,'Papatya','Esenyurt','37','Adana',38001,'Türkiye');
INSERT INTO KUTUPHANE VALUES(1,'Merkez','Merkez kütüphane',23);
INSERT INTO EMANET VALUES(1,'5674325679',1,1,'Seher','Güler',10-10-2023,12-12-2023,'Merkez kütüphane');
INSERT INTO KITAPLAR VALUES('5674325679','Algoritma Ve Programlamaya Giriþ',05-05-2009,571);
INSERT INTO YAZARLAR VALUES(1,'Seçkin','Görür');
INSERT INTO KATEGORILER VALUES(1,'Programlama');
INSERT INTO KITAP_KUTUPHANE VALUES(1,'5674325679',130);

-- 3.Soru ÜYELER tablosunda kayýtlarýn var olduðu varsayýldýðýnda, kayýtlarý “UyeNo” sütununa göre 
-- artan sýrada listelemek için gerekli SQL ifadesini yazýnýz

SELECT * FROM UYELER
ORDER BY UYE_NO ASC;

-- 4.Soru Ocak 2023 ‘ten sonra emanet alýnan kitaplarý listelemek için gerekli SQL ifadeleri yazýnýz. --
SELECT *
FROM EMANET
WHERE EMANET_TARIHI > '2023-01-31'

-- 5.Soru  Kayseri’de ikamet eden ve telefonu içerisinde 6 içeren üyeleri listelemek için gerekli SQL --
SELECT *
FROM UYELER
WHERE TELEFON LIKE '%6%' AND  = 'Kayseri'

-- 6.Soru Teslim tarihi 1 ay dan az kalan kitaplarý listelemek için gerekli SQL ifadesini yazýnýz.--
SELECT *
FROM EMANET
WHERE TESLIM_TARIHI < DATEADD(month, 1, GETDATE())

-- 7.Soru  Soyadý beþ karakterden fazla olan müþterilerin ad ve soyad bilgisini adýnýn ilk harfini ve 
-- soyadýnýn ilk beþ karakterini birleþtirerek tek bir sütunda adýna göre alfabetik sýrada 
-- listelemek için gerekli SQL ifadesini yazýnýz. 
SELECT CONCAT(LEFT(UYE_ADI, 1), LEFT(UYE_SOYADI, 5)) AS 'Ad Soyad'
FROM UYELER
WHERE LEN(UYE_SOYADI) > 5
ORDER BY 'Ad Soyad' ASC

-- 8.Soru Üyelerin sadece “Sehir” bilgisini alfabetik olarak listelemek için gerekli SQL ifadesini yazýnýz. --
SELECT SEHIR
FROM UYELER
ORDER BY SEHIR ASC

-- 9.Soru 2020 yýlýnda yapýlan emanet sayýsýný bulmak için gerekli SQL ifadesini yazýnýz.--
SELECT COUNT(*)
FROM EMANET
WHERE YEAR(EMANET_TARIHI) = 2020

-- 10.Soru  Emanet alýnan kütüphanenin ismi “Kayseri Belediyesi Merkez Kütüphanesi” olan kitaplarýn 
-- emanet süresi 6 aydan fazla olan alýmlarý listelemek için gerekli SQL ifadesini yazýnýz-- 
SELECT *
FROM EMANET
WHERE KUTUPHANE = 'Kayseri Belediyesi Merkez Kütüphanesi' AND DATEDIFF(month, EMANET_TARIHI, TESLIM_TARIHI) > 6

-- 11.Soru Eskiþehir’de yaþayan üyelerin sayýsýný bulmak için gerekli SQL ifadesini yazýnýz --
SELECT COUNT(*) FROM uyeler WHERE SEHIR = 'Eskiþehir';

-- 12.Soru “YayýnTarihi” 3 yaþýndan büyük olan kitaplarýn yazar bilgisini listelemek için gerekli SQL 
-- ifadesini yazýnýz.--
SELECT YAZAR_ADI, YAZAR_SOYADI
FROM YAZARLAR
WHERE DATEDIFF(year, YAYIN_TARIHI, GETDATE()) > 3

-- 13.Soru Her bir kitabýn emanet edildiði sürelerin en uzun ve en kýsa olanlarý bulunuz.--
SELECT ISBN, MAX(EMANET_TARIHI) AS en_uzun_sure
FROM EMANET
GROUP BY ISBN;

-- 14.Soru Emanet verilen kitaplarý, emanet alan üyelerin ad ve soyad bilgisini listelemek için gerekli SQL 
-- ifadesini yazýnýz.--
SELECT UYE_ADI, UYE_SOYADI
FROM EMANET
INNER JOIN UYELER ON EMANET.UYE_NO = UYE_ID,)