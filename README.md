# neekothing
Decompiled source code of the esoteric Russian BYOND game Neekothing.

### DISCLAIMER: Neekothing features edgy humor and scary imagery. This decompilation is for preservation and educational purposes. I do not and have never condoned violence, drug use, or any other obscene behavior. Such content does not comprise the majority of Neekothing; however it is being preserved as-is, to match the author (kotowasiy's) release of the game. Some players may find the "nightmares" in-game to be very disturbing, shocking, and offensive. Play at your own risk.

Neekothing is an obscure Russian BYOND game developed by kotowasiy, a Russian developer associated with hydrated12/"Randy Sandy", the developer of Lifeweb.

To quote koto himself:

"The neekothing is a quazitrash byond game coded from the ground up which is about space occultists, "demons" who call themselves gods (i.e. almost all of the gods), drugs and communists. It is more killy and more funky than SS13 and have loads of occultism and drugs (especially drugs). It shares the same universe with Lifeweb (you probably heard about it). It is somewhat ugly, filled with bad english, does not work on a regular basis and very ACIDIC to the eye, but very (and surprisingly!) interesting and full of features, so many people find it very good."

Game guides can be found here: https://www.reddit.com/r/SS13/comments/5ir205/neekothing_game_guides/

More information at: https://www.reddit.com/r/SS13/comments/5huabv/the_neekothing_game/



It seems to be based on OpenSS13, or perhaps the 2009 Goon SVN or some other early SS13 version.

## Branches

- **main** (this branch): modernized for BYOND 516. Source converted to UTF-8 with all Russian text preserved, the old Windows-1251 text workarounds removed, and small fixes so it compiles on BYOND 516. The speaker (eSpeak) works.
- **bitperfect**: the exact decompilation. Compiled with BYOND 512.1466 it is byte-for-byte identical to kotowasiy’s ‘december neek’ release, with all original bugs and quirks preserved. See that branch's README. Build it from a fresh clone or the ZIP download; if you switch to it from main in the same folder, refresh the files first: `git rm -r --cached -q . && git reset --hard`

## About the decompilation

The source was reconstructed from the compiled neek.dmb. Only credits.dm, darknet.dm, serpent_code.dm and snek.dm are koto's original files, exactly as he wrote them (see the html folder, kept as found in the host files). Comments and formatting elsewhere are not original, but the reconstructed source compiles to a neek.dmb byte-for-byte identical to the original (bitperfect branch), so its behavior and functionality are identical to the original game. The dup0–dup6 folders and zz_types_tail.dm exist because the original had several files with the same name; they reproduce its file layout.

Check Github Releases for the host files, which include koto's .rsc file containing unused and old assets from development which aren't actually referenced by the final .dmb.

## Speaker (eSpeak)

The "speaker" item (speaker.dm) uses eSpeak 1.48 (https://espeak.sourceforge.net/). Copy the whole eSpeak folder, including espeak-data, next to neek.dmb, so it looks like /neekothingfolder/eSpeak/command_line/espeak.exe
Neekothing uses the "en-us" and "ru" eSpeak voices. DreamDaemon must run the game in Trusted mode, or BYOND won't start eSpeak.
In koto's original version the speaker could not work on Windows (wrong path, and Russian text got garbled); main fixes this.

Runtimes are logged to runtimez.txt

banned_keys.txt and banned_ids.txt control bans.

changelog.txt is the changelog shown to players upon login.
