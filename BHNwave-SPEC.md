# BHNwave — Official Specification

A fully-offline, beep-tone cipher language. One self-contained HTML file, no dependencies,
no internet, no tokens. Type a message → encode (direct or encrypted) → transmit as tones →
record/share → decode back to text → optionally speak aloud.

> **For fun / puzzles / shared codes.** A toy cipher — not for real account passwords.
> A recording can be decoded by anyone who has it (and, in encrypted mode, the passphrase).

---

## Official voice
- **Profile:** B · Modem Chatter (fast bursts)
- **Sophistication:** 33% (harmonics + varied length)
- **Word codebook:** Auto (on)

These are the defaults the file opens with.

---

## Runs completely offline
- 100% local in the browser. Zero network, zero tokens, zero cost.
- Uses only built-in browser features: Web Audio (tones), AnalyserNode FFT (decode),
  Web Crypto `crypto.subtle` (encryption), SpeechSynthesis (speak aloud).
- Works with WiFi off. Nothing is sent anywhere.

---

## The letter / character alphabet (37 symbols)
Each symbol = one frequency: `freq = 520 Hz + index × 90 Hz` (range 520–3760 Hz).
Anything not in the word codebook is spelled out using these.

| idx | sym | idx | sym | idx | sym | idx | sym |
|----|-----|----|-----|----|-----|----|-----|
| 0 | (space) | 10 | i | 20 | s | 30 | 3 |
| 1 | a | 11 | j | 21 | t | 31 | 4 |
| 2 | b | 12 | k | 22 | u | 32 | 5 |
| 3 | c | 13 | l | 23 | v | 33 | 6 |
| 4 | d | 14 | m | 24 | w | 34 | 7 |
| 5 | e | 15 | n | 25 | x | 35 | 8 |
| 6 | f | 16 | o | 26 | y | 36 | 9 |
| 7 | g | 17 | p | 27 | z |   |   |
| 8 | h | 18 | q | 28 | 0 |   |   |
| 9 | i*| 19 | r | 29 | 1 |   |   |

(*index 9 is the letter i; index 10 is also "i" in the raw list — the alphabet is
" abcdefghijklmnopqrstuvwxyz0123456789", space + a–z + 0–9.)

### Frequency markers (outside / around the data band)
- **START** marker: 400 Hz
- **END** marker: 3950 Hz
- **WORD_MARKER** (a 3-tone word code follows): 4250 Hz
- **Klaxon alarm framing** (Klaxon profile only): 120–180 Hz, ignored by the decoder

---

## The word codebook (197 words, 3-tone codes)
A listed word transmits as: **WORD_MARKER + two index tones** (base-37 digits → index = d1×37 + d2).
Words NOT in this list are spelled out character-by-character. The encoder auto-detects per word.
Order = index; transmitter and receiver must use this exact list (it's hardcoded in the file).

**Pronouns (0–19):**
i, you, he, she, it, we, they, me, him, her, us, them, my, your, his, our, their, this, that, who

**Verbs (20–64):**
be, is, am, are, was, were, have, has, had, do, does, did, will, would, can, could, should, go, get,
make, know, think, take, see, come, want, use, find, give, tell, work, call, try, ask, need, feel,
become, leave, put, mean, keep, let, begin, seem, help

**Nouns (65–99):**
time, year, people, way, day, man, woman, thing, child, world, life, hand, part, eye, place, week,
point, home, water, room, mother, area, money, story, fact, month, lot, study, book, word, business,
side, kind

**Adjectives (100–124):**
good, new, first, last, long, great, little, own, other, old, right, big, high, different, small,
large, next, early, young, important, few, public, bad, same, able

**Prepositions / conjunctions (125–154):**
the, a, an, and, or, but, if, of, at, by, for, with, about, against, between, into, through, during,
before, after, to, from, in, out, on, off, over, under, again, then

**Adverbs / connectives (155–179):**
not, no, yes, all, also, very, just, more, most, some, any, only, now, well, even, back, there, here,
when, where, why, how, so, up, down

**Question / determiner words (180–189):**
what, which, whose, whom, each, every, both, many, much, such

**Numbers / quantity (190–196):**
one, two, three, four, five, ten, hundred, second, half

Max addressable with 2 index tones: 37 × 37 = 1369 words (so there's room to grow to ~1369).

---

## How encryption works (🔒 Encrypted mode)
1. You provide a message + a **passphrase** (a shared secret you choose).
2. Browser runs **PBKDF2** (SHA-256, 120,000 iterations, random salt) → derives a 256-bit key.
3. **AES-GCM** encrypts the message (random IV).
4. salt + IV + ciphertext → encoded into the a–v0–5 tone alphabet → transmitted as tones.
5. To read: decode the tones, enter the **same passphrase**, AES-GCM decrypts. Wrong passphrase = fails.

All of this runs locally via the browser's Web Crypto API. No keys or data ever leave the machine.

### Where does the passphrase come from?
- **You choose it.** It's a shared secret between sender and receiver — like a password you both know.
- It is NOT issued by the app. Both ends must agree on it in advance, shared through some other
  channel (in person, etc.) — never sent as BHNwave tones (that would defeat the purpose).
- For a strong one, use the companion generators (Generate-Secret.ps1 / secret-generator.html),
  word-passphrase mode, e.g. "harbor-glacier-tunnel-mantis-velvet".
- Security is only as good as the passphrase. Weak phrase = weak protection.

### Honest limitation
Even with real AES, BHNwave is a toy. Playing encrypted tones aloud broadcasts ciphertext into the
open, where it can be recorded and attacked offline. Fine for puzzles and shared fun — never for
credentials that actually protect something.

---

## Files
- `BHNwave.html` — the reliable workhorse (5 profiles + direct/encrypted).
- `BHNwave-Sophisticated.html` — adds sophistication tiers (Plain/33/66/99.99), Klaxon profile,
  and the 197-word auto-mixed codebook. Official voice defaults baked in.

## Reliability note
Clean Beeps + Plain decodes most reliably. The official voice (Modem Chatter + 33% + word codebook)
is a balance of character and reliability. Moody profiles (Dune, Klaxon) + high sophistication +
word-mode are the least reliable to decode — great for listening, test decode on cleaner settings.
