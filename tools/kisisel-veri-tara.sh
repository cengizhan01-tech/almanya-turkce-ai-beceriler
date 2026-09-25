#!/usr/bin/env bash
# Kişisel veri tarayıcı — yayından önce çalıştırılır.
# 1) Özel yasaklı kelime listesi (depoda DEĞİL): ~/.config/beceri-yayin/yasakli-kelimeler.txt
# 2) Genel kalıplar: e-posta, telefon, IBAN, özel IP adresleri
# Çıkış kodu: 0 = temiz, 1 = bulgu var / liste yok
set -uo pipefail
KOK="$(cd "$(dirname "$0")/.." && pwd)"
LISTE="$HOME/.config/beceri-yayin/yasakli-kelimeler.txt"
IZIN="$HOME/.config/beceri-yayin/izinli-ifadeler.txt"   # ör. GitHub kullanıcı adı
hata=0
ara(){ grep -rnI --exclude-dir=.git --exclude-dir=tools "$@" "$KOK" 2>/dev/null | { if [ -f "$IZIN" ]; then grep -vF -f <(grep -v '^\s*#' "$IZIN" | sed '/^\s*$/d') || true; else cat; fi; }; }

if [ -f "$LISTE" ]; then
  n=0
  while IFS= read -r k || [ -n "$k" ]; do
    k="${k%$'\r'}"; [ -z "${k// }" ] && continue; [[ "$k" == \#* ]] && continue
    n=$((n+1))
    sonuc="$(ara -iF -- "$k")"
    if [ -n "$sonuc" ]; then echo "✖ Yasaklı ifade #$n bulundu (ifadenin kendisi gizlendi):"; echo "$sonuc" | cut -d: -f1,2 | sed 's/^/   /'; hata=1; fi
  done < "$LISTE"
  echo "• Yasaklı liste: $n ifade kontrol edildi"
else
  echo "✖ Yasaklı kelime listesi yok: $LISTE"; hata=1
fi

kontrol(){ # $1 = açıklama, $2 = regex
  local s; s="$(ara -E -- "$2")"
  if [ -n "$s" ]; then echo "✖ $1:"; echo "$s" | sed 's/^/   /' | cut -c1-200; hata=1; else echo "✔ $1 yok"; fi
}
kontrol "E-posta adresi" '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}'
kontrol "Alman cep telefonu" '(\+49|0049|\b0)[ ]?1[5-7][0-9][ /-]?[0-9]{6,9}\b'
kontrol "IBAN" '\b[A-Z]{2}[0-9]{2}[ ]?([0-9A-Z]{4}[ ]?){3,7}[0-9A-Z]{1,4}\b'
kontrol "Tailscale IP (100.64-127.x.x)" '\b100\.(6[4-9]|[7-9][0-9]|1[01][0-9]|12[0-7])\.[0-9]{1,3}\.[0-9]{1,3}\b'
kontrol "Ev ağı IP (192.168.x.x)" '\b192\.168\.[0-9]{1,3}\.[0-9]{1,3}\b'
kontrol "Tailscale ağ adı (ts.net)" '[a-z0-9-]+\.ts\.net'

echo
if [ "$hata" -eq 0 ]; then echo "✅ TEMİZ — yayına uygun"; else echo "⛔ YAYINA UYGUN DEĞİL — yukarıdaki bulguları düzelt"; fi
exit "$hata"
