--
-- PostgreSQL database dump
--

-- Dumped from database version 11.14
-- Dumped by pg_dump version 14.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: MarketVeritabani; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "MarketVeritabani" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Turkish_Turkey.1254';


ALTER DATABASE "MarketVeritabani" OWNER TO postgres;

\connect "MarketVeritabani"

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: StokTakipTetik(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."StokTakipTetik"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW."stokadedi" <> OLD."stokadedi" THEN
        INSERT INTO "stokAdediTakip"("urunid","adi", "eskiStokAdedi", "yeniStokAdedi", "degisiklikTarihi")
        VALUES(OLD."urunid", OLD."adi", OLD."stokadedi", NEW."stokadedi", CURRENT_TIMESTAMP::TIMESTAMP);
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public."StokTakipTetik"() OWNER TO postgres;

--
-- Name: dolarfiyat(money); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.dolarfiyat(satisfiyat money) RETURNS money
    LANGUAGE plpgsql
    AS $$
BEGIN
satisfiyat:=satisfiyat / 16.42;
return satisfiyat;
END;
$$;


ALTER FUNCTION public.dolarfiyat(satisfiyat money) OWNER TO postgres;

--
-- Name: kar(money, money); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kar(satisfiyat money, alisfiyat money) RETURNS money
    LANGUAGE plpgsql
    AS $$
DECLARE 
    topkar money;
BEGIN
topkar=satisfiyat - alisfiyat;
return topkar;
END;
$$;


ALTER FUNCTION public.kar(satisfiyat money, alisfiyat money) OWNER TO postgres;

--
-- Name: musteriara(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.musteriara(musteriid integer) RETURNS TABLE(customerid integer, firstname character varying, lastname character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY SELECT "musteriId", "adi", "soyadi" FROM "Musteri"
                 WHERE "musteriId" = musteriId;
END;
$$;


ALTER FUNCTION public.musteriara(musteriid integer) OWNER TO postgres;

--
-- Name: silinenPersonelTetik(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."silinenPersonelTetik"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    
    INSERT INTO "silinenPersonel"("personelId", "adi", "soyadi", "telNo", "unvanId", "postaKodu", "mesaiId", "degisiklikTarihi")
    VALUES(OLD."personelId", OLD."adi", OLD."soyadi", OLD."telNo", OLD."unvanId", OLD."postaKodu", OLD."mesaiId", CURRENT_TIMESTAMP::TIMESTAMP);
    

    RETURN NEW;
END;
$$;


ALTER FUNCTION public."silinenPersonelTetik"() OWNER TO postgres;

--
-- Name: silinenUrunTetik(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."silinenUrunTetik"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    
    INSERT INTO "silinenUrun"("urunid", "adi", "uretimyeri", "alisfiyat", "satisfiyat", "stokadedi", "degisiklikTarihi")
    VALUES(OLD."urunid", OLD."adi", OLD."uretimyeri", OLD."alisfiyat", OLD."satisfiyat", OLD."stokadedi", CURRENT_TIMESTAMP::TIMESTAMP);
    

    RETURN NEW;
END;
$$;


ALTER FUNCTION public."silinenUrunTetik"() OWNER TO postgres;

--
-- Name: urunDegisikligiTetik(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."urunDegisikligiTetik"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW."satisfiyat" <> OLD."satisfiyat" THEN
        INSERT INTO "UrunDegisikligiIzle"("urunid", "eskiSatisFiyati", "yeniSatisFiyati", "degisiklikTarihi")
        VALUES(OLD."urunid", OLD."satisfiyat", NEW."satisfiyat", CURRENT_TIMESTAMP::TIMESTAMP);
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public."urunDegisikligiTetik"() OWNER TO postgres;

--
-- Name: urunkayit(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.urunkayit() RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    products urun%ROWTYPE; -- urun."urunid"%TYPE
    sonuc TEXT;
BEGIN
    sonuc := '';
    FOR products IN SELECT * FROM urun LOOP
        sonuc := sonuc || products."urunid" || E'\t' || products."adi" || E'\r\n';
    END LOOP;
    RETURN sonuc;
END;
$$;


ALTER FUNCTION public.urunkayit() OWNER TO postgres;

SET default_tablespace = '';

--
-- Name: Fatura; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Fatura" (
    "faturaId" integer NOT NULL,
    "toplamUrun" integer NOT NULL,
    "toplamFiyat" money NOT NULL,
    "musteriId" integer NOT NULL,
    "personelId" integer NOT NULL
);


ALTER TABLE public."Fatura" OWNER TO postgres;

--
-- Name: IndirimKuponu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."IndirimKuponu" (
    "kuponId" integer NOT NULL,
    "indirimYuzdesi" smallint NOT NULL,
    "musteriId" integer NOT NULL,
    CONSTRAINT "yuzdeCheck" CHECK ((("indirimYuzdesi" > 0) AND ("indirimYuzdesi" < 100)))
);


ALTER TABLE public."IndirimKuponu" OWNER TO postgres;

--
-- Name: KargoFirmasi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."KargoFirmasi" (
    "kargoId" integer NOT NULL,
    "firmaAdi" character varying(20) NOT NULL,
    adresi text
);


ALTER TABLE public."KargoFirmasi" OWNER TO postgres;

--
-- Name: Marka; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Marka" (
    "markaId" integer NOT NULL,
    "markaAdi" character varying(20) NOT NULL,
    mensei character varying(20) NOT NULL
);


ALTER TABLE public."Marka" OWNER TO postgres;

--
-- Name: MesaiSaati; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."MesaiSaati" (
    "mesaiId" integer NOT NULL,
    "baslangicSaati" time without time zone NOT NULL,
    "bitisSaati" time without time zone NOT NULL
);


ALTER TABLE public."MesaiSaati" OWNER TO postgres;

--
-- Name: Musteri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Musteri" (
    "musteriId" integer NOT NULL,
    adi character varying(20) NOT NULL,
    soyadi character varying(20) NOT NULL,
    "telNo" character(11) NOT NULL,
    "plakaKodu" integer NOT NULL
);


ALTER TABLE public."Musteri" OWNER TO postgres;

--
-- Name: MusteriIli; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."MusteriIli" (
    "plakaKodu" integer NOT NULL,
    "ilAdi" character varying(20) NOT NULL
);


ALTER TABLE public."MusteriIli" OWNER TO postgres;

--
-- Name: MusteriUrun; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."MusteriUrun" (
    "musteriId" integer NOT NULL,
    "urunId" integer NOT NULL
);


ALTER TABLE public."MusteriUrun" OWNER TO postgres;

--
-- Name: Personel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Personel" (
    "personelId" integer NOT NULL,
    adi character varying(30) NOT NULL,
    soyadi character varying(30) NOT NULL,
    "telNo" character(11) NOT NULL,
    "unvanId" integer NOT NULL,
    "postaKodu" integer NOT NULL,
    "mesaiId" integer NOT NULL
);


ALTER TABLE public."Personel" OWNER TO postgres;

--
-- Name: PersonelIlce; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PersonelIlce" (
    "postaKodu" integer NOT NULL,
    "ilceAdi" character varying(30) NOT NULL
);


ALTER TABLE public."PersonelIlce" OWNER TO postgres;

--
-- Name: Reyon; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Reyon" (
    "reyonId" integer NOT NULL,
    "reyonAdi" character varying(20) NOT NULL
);


ALTER TABLE public."Reyon" OWNER TO postgres;

--
-- Name: Tedarikci; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Tedarikci" (
    "tedarikciId" integer NOT NULL,
    "tedarikciAdi" character varying(20) NOT NULL,
    adresi text
);


