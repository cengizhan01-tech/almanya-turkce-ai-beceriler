# Yayın Atölyesi — Claude Code çalışma kuralları

Bu depo, Hermes Agent'ta kullanılan becerilerin **anonimleştirilmiş, herkese açık** sürümlerini içerir.
Sen (Claude Code) bu deponun bakımcısısın. Kullanıcı sana doğal dille ne istediğini söyler; aşağıdaki SOP'yi uygularsın.

## KESİN KURALLAR (asla çiğneme)
1. **Onay olmadan commit/push YOK.** Her yayından önce özet + `git diff --stat` göster ve kullanıcının açıkça "onaylıyorum" / "yayınla" demesini bekle.
2. `git push --force`, geçmişi değiştirme (rebase, reset --hard, amend sonrası push), branch silme YASAK.
3. Hermes'in kendi dosyalarını (`~/.hermes/**`) **sadece oku**, asla değiştirme. `.env`, `auth.json`, `*.db` dosyalarını okuma.
4. `tools/kisisel-veri-tara.sh` taraması **temiz geçmeden** commit yapma. Tarayıcı bir şey bulursa dur, kullanıcıya göster.
5. Özel yasaklı kelime listesini (`~/.config/beceri-yayin/yasakli-kelimeler.txt`) asla depoya kopyalama, içeriğini ekrana yazdırma veya commit mesajına koyma.
6. Lisansı bilinmeyen üçüncü taraf içeriği (başka birinin yazdığı beceri bölümleri) yayınlama. Emin değilsen sor.
7. Sadece şu yollara dosya ekle/değiştir: `skills/`, `README.md`, `LICENSE`, `CLAUDE.md`, `.claude/`, `tools/`.

## YAYINLANMAYACAK BECERİLER
`kia-ceed-asistani`, `kisisel-baglam` ve adında/içeriğinde tamamen kişisel bilgi taşıyan her beceri. Yeni bir beceri kişisel görünüyorsa sor.

## İSİM EŞLEMESİ (Hermes adı → yayın adı)
| Hermes | Yayın |
|---|---|
| German | almanca-resmi-yazisma |
| (diğerleri) | aynı ad, küçük harf, Türkçe karakter yok, kelimeler `-` ile |

## SOP — Bir beceriyi yayınlama / güncelleme
1. **Kaynağı bul:** `find ~/.hermes/skills -iname SKILL.md -path "*<ad>*"`. Birden fazla eşleşme varsa kullanıcıya sor.
2. **Oku ve analiz et:** Nelerin kişisel olduğunu listele (isimler, aile, adres, işveren, gelir/bakiye/rakamlar, sağlık, sunucu adı/IP, özel dosya yolları, kişisel sigorta/broker durumu).
3. **Dönüştür** (`skills/<yayın-adı>/SKILL.md`):
   - Frontmatter: `name`, `description` (Türkçe, ne işe yaradığını anlatan 1–2 cümle), `license: CC-BY-4.0`
   - Başa sorumluluk reddi: `> ⚠️ ... danışmanlık değildir ... resmi kaynaktan doğrulayın.` (konuya uygun)
   - İlk başlığın hemen altına **KİŞİSELLEŞTİRME** bölümü: hitap, öncelik sırası, haftalık zaman bütçesi, konuya özel kişisel durum — "dosyaya yazılmaz, profil/bellekten okunur veya sorulur".
   - Kişisel ifadeleri genelleştir ("oğlum X" → "kullanıcının çocuğu").
   - Kuruluma özel şeyleri genelleştir: model adları (Sol, Terra vb.) → "daha güçlü model (varsa)"; özel betik/cron/servis adları → "kurulumda varsa ... aracı"; Telegram → "mesajlaşma kanalı (ör. Telegram)"; Paperless vb. → "belge arşivi (varsa)".
   - Diğer becerilere atıfları **isim eşlemesine** göre düzelt; yayınlanmayan becerilere atıf varsa "varsa ... becerisi" yap.
   - Açıkça yanlış veya güncelliği şüpheli olgu görürsen düzelt ya da "güncel kaynaktan doğrula" ekle; kullanıcıya listele.
4. **Tara:** `bash tools/kisisel-veri-tara.sh` → temiz olmalı.
5. **README tablosunu güncelle** (yeni beceriyse satır ekle; açıklama 1 satır).
6. **Kullanıcıya rapor:** yapılan anonimleştirmeler (madde madde), düzeltilen olgular, tarama sonucu, `git diff --stat`. **Onay bekle.**
7. Onay gelince: `git add` (sadece izinli yollar) → `git commit -m "<beceri>: <kısa açıklama>"` → `git push`.
8. Kaydet: `bash tools/degisen-beceriler.sh --isaretle <hermes-adı>` (yayınlanan sürümün parmak izini saklar).
9. Son olarak GitHub'daki dosyanın yerel kopyayla aynı olduğunu doğrula: `git status` temiz ve `git log origin/main -1` son commit.

## SOP — Haftalık kontrol
1. `bash tools/degisen-beceriler.sh` çalıştır → "DEĞİŞMİŞ" ve "YENİ ADAY" listelerini göster.
2. Her biri için 1 satır öneri: yayınla / bekle / kişisel (yayınlanmaz) ve nedeni.
3. Kullanıcı hangilerini seçerse her biri için yukarıdaki yayın SOP'sini uygula; hepsini tek raporda topla, tek onayla yayınla.
4. Hiçbir şey yoksa: "Bu hafta yayınlanacak değişiklik yok" de ve bitir.

## ÜSLUP
Türkçe, sade, adım adım. Kullanıcı teknik terimleri bilmek zorunda değil; ne yaptığını kısa açıkla.
