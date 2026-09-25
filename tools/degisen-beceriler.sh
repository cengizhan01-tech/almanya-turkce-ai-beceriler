#!/usr/bin/env bash
# Hermes becerilerinden hangileri yayınlanmış sürümden farklı / yeni?
#   bash tools/degisen-beceriler.sh               → rapor
#   bash tools/degisen-beceriler.sh --isaretle AD → AD becerisinin güncel halini "yayınlandı" olarak kaydet
set -uo pipefail
SKILLS="$HOME/.hermes/skills"
CFG="$HOME/.config/beceri-yayin"
IZLENEN="$CFG/izlenen-beceriler.txt"      # yayınlanan/izlenen Hermes beceri adları
HARIC="$CFG/haric-beceriler.txt"          # asla yayınlanmayacaklar
DURUM="$CFG/yayinlanan.tsv"               # ad <TAB> sha256 <TAB> tarih
mkdir -p "$CFG"; touch "$IZLENEN" "$HARIC" "$DURUM"

bul(){ find "$SKILLS" -iname SKILL.md -path "*/$1/*" 2>/dev/null | head -1; }
temiz(){ grep -v '^\s*#' "$1" | sed 's/\r$//' | sed '/^\s*$/d'; }

if [ "${1:-}" = "--isaretle" ]; then
  ad="${2:?Beceri adı gerekli}"; f="$(bul "$ad")"
  [ -z "$f" ] && { echo "Bulunamadı: $ad"; exit 1; }
  h="$(sha256sum "$f" | cut -d' ' -f1)"
  grep -v -P "^\Q$ad\E\t" "$DURUM" > "$DURUM.tmp" || true; mv "$DURUM.tmp" "$DURUM"
  printf '%s\t%s\t%s\n' "$ad" "$h" "$(date +%F)" >> "$DURUM"
  grep -qxF "$ad" <(temiz "$IZLENEN") || echo "$ad" >> "$IZLENEN"
  echo "✔ $ad yayınlandı olarak işaretlendi ($(date +%F))"; exit 0
fi

echo "== DEĞİŞMİŞ (yayınlanan sürümden farklı) =="
d=0
while read -r ad; do
  f="$(bul "$ad")"; [ -z "$f" ] && { echo "  ? $ad — Hermes'te bulunamadı"; continue; }
  h="$(sha256sum "$f" | cut -d' ' -f1)"
  eski="$(awk -F'\t' -v a="$ad" '$1==a{print $2}' "$DURUM" | tail -1)"
  if [ -z "$eski" ]; then echo "  • $ad — hiç işaretlenmemiş (ilk kayıt gerekli)"; d=1
  elif [ "$h" != "$eski" ]; then echo "  • $ad — değişmiş (son yayın: $(awk -F'\t' -v a="$ad" '$1==a{print $3}' "$DURUM" | tail -1))"; d=1; fi
done < <(temiz "$IZLENEN")
[ "$d" -eq 0 ] && echo "  (yok)"

echo "== YENİ ADAY (son 7 günde oluşturulmuş/değişmiş, listede olmayan) =="
y=0
while read -r f; do
  ad="$(basename "$(dirname "$f")")"
  grep -qixF "$ad" <(temiz "$IZLENEN") && continue
  grep -qixF "$ad" <(temiz "$HARIC") && continue
  echo "  • $ad  ($f)"; y=1
done < <(find "$SKILLS" -iname SKILL.md -mtime -7 2>/dev/null | sort)
[ "$y" -eq 0 ] && echo "  (yok)"