ALTER TABLE public."Tedarikci" OWNER TO postgres;

--
-- Name: Unvan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Unvan" (
    "unvanId" integer NOT NULL,
    "unvanAdi" character varying(30) NOT NULL
);


ALTER TABLE public."Unvan" OWNER TO postgres;

--
-- Name: UrunDegisikligiIzle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UrunDegisikligiIzle" (
    "kayitNo" integer NOT NULL,
    urunid integer NOT NULL,
    "eskiSatisFiyati" money NOT NULL,
    "yeniSatisFiyati" money NOT NULL,
    "degisiklikTarihi" timestamp with time zone NOT NULL
);


ALTER TABLE public."UrunDegisikligiIzle" OWNER TO postgres;

--
-- Name: UrunDegisikligiIzle_kayitNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."UrunDegisikligiIzle_kayitNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."UrunDegisikligiIzle_kayitNo_seq" OWNER TO postgres;

--
-- Name: UrunDegisikligiIzle_kayitNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."UrunDegisikligiIzle_kayitNo_seq" OWNED BY public."UrunDegisikligiIzle"."kayitNo";


--
-- Name: UrunMarka; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UrunMarka" (
    "urunId" integer NOT NULL,
    "markaId" integer NOT NULL
);


ALTER TABLE public."UrunMarka" OWNER TO postgres;

