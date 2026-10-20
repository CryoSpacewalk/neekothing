# neekothing
Decompiled source code of the esoteric Russian BYOND game Neekothing.

### DISCLAIMER: Neekothing features edgy humor and scary imagery. This decompilation is for preservation and educational purposes. I do not and have never condoned violence, drug use, or any other obscene behavior. Such content does not comprise the majority of Neekothing; however it is being preserved as-is, to match the author (kotowasiy's) release of the game. Some players may find the "nightmares" in-game to be very disturbing, shocking, and offensive. Play at your own risk.

Neekothing is an obscure Russian BYOND game developed by kotowasiy, a Russian developer associated with hydrated12/"Randy Sandy", the developer of Lifeweb.

To quote koto himself:

"The neekothing is a quazitrash byond game coded from the ground up which is about space occultists, "demons" who call themselves gods (i.e. almost all of the gods), drugs and communists. It is more killy and more funky than SS13 and have loads of occultism and drugs (especially drugs). It shares the same universe with Lifeweb (you probably heard about it). It is somewhat ugly, filled with bad english, does not work on a regular basis and very ACIDIC to the eye, but very (and surprisingly!) interesting and full of features, so many people find it very good."

Game guides can be found here: https://www.reddit.com/r/SS13/comments/5ir205/neekothing_game_guides/

More information at: https://www.reddit.com/r/SS13/comments/5huabv/the_neekothing_game/



It seems to be based on OpenSS13, or perhaps the 2009 Goon SVN or some other early SS13 version.

The bitperfect branch, compiled with BYOND 512.1466, produces a neek.dmb byte-for-byte identical to kotowasiy’s ‘december neek’ release. BYOND 512.1447 through 512.1466 were tested and all produce the identical .dmb; older 512 builds (tested back to 512.1410) and newer ones (512.1467, 512.1468, 512.1474) do not.

Check Github Releases for the host files, which include koto's .rsc file containing unused and old assets from development which aren't actually referenced by the final .dmb.

To use the "speaker" item (speaker.dm) you need the program eSpeak in the root folder. You can download it from https://espeak.sourceforge.net/, then copy the program files in. Should look like /neekothingfolder/eSpeak/command_line/espeak.exe
Neekothing uses the "en-us" and "ru" eSpeak voices.

Runtimes are logged to runtimez.txt

banned_keys.txt and banned_ids.txt control bans.

changelog.txt is the changelog shown to players upon login.

