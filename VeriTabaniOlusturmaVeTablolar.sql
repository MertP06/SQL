-- Yeni bir veritaban� olu�tur
CREATE DATABASE HastaneYonetimSistemi;

-- Veritaban�n� kullanmak i�in se�
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

-- �rnek Veriler
INSERT INTO Hasta (HastaID, Isim, Soyisim, DogumTarihi, Cinsiyet, Telefon, Adres) VALUES
(1, 'Ahmet', 'Y�lmaz', '1985-04-10', 'E', '5551234567', '�stanbul, Kad�k�y'),
(2, 'Fatma', 'Kara', '1990-06-15', 'K', '5552345678', 'Ankara, �ankaya'),
(3, 'Mehmet', 'Can', '1975-09-23', 'E', '5553456789', '�zmir, Kar��yaka'),
(4, 'Zeynep', '�zt�rk', '2000-12-01', 'K', '5554567890', 'Bursa, Nil�fer'),
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

-- �rnek Veriler
INSERT INTO Doktor (DoktorID, Isim, Soyisim, Brans, Telefon, Eposta, CalismaSaatleri) VALUES
(1, 'Dr. Ali', '�elik', 'Kardiyoloji', '5556781234', 'ali.celik@hastane.com', '08:00 - 16:00'),
(2, 'Dr. Ay�e', 'G�ler', 'N�roloji', '5557892345', 'ayse.guler@hastane.com', '09:00 - 17:00'),
(3, 'Dr. Mehmet', 'B�y�k', 'Ortopedi', '5558903456', 'mehmet.buyuk@hastane.com', '07:30 - 15:30'),
(4, 'Dr. Seda', 'Aksoy', 'Dahiliye', '5559014567', 'seda.aksoy@hastane.com', '10:00 - 18:00'),
(5, 'Dr. Hasan', 'Turan', 'Psikiyatri', '5550125678', 'hasan.turan@hastane.com', '08:30 - 16:30');

CREATE TABLE Bolum (
    BolumID INT PRIMARY KEY,
    BolumAdi VARCHAR(50),
    Kat INT,
    SorumluDoktorID INT FOREIGN KEY REFERENCES Doktor(DoktorID)
);

-- �rnek Veriler
INSERT INTO Bolum (BolumID, BolumAdi, Kat, SorumluDoktorID) VALUES
(1, 'Kardiyoloji', 1, 1),
(2, 'N�roloji', 2, 2),
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

-- �rnek Veriler
INSERT INTO Randevu (RandevuID, HastaID, DoktorID, RandevuTarihi, RandevuSaati, Durum) VALUES
(1, 1, 1, '2024-11-12', '10:00', 'Bekliyor'),
(2, 2, 2, '2024-11-13', '14:00', 'Tamamland�'),
(3, 3, 3, '2024-11-14', '09:30', '�ptal Edildi'),
(4, 4, 4, '2024-11-15', '13:00', 'Bekliyor'),
(5, 5, 5, '2024-11-16', '11:30', 'Tamamland�');

CREATE TABLE Tedavi (
    TedaviID INT PRIMARY KEY,
    TedaviTuru VARCHAR(50),
    Aciklama TEXT,
    Maliyet DECIMAL(10, 2),
    DoktorID INT FOREIGN KEY REFERENCES Doktor(DoktorID)
);

-- �rnek Veriler
INSERT INTO Tedavi (TedaviID, TedaviTuru, Aciklama, Maliyet, DoktorID) VALUES
(1, 'Ameliyat', 'Kalp bypass ameliyat�', 15000.00, 1),
(2, 'Fizik Tedavi', 'Bel f�t��� tedavisi', 2000.00, 3),
(3, 'Psikoterapi', 'Depresyon tedavisi', 500.00, 5),
(4, 'Cerrahi M�dahale', 'El bile�i k�r��� tedavisi', 4000.00, 3),
(5, '�la� Tedavisi', 'Migren tedavisi i�in ila� tedavisi', 300.00, 2);

CREATE TABLE Hasta_Tedavi (
    HastaTedaviID INT PRIMARY KEY,
    HastaID INT FOREIGN KEY REFERENCES Hasta(HastaID),
    TedaviID INT FOREIGN KEY REFERENCES Tedavi(TedaviID),
    BaslangicTarihi DATE,
    BitisTarihi DATE,
    Durum VARCHAR(50)
);

-- �rnek Veriler
INSERT INTO Hasta_Tedavi (HastaTedaviID, HastaID, TedaviID, BaslangicTarihi, BitisTarihi, Durum) VALUES
(1, 1, 1, '2024-11-12', '2024-11-14', 'Devam Ediyor'),
(2, 2, 2, '2024-11-13', '2024-11-20', 'Tamamland�'),
(3, 3, 3, '2024-11-14', '2024-11-28', 'Devam Ediyor'),
(4, 4, 4, '2024-11-15', '2024-11-22', 'Tamamland�'),
(5, 5, 5, '2024-11-16', '2024-11-18', '�ptal Edildi');

CREATE TABLE Ilac (
    IlacID INT PRIMARY KEY,
    IlacAdi VARCHAR(100),
    UreticiFirma VARCHAR(100),
    YanEtkiler TEXT,
    KullanimTalimatlari TEXT
);

-- �rnek Veriler
INSERT INTO Ilac (IlacID, IlacAdi, UreticiFirma, YanEtkiler, KullanimTalimatlari) VALUES
(1, 'Aspirin', 'Bayer', 'Mide bulant�s�, ba� d�nmesi', 'G�nde 1 tablet, yemek sonras�'),
(2, 'Parol', 'Abdi �brahim', 'Yorgunluk, ba� a�r�s�', 'G�nde 2 tablet, a� karn�na'),
(3, 'Neosine', 'Deva', 'A��z kurulu�u, halsizlik', 'G�nde 1 tablet, sabahlar�'),
(4, 'Zyrtec', 'Johnson & Johnson', 'Uykusuzluk, ba� a�r�s�', 'G�nde 1 tablet, ak�amlar�'),
(5, 'Lisinopril', 'Novartis', '�ks�r�k, ba� d�nmesi', 'G�nde 1 tablet, sabahlar�');

CREATE TABLE Recete (
    ReceteID INT PRIMARY KEY,
    RandevuID INT FOREIGN KEY REFERENCES Randevu(RandevuID),
    DoktorID INT FOREIGN KEY REFERENCES Doktor(DoktorID),
    YazilmaTarihi DATE
);

-- �rnek Veriler
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

-- �rnek Veriler
INSERT INTO Recete_Ilac (ReceteIlacID, ReceteID, IlacID, Dozaj, KullanimSuresi) VALUES
(1, 1, 1, '1 tablet', 7),
(2, 2, 2, '2 tablet', 5),
(3, 3, 3, '1 tablet', 10),
(4, 4, 4, '1 tablet', 5),
(5, 5, 5, '1 tablet', 3);