--
-- Name: silinenPersonel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."silinenPersonel" (
    "personelId" integer NOT NULL,
    adi character varying(30) NOT NULL,
    soyadi character varying(30) NOT NULL,
    "telNo" character(11) NOT NULL,
    "postaKodu" integer NOT NULL,
    "unvanId" integer NOT NULL,
    "mesaiId" integer NOT NULL,
    "degisiklikTarihi" timestamp without time zone NOT NULL,
    "kayitNo" integer NOT NULL
);


ALTER TABLE public."silinenPersonel" OWNER TO postgres;

--
-- Name: silinenPersonel_kayitNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."silinenPersonel_kayitNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."silinenPersonel_kayitNo_seq" OWNER TO postgres;

--
-- Name: silinenPersonel_kayitNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."silinenPersonel_kayitNo_seq" OWNED BY public."silinenPersonel"."kayitNo";


--
-- Name: silinenUrun; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."silinenUrun" (
    "kayitNo" integer NOT NULL,
    urunid integer NOT NULL,
    uretimyeri character varying(25) NOT NULL,
    stokadedi integer NOT NULL,
    "degisiklikTarihi" timestamp without time zone NOT NULL,
    adi character varying(25) NOT NULL,
    satisfiyat money NOT NULL,
    alisfiyat money NOT NULL
);


ALTER TABLE public."silinenUrun" OWNER TO postgres;

--
-- Name: silinenUrun_kayitNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."silinenUrun_kayitNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."silinenUrun_kayitNo_seq" OWNER TO postgres;

--
-- Name: silinenUrun_kayitNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."silinenUrun_kayitNo_seq" OWNED BY public."silinenUrun"."kayitNo";


--
-- Name: stokAdediTakip; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."stokAdediTakip" (
    "kayitNo" integer NOT NULL,
    urunid integer NOT NULL,
    adi character varying(25) NOT NULL,
    "eskiStokAdedi" integer NOT NULL,
    "yeniStokAdedi" integer NOT NULL,
    "degisiklikTarihi" timestamp without time zone NOT NULL
);


ALTER TABLE public."stokAdediTakip" OWNER TO postgres;

--
-- Name: stokAdediTakip_kayitNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."stokAdediTakip_kayitNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."stokAdediTakip_kayitNo_seq" OWNER TO postgres;

--
-- Name: stokAdediTakip_kayitNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."stokAdediTakip_kayitNo_seq" OWNED BY public."stokAdediTakip"."kayitNo";


--
-- Name: urun; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.urun (
    urunid integer NOT NULL,
    adi character varying(25) NOT NULL,
    uretimyeri character varying(25) DEFAULT 'Türkiye'::character varying,
    alisfiyat money NOT NULL,
    satisfiyat money NOT NULL,
    stokadedi integer NOT NULL,
    kargoid integer NOT NULL,
    tedarikciid integer NOT NULL,
    reyonid integer NOT NULL
);


