# neekothing
Decompiled source code of the esoteric Russian BYOND game Neekothing.

### DISCLAIMER: Neekothing features edgy humor and scary imagery. This decompilation is for preservation and educational purposes. I do not and have never condoned violence, drug use, or any other obscene behavior. Such content does not comprise the majority of Neekothing; however it is being preserved as-is, to match the author (kotowasiy's) release of the game. Some players may find the "nightmares" in-game to be very disturbing, shocking, and offensive. Play at your own risk.

Neekothing is an obscure Russian BYOND game developed by kotowasiy, a Russian developer associated with hydrated12/"Randy Sandy", the developer of Lifeweb.

To quote koto himself:

"The neekothing is a quazitrash byond game coded from the ground up which is about space occultists, "demons" who call themselves gods (i.e. almost all of the gods), drugs and communists. It is more killy and more funky than SS13 and have loads of occultism and drugs (especially drugs). It shares the same universe with Lifeweb (you probably heard about it). It is somewhat ugly, filled with bad english, does not work on a regular basis and very ACIDIC to the eye, but very (and surprisingly!) interesting and full of features, so many people find it very good."

Game guides can be found here: https://www.reddit.com/r/SS13/comments/5ir205/neekothing_game_guides/

More information at: https://www.reddit.com/r/SS13/comments/5huabv/the_neekothing_game/



It seems to be based on OpenSS13, or perhaps the 2009 Goon SVN or some other early SS13 version.

## The bitperfect branch

This branch is the decompilation exactly as it matches the original. Compiled with BYOND 512.1466, it produces a neek.dmb byte-for-byte identical to kotowasiy’s ‘december neek’ release (md5 92c719f7118bd18fdcb9ee3a7a05c321), so its behavior and functionality are identical to the original game. BYOND 512.1447 through 512.1466 were tested and all produce the identical .dmb; older 512 builds (tested back to 512.1410) and newer ones (512.1467, 512.1468, 512.1474) do not.

Everything is preserved as-is: all bugs, typos, broken features and odd text included. Nothing has been fixed on this branch. For example:
- toxdmg.dm: "мен\green" is koto's "меня", where old BYOND swallowed the "я" (byte 255 in Windows-1251) into a hidden text macro.
- speaker.dm: the eSpeak speaker cannot work on Windows (the program path uses forward slashes, and Russian text is passed in a way that arrives garbled).
- ya.dm: rhtml_decode() never returns its result, and sanitize_simple() stops after its first rule.
- darknet.dm: "var/list/used_markers() = list()" is accepted by BYOND 512 but not by newer versions.

The source files are Windows-1251 (Cyrillic), as in the original; the included VS Code settings open them correctly.

Build it from a fresh clone (or the ZIP download). If you switch to it from another branch in the same folder, refresh the files first: `git rm -r --cached -q . && git reset --hard`

For a version that compiles on BYOND 516, see the main branch.

## About the decompilation

The source was reconstructed from the compiled neek.dmb. Only credits.dm, darknet.dm, serpent_code.dm and snek.dm are koto's original files, exactly as he wrote them (see the html folder, kept as found in the host files). Comments and formatting elsewhere are not original, but the reconstructed source compiles to a neek.dmb byte-for-byte identical to the original, so its behavior and functionality are identical to the original game. The dup0–dup6 folders and zz_types_tail.dm exist because the original had several files with the same name; they reproduce its file layout.

Check Github Releases for the host files, which include koto's .rsc file containing unused and old assets from development which aren't actually referenced by the final .dmb.

Runtimes are logged to runtimez.txt

banned_keys.txt and banned_ids.txt control bans.

changelog.txt is the changelog shown to players upon login.
