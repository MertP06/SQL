-- Yeni bir veritabaný oluþtur
CREATE DATABASE HastaneYonetimSistemi;

-- Veritabanýný kullanmak için seç
USE HastaneYonetimSistemi;

CREATE TABLE Hasta (
    HastaID INT PRIMARY KEY,
    Isim VARCHAR(50),
    Soyisim VARCHAR(50),
    DogumTarihi DATE,
    Cinsiyet CHAR(1),
    Telefon VARCHAR(20),
    Adres VARCHAR(255)
);

-- Örnek Veriler
INSERT INTO Hasta (HastaID, Isim, Soyisim, DogumTarihi, Cinsiyet, Telefon, Adres) VALUES
(1, 'Ahmet', 'Yýlmaz', '1985-04-10', 'E', '5551234567', 'Ýstanbul, Kadýköy'),
(2, 'Fatma', 'Kara', '1990-06-15', 'K', '5552345678', 'Ankara, Çankaya'),
(3, 'Mehmet', 'Can', '1975-09-23', 'E', '5553456789', 'Ýzmir, Karþýyaka'),
(4, 'Zeynep', 'Öztürk', '2000-12-01', 'K', '5554567890', 'Bursa, Nilüfer'),
(5, 'Ali', 'Demir', '1980-03-17', 'E', '5555678901', 'Konya, Meram');

CREATE TABLE Doktor (
    DoktorID INT PRIMARY KEY,
    Isim VARCHAR(50),
    Soyisim VARCHAR(50),
    Brans VARCHAR(50),
    Telefon VARCHAR(20),
    Eposta VARCHAR(100),
    CalismaSaatleri VARCHAR(100)
);

-- Örnek Veriler
INSERT INTO Doktor (DoktorID, Isim, Soyisim, Brans, Telefon, Eposta, CalismaSaatleri) VALUES
(1, 'Dr. Ali', 'Çelik', 'Kardiyoloji', '5556781234', 'ali.celik@hastane.com', '08:00 - 16:00'),
(2, 'Dr. Ayþe', 'Güler', 'Nöroloji', '5557892345', 'ayse.guler@hastane.com', '09:00 - 17:00'),
(3, 'Dr. Mehmet', 'Büyük', 'Ortopedi', '5558903456', 'mehmet.buyuk@hastane.com', '07:30 - 15:30'),
(4, 'Dr. Seda', 'Aksoy', 'Dahiliye', '5559014567', 'seda.aksoy@hastane.com', '10:00 - 18:00'),
(5, 'Dr. Hasan', 'Turan', 'Psikiyatri', '5550125678', 'hasan.turan@hastane.com', '08:30 - 16:30');

CREATE TABLE Bolum (
    BolumID INT PRIMARY KEY,
    BolumAdi VARCHAR(50),
    Kat INT,
    SorumluDoktorID INT FOREIGN KEY REFERENCES Doktor(DoktorID)
);

-- Örnek Veriler
INSERT INTO Bolum (BolumID, BolumAdi, Kat, SorumluDoktorID) VALUES
(1, 'Kardiyoloji', 1, 1),
(2, 'Nöroloji', 2, 2),
(3, 'Ortopedi', 3, 3),
(4, 'Dahiliye', 4, 4),
(5, 'Psikiyatri', 5, 5);

CREATE TABLE Randevu (
    RandevuID INT PRIMARY KEY,
    HastaID INT FOREIGN KEY REFERENCES Hasta(HastaID),
    DoktorID INT FOREIGN KEY REFERENCES Doktor(DoktorID),
    RandevuTarihi DATE,
    RandevuSaati TIME,
    Durum VARCHAR(50)
);

-- Örnek Veriler
INSERT INTO Randevu (RandevuID, HastaID, DoktorID, RandevuTarihi, RandevuSaati, Durum) VALUES
(1, 1, 1, '2024-11-12', '10:00', 'Bekliyor'),
(2, 2, 2, '2024-11-13', '14:00', 'Tamamlandý'),
(3, 3, 3, '2024-11-14', '09:30', 'Ýptal Edildi'),
(4, 4, 4, '2024-11-15', '13:00', 'Bekliyor'),
(5, 5, 5, '2024-11-16', '11:30', 'Tamamlandý');

CREATE TABLE Tedavi (
    TedaviID INT PRIMARY KEY,
    TedaviTuru VARCHAR(50),
    Aciklama TEXT,
    Maliyet DECIMAL(10, 2),
    DoktorID INT FOREIGN KEY REFERENCES Doktor(DoktorID)
);