ALTER TABLE public.urun OWNER TO postgres;

--
-- Name: UrunDegisikligiIzle kayitNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UrunDegisikligiIzle" ALTER COLUMN "kayitNo" SET DEFAULT nextval('public."UrunDegisikligiIzle_kayitNo_seq"'::regclass);


--
-- Name: silinenPersonel kayitNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."silinenPersonel" ALTER COLUMN "kayitNo" SET DEFAULT nextval('public."silinenPersonel_kayitNo_seq"'::regclass);


--
-- Name: silinenUrun kayitNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."silinenUrun" ALTER COLUMN "kayitNo" SET DEFAULT nextval('public."silinenUrun_kayitNo_seq"'::regclass);


--
-- Name: stokAdediTakip kayitNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."stokAdediTakip" ALTER COLUMN "kayitNo" SET DEFAULT nextval('public."stokAdediTakip_kayitNo_seq"'::regclass);


--
-- Data for Name: Fatura; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Fatura" VALUES
	(1, 3, '?45,00', 1, 2),
	(2, 2, '?67,00', 1, 1),
	(3, 10, '?1.456,00', 1, 1);


--
-- Data for Name: IndirimKuponu; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: KargoFirmasi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."KargoFirmasi" VALUES
	(2, 'kargo2', ''),
	(3, 'kargo3', ''),
	(4, 'kargo4', ''),
	(5, 'kargo5', ''),
	(6, 'kargo6', ''),
	(7, 'kargo7', ''),
	(8, 'kargo8', ''),
	(1, 'kargocu1', '');


--
-- Data for Name: Marka; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Marka" VALUES
	(1, 'dove', 'israil'),
	(2, 'biryağ', 'türkiye'),
	(3, 'pınar', 'türkiye'),
	(4, 'bosch', 'almanya'),
	(5, 'adidas', 'almanya');


--
-- Data for Name: MesaiSaati; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."MesaiSaati" VALUES
	(1, '08:00:00', '18:00:00'),
	(2, '12:00:00', '20:00:00'),
	(3, '08:00:00', '20:00:00'),
	(4, '06:00:00', '12:00:00'),
	(5, '10:00:00', '22:00:00');


--
-- Data for Name: Musteri; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Musteri" VALUES
	(1, 'sadasdasd', 'faaffaaffa', '12388128931', 34),
	(2, 'ali', 'kıran', '05556542187', 1),
	(3, 'qweqwe', 'zxc', '32178378127', 6),
	(4, 'hjk', 'jkl', '32187128737', 35),
	(5, 'ertay', 'kırıcı', '18928938919', 55);


--
-- Data for Name: MusteriIli; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."MusteriIli" VALUES
	(34, 'istanbul'),
	(1, 'adana'),
	(35, 'izmir'),
	(6, 'ankara'),
	(52, 'ordu'),
	(55, 'samsun'),
	(57, 'sinop');


--
-- Data for Name: MusteriUrun; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Personel; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Personel" VALUES
	(32, 'Beyza', 'Özmen', '0555241812 ', 2, 3, 1),
	(1, 'ali', 'ceylan', '0568210938 ', 1, 3, 3),
	(2, 'İbrahim', 'Özmen', '0555241811 ', 1, 1, 2),
	(4, 'mehmet', 'özen', '0216772127 ', 1, 2, 4),
	(3, 'ali ', 'ceylan', '3217831787 ', 1, 1, 1),
	(5, 'ahmet ', 'asdasd', '3218771233 ', 1, 2, 2);


--
-- Data for Name: PersonelIlce; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."PersonelIlce" VALUES
	(1, 'serdivan '),
	(2, 'esentepe'),
	(3, 'bağcılar'),
	(4, 'esenler');


