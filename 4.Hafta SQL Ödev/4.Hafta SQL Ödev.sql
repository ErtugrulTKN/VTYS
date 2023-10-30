-- Bilgisayar Programc�l���
-- 2. S�n�f 1. ��retim
-- No: 223010710056
-- Ertu�rul Yusuf Tekin

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

-- 2.Soru UYELER, ADRESLER, KUTUPHANE, Emanet, K�TAPLAR, YAZARLAR, KATEGOR�LER, 
-- KITAP_KUTUPHANE, KITAP_KATEGORI, KITAP_YAZAR tablolar�na 1 kay�t ekleyiniz, 
-- g�ncelleyiniz ve siliniz.INSERT INTO UYELER VALUES(1,'Ahmet','Demir','Erkek','05357672954','abc@mail.com','Kayseri');
INSERT INTO ADRESLER VALUES(1,'Papatya','Esenyurt','37','Adana',38001,'T�rkiye');
INSERT INTO KUTUPHANE VALUES(1,'Merkez','Merkez k�t�phane',23);
INSERT INTO EMANET VALUES(1,'5674325679',1,1,'Seher','G�ler',10-10-2023,12-12-2023,'Merkez k�t�phane');
INSERT INTO KITAPLAR VALUES('5674325679','Algoritma Ve Programlamaya Giri�',05-05-2009,571);
INSERT INTO YAZARLAR VALUES(1,'Se�kin','G�r�r');
INSERT INTO KATEGORILER VALUES(1,'Programlama');
INSERT INTO KITAP_KUTUPHANE VALUES(1,'5674325679',130);

-- 3.Soru �YELER tablosunda kay�tlar�n var oldu�u varsay�ld���nda, kay�tlar� �UyeNo� s�tununa g�re 
-- artan s�rada listelemek i�in gerekli SQL ifadesini yaz�n�z

SELECT * FROM UYELER
ORDER BY UYE_NO ASC;

-- 4.Soru Ocak 2023 �ten sonra emanet al�nan kitaplar� listelemek i�in gerekli SQL ifadeleri yaz�n�z. --
SELECT *
FROM EMANET
WHERE EMANET_TARIHI > '2023-01-31'

-- 5.Soru  Kayseri�de ikamet eden ve telefonu i�erisinde 6 i�eren �yeleri listelemek i�in gerekli SQL --
SELECT *
FROM UYELER
WHERE TELEFON LIKE '%6%' AND  = 'Kayseri'

-- 6.Soru Teslim tarihi 1 ay dan az kalan kitaplar� listelemek i�in gerekli SQL ifadesini yaz�n�z.--
SELECT *
FROM EMANET
WHERE TESLIM_TARIHI < DATEADD(month, 1, GETDATE())

-- 7.Soru  Soyad� be� karakterden fazla olan m��terilerin ad ve soyad bilgisini ad�n�n ilk harfini ve 
-- soyad�n�n ilk be� karakterini birle�tirerek tek bir s�tunda ad�na g�re alfabetik s�rada 
-- listelemek i�in gerekli SQL ifadesini yaz�n�z. 
SELECT CONCAT(LEFT(UYE_ADI, 1), LEFT(UYE_SOYADI, 5)) AS 'Ad Soyad'
FROM UYELER
WHERE LEN(UYE_SOYADI) > 5
ORDER BY 'Ad Soyad' ASC

-- 8.Soru �yelerin sadece �Sehir� bilgisini alfabetik olarak listelemek i�in gerekli SQL ifadesini yaz�n�z. --
SELECT SEHIR
FROM UYELER
ORDER BY SEHIR ASC

-- 9.Soru 2020 y�l�nda yap�lan emanet say�s�n� bulmak i�in gerekli SQL ifadesini yaz�n�z.--
SELECT COUNT(*)
FROM EMANET
WHERE YEAR(EMANET_TARIHI) = 2020

-- 10.Soru  Emanet al�nan k�t�phanenin ismi �Kayseri Belediyesi Merkez K�t�phanesi� olan kitaplar�n 
-- emanet s�resi 6 aydan fazla olan al�mlar� listelemek i�in gerekli SQL ifadesini yaz�n�z-- 
SELECT *
FROM EMANET
WHERE KUTUPHANE = 'Kayseri Belediyesi Merkez K�t�phanesi' AND DATEDIFF(month, EMANET_TARIHI, TESLIM_TARIHI) > 6

-- 11.Soru Eski�ehir�de ya�ayan �yelerin say�s�n� bulmak i�in gerekli SQL ifadesini yaz�n�z --
SELECT COUNT(*) FROM uyeler WHERE SEHIR = 'Eski�ehir';

-- 12.Soru �Yay�nTarihi� 3 ya��ndan b�y�k olan kitaplar�n yazar bilgisini listelemek i�in gerekli SQL 
-- ifadesini yaz�n�z.--
SELECT YAZAR_ADI, YAZAR_SOYADI
FROM YAZARLAR
WHERE DATEDIFF(year, YAYIN_TARIHI, GETDATE()) > 3

-- 13.Soru Her bir kitab�n emanet edildi�i s�relerin en uzun ve en k�sa olanlar� bulunuz.--
SELECT ISBN, MAX(EMANET_TARIHI) AS en_uzun_sure
FROM EMANET
GROUP BY ISBN;

-- 14.Soru Emanet verilen kitaplar�, emanet alan �yelerin ad ve soyad bilgisini listelemek i�in gerekli SQL 
-- ifadesini yaz�n�z.--
SELECT UYE_ADI, UYE_SOYADI
FROM EMANET
INNER JOIN UYELER ON EMANET.UYE_NO = UYE_ID,)