-- Örnek Veriler
INSERT INTO Tedavi (TedaviID, TedaviTuru, Aciklama, Maliyet, DoktorID) VALUES
(1, 'Ameliyat', 'Kalp bypass ameliyatý', 15000.00, 1),
(2, 'Fizik Tedavi', 'Bel fýtýðý tedavisi', 2000.00, 3),
(3, 'Psikoterapi', 'Depresyon tedavisi', 500.00, 5),
(4, 'Cerrahi Müdahale', 'El bileði kýrýðý tedavisi', 4000.00, 3),
(5, 'Ýlaç Tedavisi', 'Migren tedavisi için ilaç tedavisi', 300.00, 2);

CREATE TABLE Hasta_Tedavi (
    HastaTedaviID INT PRIMARY KEY,
    HastaID INT FOREIGN KEY REFERENCES Hasta(HastaID),
    TedaviID INT FOREIGN KEY REFERENCES Tedavi(TedaviID),
    BaslangicTarihi DATE,
    BitisTarihi DATE,
    Durum VARCHAR(50)
);

-- Örnek Veriler
INSERT INTO Hasta_Tedavi (HastaTedaviID, HastaID, TedaviID, BaslangicTarihi, BitisTarihi, Durum) VALUES
(1, 1, 1, '2024-11-12', '2024-11-14', 'Devam Ediyor'),
(2, 2, 2, '2024-11-13', '2024-11-20', 'Tamamlandý'),
(3, 3, 3, '2024-11-14', '2024-11-28', 'Devam Ediyor'),
(4, 4, 4, '2024-11-15', '2024-11-22', 'Tamamlandý'),
(5, 5, 5, '2024-11-16', '2024-11-18', 'Ýptal Edildi');

CREATE TABLE Ilac (
    IlacID INT PRIMARY KEY,
    IlacAdi VARCHAR(100),
    UreticiFirma VARCHAR(100),
    YanEtkiler TEXT,
    KullanimTalimatlari TEXT
);

-- Örnek Veriler
INSERT INTO Ilac (IlacID, IlacAdi, UreticiFirma, YanEtkiler, KullanimTalimatlari) VALUES
(1, 'Aspirin', 'Bayer', 'Mide bulantýsý, baþ dönmesi', 'Günde 1 tablet, yemek sonrasý'),
(2, 'Parol', 'Abdi Ýbrahim', 'Yorgunluk, baþ aðrýsý', 'Günde 2 tablet, aç karnýna'),
(3, 'Neosine', 'Deva', 'Aðýz kuruluðu, halsizlik', 'Günde 1 tablet, sabahlarý'),
(4, 'Zyrtec', 'Johnson & Johnson', 'Uykusuzluk, baþ aðrýsý', 'Günde 1 tablet, akþamlarý'),
(5, 'Lisinopril', 'Novartis', 'Öksürük, baþ dönmesi', 'Günde 1 tablet, sabahlarý');

CREATE TABLE Recete (
    ReceteID INT PRIMARY KEY,
    RandevuID INT FOREIGN KEY REFERENCES Randevu(RandevuID),
    DoktorID INT FOREIGN KEY REFERENCES Doktor(DoktorID),
    YazilmaTarihi DATE
);

-- Örnek Veriler
INSERT INTO Recete (ReceteID, RandevuID, DoktorID, YazilmaTarihi) VALUES
(1, 1, 1, '2024-11-12'),
(2, 2, 2, '2024-11-13'),
(3, 3, 3, '2024-11-14'),
(4, 4, 4, '2024-11-15'),
(5, 5, 5, '2024-11-16');

CREATE TABLE Recete_Ilac (
    ReceteIlacID INT PRIMARY KEY,
    ReceteID INT FOREIGN KEY REFERENCES Recete(ReceteID),
    IlacID INT FOREIGN KEY REFERENCES Ilac(IlacID),
    Dozaj VARCHAR(50),
    KullanimSuresi INT
);

-- Örnek Veriler
INSERT INTO Recete_Ilac (ReceteIlacID, ReceteID, IlacID, Dozaj, KullanimSuresi) VALUES
(1, 1, 1, '1 tablet', 7),
(2, 2, 2, '2 tablet', 5),
(3, 3, 3, '1 tablet', 10),
(4, 4, 4, '1 tablet', 5),
(5, 5, 5, '1 tablet', 3);