--
-- Data for Name: Reyon; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Reyon" VALUES
	(1, 'kozmetik'),
	(2, 'unlu mamul'),
	(3, 'bakliyat'),
	(4, 'kurugıda'),
	(5, 'sütürünleri'),
	(6, 'işlenmişgıda'),
	(7, 'işlenmişet'),
	(8, 'alkol');


--
-- Data for Name: Tedarikci; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Tedarikci" VALUES
	(1, 'tedarikci1', ''),
	(2, 'tedarikci32', ''),
	(3, 'güneş gıda', ''),
	(4, 'reis gıda', ''),
	(5, 'şen süt', ''),
	(6, 'özmen gıda', ''),
	(7, 'tedarikci3', ''),
	(8, 'TEDARIKCI12', '');


--
-- Data for Name: Unvan; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Unvan" VALUES
	(1, 'depo sorumlusu'),
	(2, 'reyon sorumlusu'),
	(3, 'kasiyer'),
	(4, 'yönetici');


--
-- Data for Name: UrunDegisikligiIzle; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."UrunDegisikligiIzle" VALUES
	(1, 3, '?3,00', '?4,00', '2021-12-15 01:59:31.662985+03'),
	(2, 22, '?4,00', '?6,00', '2021-12-19 21:41:41.927355+03'),
	(3, 5, '?18,00', '?27,00', '2021-12-19 21:43:00.475137+03');


--
-- Data for Name: UrunMarka; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: silinenPersonel; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."silinenPersonel" VALUES
	(2, 'ahmet ', 'seçkin', '0523812381 ', 1, 2, 3, '2021-12-15 16:58:04.407896', 1);


--
-- Data for Name: silinenUrun; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."silinenUrun" VALUES
	(3, 2, 'Türkiye', 29, '2021-12-15 16:19:55.653429', '15il yumurta', '?16,99', '?13,00'),
	(4, 1, 'Türkiye', 36, '2021-12-15 16:25:34.356957', '30lu yumurta', '?29,99', '?27,00'),
	(5, 3, 'Türkiye', 15, '2021-12-19 18:43:47.357255', '250gr salam', '?8,99', '?7,50'),
	(6, 1, 'Türkiye', 8, '2021-12-19 18:49:03.644221', 'sucuk', '?25,49', '?23,00'),
	(7, 5, 'Türkiye', 55, '2021-12-19 23:16:08.442546', 'şarap', '?27,00', '?20,00');


--
-- Data for Name: stokAdediTakip; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."stokAdediTakip" VALUES
	(2, 4, '500gr ekmek', 15, 19, '2021-12-15 17:16:19.785764'),
	(5, 5, 'bira', 41, 55, '2021-12-19 21:39:37.397413');


--
-- Data for Name: urun; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.urun VALUES
	(4, '500gr ekmek', 'Türkiye', '?4,50', '?6,00', 19, 2, 4, 5),
	(48, 'sdadasdas', 'TR', '?43,00', '?46,00', 231, 2, 2, 4),
	(22, 'f', 'd', '?2,00', '?6,00', 231, 1, 1, 2),
	(2, '1kg şeker', 'Türkiye', '?4,00', '?6,00', 24, 2, 1, 5),
	(1, 'katı sabun', 'Türkiye', '?5,00', '?7,50', 13, 1, 2, 4),
	(3, 'sıvı sabun', 'Türkiye', '?6,00', '?9,00', 21, 2, 3, 4),
	(5, '500gr kıyma', 'Türkiye', '?29,00', '?35,00', 9, 3, 3, 3);


--
-- Name: UrunDegisikligiIzle_kayitNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."UrunDegisikligiIzle_kayitNo_seq"', 3, true);


--
-- Name: silinenPersonel_kayitNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."silinenPersonel_kayitNo_seq"', 1, true);


--
-- Name: silinenUrun_kayitNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."silinenUrun_kayitNo_seq"', 7, true);


