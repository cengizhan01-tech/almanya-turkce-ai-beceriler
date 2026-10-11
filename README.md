# Almanya için Türkçe Yapay Zekâ Becerileri (Hermes Agent Skills)

Almanya'da yaşayan Türkçe konuşanlar için hazırlanmış, [Hermes Agent](https://github.com/NousResearch/hermes-agent) ve `SKILL.md` biçimini destekleyen diğer yapay zekâ ajanlarıyla kullanılabilen beceri (skill) koleksiyonu.

> ⚠️ **Sorumluluk reddi:** Bu beceriler bilgilendirme ve yön gösterme amaçlıdır. Hukuki, finansal, vergi veya yatırım danışmanlığı **değildir**. Yasalar, tutarlar ve süreler değişir; her zaman güncel resmi kaynaktan doğrulayın ve gerektiğinde bir uzmana danışın. Kullanımdan doğan sonuçlardan yazar sorumlu değildir.

## Beceriler

| Beceri | Ne işe yarar |
|---|---|
| `hukuk-danismani` | Aile hukuku (velayet, nafaka, soyadı), itiraz süreleri, tüketici hakları, Mahnung/Inkasso, trafik cezası, kira; belge okuma ve ücretsiz/ucuz yardım yolları |
| `yatirim-karar-destegi` | Hisse/ETF/fon/kripto için kurallı puanlama, pozisyon sınırları, satış ve Alman vergi kontrolü, stres testi. Karar kullanıcıda |
| `ekonomi-finans-asistani` | Banka, bütçe, borç, birikim, maaş bordrosu, Minijob, Steuererklärung (yıllık kontrol listesi), sigorta, emeklilik, aile yardımları, ekonomi haberleri |
| `is-arama-asistani` | İlan arama ve puanlama, Lebenslauf/Anschreiben, başvuru takibi, mülakat hazırlığı, maaş pazarlığı, güvenli iş değişimi, Weiterbildung |
| `almanca-resmi-yazisma` | Okul, kurum, sigorta, ev sahibi, işveren ve bankaya resmi Almanca taslak; uydurma/taahhüt yasağı, hak-süre uyarısı, altında Türkçe açıklama |
| `almanya-urun-arastirma` | Türkçe→Almanca ürün terimi, fiyat geçmişi, sahte indirim/mağaza kontrolü, toplam maliyet, karşılaştırma ve zamanlama |

Ortak ilkeler: kişisel veri beceri dosyasına yazılmaz · rakam/kural uydurulmaz, kaynak ve tarih verilir · riskli finansal ürünler (kaldıraç, CFD, borçla yatırım) önerilmez · ajan kullanıcı adına işlem yapmaz, sadece taslak hazırlar.

## Kurulum

**Hermes Agent:** İlgili `skills/<beceri>/SKILL.md` dosyasını Hermes'e (ör. Telegram'dan) gönderip "Bu dosyadaki metinle bu adla bir beceri oluştur" deyin, ya da Hermes'in beceri yönetimi komutlarını kullanın. Becerileri elle `~/.hermes/skills` altına kopyalamak yerine Hermes'in kendi beceri aracını kullanmanız önerilir.

**Diğer ajanlar (Claude Code vb.):** `skills/<beceri>/` klasörünü ajanın beceri klasörüne kopyalayın.

İlk kullanımda her beceri, dosyanın başındaki **KİŞİSELLEŞTİRME** bölümüne göre birkaç kısa soru sorar (hitap, öncelikler, haftalık zaman vb.).

## Katkı ve geri bildirim

Hata bulduysanız veya bir öneriniz varsa [Issue açın](https://github.com/cengizhan01-tech/almanya-turkce-ai-beceriler/issues/new). İlgili becerinin adını, gördüğünüz sonucu ve beklediğiniz sonucu yazın. Kişisel veri, parola veya API anahtarı eklemeyin.

## Lisans

[CC BY 4.0](https://creativecommons.org/licenses/by/4.0/deed.tr) — kaynak göstererek serbestçe kullanabilir, değiştirebilir ve paylaşabilirsiniz.

---

## Deutsch

KI-Skills auf Türkisch für Menschen in Deutschland. Sie helfen bei Fragen zu Behördenbriefen, Jobsuche, Finanzen, Kaufentscheidungen und weiteren Alltagsthemen. Die Skills funktionieren mit Hermes Agent und anderen Agenten, die `SKILL.md` unterstützen. **Keine Rechts-, Steuer- oder Finanzberatung.** Lizenz: CC BY 4.0.

## English

Turkish-language AI skills for people in Germany. They help with official letters, job searches, finances, shopping decisions, and other everyday topics. They work with Hermes Agent and other agents that support `SKILL.md`. **Not legal, tax, or financial advice.** Licensed under CC BY 4.0.
