# BHNwave — Community Demo Pack

Welcome! This file gives you ready-to-try passphrases, demo messages, and a step-by-step
walkthrough so you can play with BHNwave in a few minutes. Everything runs **100% offline**
in your browser — no install, no internet, no accounts.

> ⚠️ **These are PUBLIC demo values. Never use them for anything real.**
> Every passphrase below is published here for the whole world to see, which makes them
> worthless as actual security. They exist only so you can test the encrypted mode.
> For real use, make your own strong passphrase (see `secret-generator.html`).
>
> 🎲 And remember: BHNwave is a **fun toy cipher**, not a tool for real account passwords.

---

## Quick start (30 seconds)
1. Open `BHNwave-Sophisticated.html` in your browser (just double-click it).
2. It opens in the **official voice**: Modem Chatter · 33% · Word codebook on.
3. Type something in the Message box and hit **📡 Transmit tones**. You'll hear it.
4. Open the file in a **second tab or second device**, hit **🎙 Start listening**, and
   transmit from the first — watch it decode back to text. That's the whole loop.

---

## Demo messages to try (Direct mode)
These show off the word codebook (common words = fast 3-tone codes) mixed with spelled-out words:

| Try typing… | What's happening |
|-------------|------------------|
| `i want to go home` | every word is in the codebook — all fast word-codes |
| `we will help them find a new way` | pure codebook sentence |
| `the day is good` | the built-in Test Sound sample |
| `meet me at the old dock` | "dock" gets spelled out, the rest are codes |
| `send code seven now` | mix of codes + spelled + a digit |
| `hello my name is robot` | "hello", "name", "robot" spelled; "my", "is" coded |

Tip: words **in** the 197-word codebook (see `BHNwave-SPEC.md`) transmit faster.
Anything else is spelled letter-by-letter — still works, just longer.

---

## Public demo passphrases (Encrypted mode)
Use any of these to test 🔒 Encrypted mode. Both sender and receiver must type the **same** one.

- `bhnwave-community-test`
- `demo-anchor-river-seven`
- `public-sample-do-not-reuse`
- `hello-world-passphrase`
- `try-me-then-make-your-own`

(They're intentionally simple and public. A real passphrase should be long, random, and
secret — generate one with `secret-generator.html` → word-passphrase mode.)

---

## Step-by-step: try DIRECT mode (anyone can decode)
1. Open `BHNwave-Sophisticated.html`.
2. Leave mode on **Direct** and **📖 Word codebook (auto)** checked.
3. Type: `i want to go home`
4. Click **📡 Transmit tones** — you'll hear the modem-chatter beeps.
5. Open the same file in a second tab/device, click **🎙 Start listening**, allow mic access.
6. Transmit again from the first tab while the second listens.
7. The second tab decodes it back to `i want to go home`.
8. (Optional) Click **🔊 Speak result** to hear it read aloud.

## Step-by-step: try ENCRYPTED mode (needs the passphrase)
1. On the **sending** side: switch to **🔒 Encrypted**.
2. In the passphrase box (top-right of Sound Outgoing), enter: `bhnwave-community-test`
3. Type your message, e.g. `meet me at noon`
4. Click **📡 Transmit tones**.
5. On the **receiving** side: also switch to **🔒 Encrypted**, enter the **same** passphrase
   `bhnwave-community-test`, then **🎙 Start listening**.
6. Transmit from the sender. The receiver decodes the tones, then decrypts with the passphrase
   → shows `meet me at noon`.
7. Try it with the **wrong** passphrase on the receiver → it fails / shows gibberish. That's the
   encryption working: the tones are useless without the key.

> Note: encryption uses a random salt + IV each time (proper crypto behavior), so the exact
> tones differ on every transmit even for the same message + passphrase. There is no fixed
> "magic code" to paste — you decode live or from a recording, always with the passphrase.

---

## Tips for a clean decode
- A good mic in a quiet room decodes best.
- The **official voice (Modem · 33%)** balances character and reliability.
- If you want maximum reliability for a tricky message, switch to **Clean Beeps · Plain**.
- The wild profiles (Dune, Klaxon) and high sophistication (66%, 99.99%) sound amazing but
  decode less reliably — great for listening/recording, weaker for clean decode.

Have fun. 🛰️