--
-- Name: stokAdediTakip_kayitNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."stokAdediTakip_kayitNo_seq"', 5, true);


--
-- Name: Fatura Fatura_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Fatura"
    ADD CONSTRAINT "Fatura_pkey" PRIMARY KEY ("faturaId");


--
-- Name: MesaiSaati MesaiSaatiPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MesaiSaati"
    ADD CONSTRAINT "MesaiSaatiPK" PRIMARY KEY ("mesaiId");


--
-- Name: silinenUrun PK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."silinenUrun"
    ADD CONSTRAINT "PK" PRIMARY KEY ("kayitNo");


--
-- Name: PersonelIlce PersonelIlcePK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PersonelIlce"
    ADD CONSTRAINT "PersonelIlcePK" PRIMARY KEY ("postaKodu");


--
-- Name: UrunDegisikligiIzle UrunDegisikligiIzle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UrunDegisikligiIzle"
    ADD CONSTRAINT "UrunDegisikligiIzle_pkey" PRIMARY KEY ("kayitNo");


--
-- Name: UrunMarka UrunMarka_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UrunMarka"
    ADD CONSTRAINT "UrunMarka_pkey" PRIMARY KEY ("urunId", "markaId");


--
-- Name: IndirimKuponu indirimKuponu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."IndirimKuponu"
    ADD CONSTRAINT "indirimKuponu_pkey" PRIMARY KEY ("kuponId");


--
-- Name: MusteriIli musteriIli_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MusteriIli"
    ADD CONSTRAINT "musteriIli_pkey" PRIMARY KEY ("plakaKodu");


--
-- Name: MusteriUrun musteriUrun_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MusteriUrun"
    ADD CONSTRAINT "musteriUrun_pkey" PRIMARY KEY ("musteriId", "urunId");


--
-- Name: Personel personelPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Personel"
    ADD CONSTRAINT "personelPK" PRIMARY KEY ("personelId");


--
-- Name: stokAdediTakip stokPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."stokAdediTakip"
    ADD CONSTRAINT "stokPK" PRIMARY KEY ("kayitNo");


--
-- Name: Personel telNoUnique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Personel"
    ADD CONSTRAINT "telNoUnique" UNIQUE ("telNo");


--
-- Name: KargoFirmasi unique_KargoFirmasi_kargoId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KargoFirmasi"
    ADD CONSTRAINT "unique_KargoFirmasi_kargoId" PRIMARY KEY ("kargoId");


--
-- Name: Marka unique_Marka_markaId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Marka"
    ADD CONSTRAINT "unique_Marka_markaId" PRIMARY KEY ("markaId");


--
-- Name: Reyon unique_Reyon_reyonId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Reyon"
    ADD CONSTRAINT "unique_Reyon_reyonId" PRIMARY KEY ("reyonId");


--
-- Name: Tedarikci unique_Tedarikci_tedarikciId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tedarikci"
    ADD CONSTRAINT "unique_Tedarikci_tedarikciId" PRIMARY KEY ("tedarikciId");


--
-- Name: urun unique_Urun_urunId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.urun
    ADD CONSTRAINT "unique_Urun_urunId" PRIMARY KEY (urunid);


--
-- Name: Musteri unique_musteri_musteriId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Musteri"
    ADD CONSTRAINT "unique_musteri_musteriId" PRIMARY KEY ("musteriId");


--
-- Name: Musteri unique_musteri_telNo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Musteri"
    ADD CONSTRAINT "unique_musteri_telNo" UNIQUE ("telNo");


--
-- Name: Unvan unvanIdPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Unvan"
    ADD CONSTRAINT "unvanIdPK" PRIMARY KEY ("unvanId");


--
-- Name: urun StokDegistiginde; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "StokDegistiginde" BEFORE UPDATE ON public.urun FOR EACH ROW EXECUTE PROCEDURE public."StokTakipTetik"();


--
-- Name: Personel personelSilinme; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "personelSilinme" AFTER DELETE ON public."Personel" FOR EACH ROW EXECUTE PROCEDURE public."silinenPersonelTetik"();


--
-- Name: urun urunSatisFiyatDegistiginde; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "urunSatisFiyatDegistiginde" BEFORE UPDATE ON public.urun FOR EACH ROW EXECUTE PROCEDURE public."urunDegisikligiTetik"();


--
-- Name: urun urunSilinme; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "urunSilinme" AFTER DELETE ON public.urun FOR EACH ROW EXECUTE PROCEDURE public."silinenUrunTetik"();


--
-- Name: Fatura faturaMusteriFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Fatura"
    ADD CONSTRAINT "faturaMusteriFK" FOREIGN KEY ("musteriId") REFERENCES public."Musteri"("musteriId") MATCH FULL;


--
-- Name: Fatura faturaPersonelFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Fatura"
    ADD CONSTRAINT "faturaPersonelFK" FOREIGN KEY ("personelId") REFERENCES public."Personel"("personelId") MATCH FULL;


--
-- Name: urun kargourunFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.urun
    ADD CONSTRAINT "kargourunFK" FOREIGN KEY (kargoid) REFERENCES public."KargoFirmasi"("kargoId") MATCH FULL;


--
-- Name: UrunMarka markaurunMarkaFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UrunMarka"
    ADD CONSTRAINT "markaurunMarkaFK" FOREIGN KEY ("markaId") REFERENCES public."Marka"("markaId") MATCH FULL;


--
-- Name: Musteri musteriIliFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Musteri"
    ADD CONSTRAINT "musteriIliFK" FOREIGN KEY ("plakaKodu") REFERENCES public."MusteriIli"("plakaKodu") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: IndirimKuponu musteriIndirimKuponuFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."IndirimKuponu"
    ADD CONSTRAINT "musteriIndirimKuponuFK" FOREIGN KEY ("musteriId") REFERENCES public."Musteri"("musteriId") MATCH FULL;


--
-- Name: MusteriUrun musterimusteriUrunFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MusteriUrun"
    ADD CONSTRAINT "musterimusteriUrunFK" FOREIGN KEY ("musteriId") REFERENCES public."Musteri"("musteriId") MATCH FULL;


--
-- Name: Personel personelIlceFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Personel"
    ADD CONSTRAINT "personelIlceFK" FOREIGN KEY ("postaKodu") REFERENCES public."PersonelIlce"("postaKodu") MATCH FULL;


--
-- Name: Personel personelMesaiFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Personel"
    ADD CONSTRAINT "personelMesaiFK" FOREIGN KEY ("mesaiId") REFERENCES public."MesaiSaati"("mesaiId") MATCH FULL;


--
-- Name: Personel personelUnvanFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Personel"
    ADD CONSTRAINT "personelUnvanFK" FOREIGN KEY ("unvanId") REFERENCES public."Unvan"("unvanId") MATCH FULL;


--
-- Name: urun reyonurunFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.urun
    ADD CONSTRAINT "reyonurunFK" FOREIGN KEY (reyonid) REFERENCES public."Reyon"("reyonId") MATCH FULL;


--
-- Name: urun tedarickiurunFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.urun
    ADD CONSTRAINT "tedarickiurunFK" FOREIGN KEY (tedarikciid) REFERENCES public."Tedarikci"("tedarikciId") MATCH FULL;


--
-- Name: MusteriUrun urunmusteriUrunFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MusteriUrun"
    ADD CONSTRAINT "urunmusteriUrunFK" FOREIGN KEY ("urunId") REFERENCES public.urun(urunid) MATCH FULL;


--
-- Name: UrunMarka urunurunMarkaFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UrunMarka"
    ADD CONSTRAINT "urunurunMarkaFK" FOREIGN KEY ("urunId") REFERENCES public.urun(urunid) MATCH FULL;


--
-- PostgreSQL database dump complete
--

