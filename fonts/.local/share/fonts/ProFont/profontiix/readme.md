WHAT IS THIS?

This is ProFont TrueType, converted to Windows TrueType format
by Mike Smith, with some tweaks added by "ardu".

Modifications include:
- A Euro character
- Missing characters from the Latin 1 code page
- Full support for CodePage 850. These are mostly the famous
  block/box characters you know from DOS. Very useful if you use
  Mightnight Commander through PuTTY.
- Fixed metrics so that point size of 9 works correctly. Until now
  you had to select 7 to obtain the native point size of 9.
- Added some quick&dirty hinting for point size of 9. Most characters
  now match closely the look of the bitmap version.
  Don't expect it to look good on anything else than Windows...



To get the full original Distribution, other ProFont builds
and more information
go to <http://tobiasjung.name/profont/>


DISCLAIMER
See LICENSE file


Tobias Jung
January 2014
profont@tobiasjung.name

## Which font?

### TL;DR

0. Pick your font family and then select from the `'complete'` directory.
  * Are you on Windows? Pick a font with the suffix `'Windows Compatible'`
  * Are you limited to mono fonts (because of your terminal, etc)? Pick a font with the suffix `'Mono'`

### Explanation

Once you narrow done your font choice of family (`Droid Sans`, `Inconsolata`, etc) and style (`bold`, `italic`, etc) you have 2 main choices:
 * download an already patched font from the `complete` folder
  * This is most likely the one you want. It includes **all** of the glyphs from all of the glyph sets. Only caution here is that some fonts have glyphs in the _same_ code point so to include everything some had to be moved to alternate code points.
 * patch your own variations with the various options provided by the font patcher (see each font's readme for full list of combinations available)
  * This contains a list of _all permutations_ of the various glyphs. E.g. You want the font with only [Octicons][octicons] or you want the font with just [Font Awesome][font-awesome] and [Devicons][vorillaz-devicons]. The goal is to provide every combination possible in this folder.


For more information see: [The FAQ](https://github.com/ryanoasis/nerd-fonts/wiki/FAQ#which-font)


[vim-devicons]:https://github.com/ryanoasis/vim-devicons
[vorillaz-devicons]:http://vorillaz.github.io/devicons/
[font-awesome]:https://github.com/FortAwesome/Font-Awesome
[octicons]:https://github.com/github/octicons
[gabrielelana-pomicons]:https://github.com/gabrielelana/pomicons
[Seti-UI]:https://atom.io/themes/seti-ui
[ryanoasis-powerline-extra-symbols]:https://github.com/ryanoasis/powerline-extra-symbols

## Variations (Combinations)

> The combinations and total number of combinations are provided here for reference if you want to create your own variation of a patched Nerd Font.

### Why aren't all variations included ?

Combinations are no longer included by default because of the large inflation in size it caused the Repository _and_ the amount of time it takes to rebuild all of the combinations. This issue would exponentially get worse as the numbers of Fonts and Glyph Sets provided increase.


```sh
# 510 Possible Combinations:

./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --octicons --fontlinux --pomicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --octicons --fontlinux --pomicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --octicons --fontlinux --pomicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --octicons --fontlinux --pomicons --powerlineextra
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --octicons --fontlinux --pomicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --octicons --fontlinux --pomicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --octicons --fontlinux --pomicons --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --octicons --fontlinux --pomicons
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --octicons --fontlinux --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --octicons --fontlinux --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --octicons --fontlinux --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --octicons --fontlinux --powerlineextra
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --octicons --fontlinux --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --octicons --fontlinux --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --octicons --fontlinux --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --octicons --fontlinux
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --octicons --pomicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --octicons --pomicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --octicons --pomicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --octicons --pomicons --powerlineextra
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --octicons --pomicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --octicons --pomicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --octicons --pomicons --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --octicons --pomicons
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --octicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --octicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --octicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --octicons --powerlineextra
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --octicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --octicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --octicons --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --octicons
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --fontlinux --pomicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --fontlinux --pomicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --fontlinux --pomicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --fontlinux --pomicons --powerlineextra
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --fontlinux --pomicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --fontlinux --pomicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --fontlinux --pomicons --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --fontlinux --pomicons
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --fontlinux --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --fontlinux --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --fontlinux --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --fontlinux --powerlineextra
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --fontlinux --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --fontlinux --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --fontlinux --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --fontlinux
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --pomicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --pomicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --pomicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --pomicons --powerlineextra
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --pomicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --pomicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --pomicons --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --pomicons
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --powerlineextra
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesome
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --octicons --fontlinux --pomicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --octicons --fontlinux --pomicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --octicons --fontlinux --pomicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --octicons --fontlinux --pomicons --powerlineextra
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --octicons --fontlinux --pomicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --octicons --fontlinux --pomicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --octicons --fontlinux --pomicons --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --octicons --fontlinux --pomicons
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --octicons --fontlinux --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --octicons --fontlinux --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --octicons --fontlinux --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --octicons --fontlinux --powerlineextra
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --octicons --fontlinux --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --octicons --fontlinux --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --octicons --fontlinux --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --octicons --fontlinux
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --octicons --pomicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --octicons --pomicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --octicons --pomicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --octicons --pomicons --powerlineextra
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --octicons --pomicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --octicons --pomicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --octicons --pomicons --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --octicons --pomicons
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --octicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --octicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --octicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --octicons --powerlineextra
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --octicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --octicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --octicons --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --octicons
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontlinux --pomicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontlinux --pomicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontlinux --pomicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontlinux --pomicons --powerlineextra
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontlinux --pomicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontlinux --pomicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontlinux --pomicons --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontlinux --pomicons
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontlinux --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontlinux --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontlinux --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontlinux --powerlineextra
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontlinux --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontlinux --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontlinux --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontlinux
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --pomicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --pomicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --pomicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --pomicons --powerlineextra
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --pomicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --pomicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --pomicons --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --pomicons
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --powerlineextra
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --windows
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --octicons --fontlinux --pomicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --octicons --fontlinux --pomicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --octicons --fontlinux --pomicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --octicons --fontlinux --pomicons --powerlineextra
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --octicons --fontlinux --pomicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --octicons --fontlinux --pomicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --octicons --fontlinux --pomicons --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --octicons --fontlinux --pomicons
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --octicons --fontlinux --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --octicons --fontlinux --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --octicons --fontlinux --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --octicons --fontlinux --powerlineextra
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --octicons --fontlinux --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --octicons --fontlinux --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --octicons --fontlinux --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --octicons --fontlinux
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --octicons --pomicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --octicons --pomicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --octicons --pomicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --octicons --pomicons --powerlineextra
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --octicons --pomicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --octicons --pomicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --octicons --pomicons --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --octicons --pomicons
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --octicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --octicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --octicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --octicons --powerlineextra
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --octicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --octicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --octicons --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --octicons
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --fontlinux --pomicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --fontlinux --pomicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --fontlinux --pomicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --fontlinux --pomicons --powerlineextra
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --fontlinux --pomicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --fontlinux --pomicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --fontlinux --pomicons --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --fontlinux --pomicons
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --fontlinux --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --fontlinux --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --fontlinux --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --fontlinux --powerlineextra
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --fontlinux --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --fontlinux --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --fontlinux --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --fontlinux
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --pomicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --pomicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --pomicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --pomicons --powerlineextra
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --pomicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --pomicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --pomicons --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --pomicons
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --powerlineextra
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesome
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --octicons --fontlinux --pomicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --octicons --fontlinux --pomicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --octicons --fontlinux --pomicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --octicons --fontlinux --pomicons --powerlineextra
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --octicons --fontlinux --pomicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --octicons --fontlinux --pomicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --octicons --fontlinux --pomicons --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --octicons --fontlinux --pomicons
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --octicons --fontlinux --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --octicons --fontlinux --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --octicons --fontlinux --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --octicons --fontlinux --powerlineextra
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --octicons --fontlinux --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --octicons --fontlinux --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --octicons --fontlinux --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --octicons --fontlinux
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --octicons --pomicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --octicons --pomicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --octicons --pomicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --octicons --pomicons --powerlineextra
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --octicons --pomicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --octicons --pomicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --octicons --pomicons --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --octicons --pomicons
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --octicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --octicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --octicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --octicons --powerlineextra
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --octicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --octicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --octicons --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --octicons
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontlinux --pomicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontlinux --pomicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontlinux --pomicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontlinux --pomicons --powerlineextra
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontlinux --pomicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontlinux --pomicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontlinux --pomicons --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontlinux --pomicons
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontlinux --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontlinux --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontlinux --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontlinux --powerlineextra
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontlinux --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontlinux --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontlinux --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontlinux
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --pomicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --pomicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --pomicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --pomicons --powerlineextra
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --pomicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --pomicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --pomicons --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --pomicons
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --powerlineextra
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --fontawesomeextension
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs --powersymbols
./font-patcher ProFontIIx.ttf  --use-single-width-glyphs
./font-patcher ProFontIIx.ttf  --windows --fontawesome --octicons --fontlinux --pomicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontawesome --octicons --fontlinux --pomicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --windows --fontawesome --octicons --fontlinux --pomicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontawesome --octicons --fontlinux --pomicons --powerlineextra
./font-patcher ProFontIIx.ttf  --windows --fontawesome --octicons --fontlinux --pomicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontawesome --octicons --fontlinux --pomicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --windows --fontawesome --octicons --fontlinux --pomicons --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontawesome --octicons --fontlinux --pomicons
./font-patcher ProFontIIx.ttf  --windows --fontawesome --octicons --fontlinux --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontawesome --octicons --fontlinux --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --windows --fontawesome --octicons --fontlinux --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontawesome --octicons --fontlinux --powerlineextra
./font-patcher ProFontIIx.ttf  --windows --fontawesome --octicons --fontlinux --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontawesome --octicons --fontlinux --fontawesomeextension
./font-patcher ProFontIIx.ttf  --windows --fontawesome --octicons --fontlinux --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontawesome --octicons --fontlinux
./font-patcher ProFontIIx.ttf  --windows --fontawesome --octicons --pomicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontawesome --octicons --pomicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --windows --fontawesome --octicons --pomicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontawesome --octicons --pomicons --powerlineextra
./font-patcher ProFontIIx.ttf  --windows --fontawesome --octicons --pomicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontawesome --octicons --pomicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --windows --fontawesome --octicons --pomicons --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontawesome --octicons --pomicons
./font-patcher ProFontIIx.ttf  --windows --fontawesome --octicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontawesome --octicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --windows --fontawesome --octicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontawesome --octicons --powerlineextra
./font-patcher ProFontIIx.ttf  --windows --fontawesome --octicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontawesome --octicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --windows --fontawesome --octicons --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontawesome --octicons
./font-patcher ProFontIIx.ttf  --windows --fontawesome --fontlinux --pomicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontawesome --fontlinux --pomicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --windows --fontawesome --fontlinux --pomicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontawesome --fontlinux --pomicons --powerlineextra
./font-patcher ProFontIIx.ttf  --windows --fontawesome --fontlinux --pomicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontawesome --fontlinux --pomicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --windows --fontawesome --fontlinux --pomicons --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontawesome --fontlinux --pomicons
./font-patcher ProFontIIx.ttf  --windows --fontawesome --fontlinux --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontawesome --fontlinux --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --windows --fontawesome --fontlinux --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontawesome --fontlinux --powerlineextra
./font-patcher ProFontIIx.ttf  --windows --fontawesome --fontlinux --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontawesome --fontlinux --fontawesomeextension
./font-patcher ProFontIIx.ttf  --windows --fontawesome --fontlinux --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontawesome --fontlinux
./font-patcher ProFontIIx.ttf  --windows --fontawesome --pomicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontawesome --pomicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --windows --fontawesome --pomicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontawesome --pomicons --powerlineextra
./font-patcher ProFontIIx.ttf  --windows --fontawesome --pomicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontawesome --pomicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --windows --fontawesome --pomicons --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontawesome --pomicons
./font-patcher ProFontIIx.ttf  --windows --fontawesome --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontawesome --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --windows --fontawesome --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontawesome --powerlineextra
./font-patcher ProFontIIx.ttf  --windows --fontawesome --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontawesome --fontawesomeextension
./font-patcher ProFontIIx.ttf  --windows --fontawesome --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontawesome
./font-patcher ProFontIIx.ttf  --windows --octicons --fontlinux --pomicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --windows --octicons --fontlinux --pomicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --windows --octicons --fontlinux --pomicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --windows --octicons --fontlinux --pomicons --powerlineextra
./font-patcher ProFontIIx.ttf  --windows --octicons --fontlinux --pomicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --windows --octicons --fontlinux --pomicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --windows --octicons --fontlinux --pomicons --powersymbols
./font-patcher ProFontIIx.ttf  --windows --octicons --fontlinux --pomicons
./font-patcher ProFontIIx.ttf  --windows --octicons --fontlinux --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --windows --octicons --fontlinux --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --windows --octicons --fontlinux --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --windows --octicons --fontlinux --powerlineextra
./font-patcher ProFontIIx.ttf  --windows --octicons --fontlinux --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --windows --octicons --fontlinux --fontawesomeextension
./font-patcher ProFontIIx.ttf  --windows --octicons --fontlinux --powersymbols
./font-patcher ProFontIIx.ttf  --windows --octicons --fontlinux
./font-patcher ProFontIIx.ttf  --windows --octicons --pomicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --windows --octicons --pomicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --windows --octicons --pomicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --windows --octicons --pomicons --powerlineextra
./font-patcher ProFontIIx.ttf  --windows --octicons --pomicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --windows --octicons --pomicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --windows --octicons --pomicons --powersymbols
./font-patcher ProFontIIx.ttf  --windows --octicons --pomicons
./font-patcher ProFontIIx.ttf  --windows --octicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --windows --octicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --windows --octicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --windows --octicons --powerlineextra
./font-patcher ProFontIIx.ttf  --windows --octicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --windows --octicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --windows --octicons --powersymbols
./font-patcher ProFontIIx.ttf  --windows --octicons
./font-patcher ProFontIIx.ttf  --windows --fontlinux --pomicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontlinux --pomicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --windows --fontlinux --pomicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontlinux --pomicons --powerlineextra
./font-patcher ProFontIIx.ttf  --windows --fontlinux --pomicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontlinux --pomicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --windows --fontlinux --pomicons --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontlinux --pomicons
./font-patcher ProFontIIx.ttf  --windows --fontlinux --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontlinux --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --windows --fontlinux --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontlinux --powerlineextra
./font-patcher ProFontIIx.ttf  --windows --fontlinux --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontlinux --fontawesomeextension
./font-patcher ProFontIIx.ttf  --windows --fontlinux --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontlinux
./font-patcher ProFontIIx.ttf  --windows --pomicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --windows --pomicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --windows --pomicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --windows --pomicons --powerlineextra
./font-patcher ProFontIIx.ttf  --windows --pomicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --windows --pomicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --windows --pomicons --powersymbols
./font-patcher ProFontIIx.ttf  --windows --pomicons
./font-patcher ProFontIIx.ttf  --windows --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --windows --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --windows --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --windows --powerlineextra
./font-patcher ProFontIIx.ttf  --windows --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --windows --fontawesomeextension
./font-patcher ProFontIIx.ttf  --windows --powersymbols
./font-patcher ProFontIIx.ttf  --windows
./font-patcher ProFontIIx.ttf  --fontawesome --octicons --fontlinux --pomicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --fontawesome --octicons --fontlinux --pomicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --fontawesome --octicons --fontlinux --pomicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --fontawesome --octicons --fontlinux --pomicons --powerlineextra
./font-patcher ProFontIIx.ttf  --fontawesome --octicons --fontlinux --pomicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --fontawesome --octicons --fontlinux --pomicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --fontawesome --octicons --fontlinux --pomicons --powersymbols
./font-patcher ProFontIIx.ttf  --fontawesome --octicons --fontlinux --pomicons
./font-patcher ProFontIIx.ttf  --fontawesome --octicons --fontlinux --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --fontawesome --octicons --fontlinux --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --fontawesome --octicons --fontlinux --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --fontawesome --octicons --fontlinux --powerlineextra
./font-patcher ProFontIIx.ttf  --fontawesome --octicons --fontlinux --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --fontawesome --octicons --fontlinux --fontawesomeextension
./font-patcher ProFontIIx.ttf  --fontawesome --octicons --fontlinux --powersymbols
./font-patcher ProFontIIx.ttf  --fontawesome --octicons --fontlinux
./font-patcher ProFontIIx.ttf  --fontawesome --octicons --pomicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --fontawesome --octicons --pomicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --fontawesome --octicons --pomicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --fontawesome --octicons --pomicons --powerlineextra
./font-patcher ProFontIIx.ttf  --fontawesome --octicons --pomicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --fontawesome --octicons --pomicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --fontawesome --octicons --pomicons --powersymbols
./font-patcher ProFontIIx.ttf  --fontawesome --octicons --pomicons
./font-patcher ProFontIIx.ttf  --fontawesome --octicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --fontawesome --octicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --fontawesome --octicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --fontawesome --octicons --powerlineextra
./font-patcher ProFontIIx.ttf  --fontawesome --octicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --fontawesome --octicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --fontawesome --octicons --powersymbols
./font-patcher ProFontIIx.ttf  --fontawesome --octicons
./font-patcher ProFontIIx.ttf  --fontawesome --fontlinux --pomicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --fontawesome --fontlinux --pomicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --fontawesome --fontlinux --pomicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --fontawesome --fontlinux --pomicons --powerlineextra
./font-patcher ProFontIIx.ttf  --fontawesome --fontlinux --pomicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --fontawesome --fontlinux --pomicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --fontawesome --fontlinux --pomicons --powersymbols
./font-patcher ProFontIIx.ttf  --fontawesome --fontlinux --pomicons
./font-patcher ProFontIIx.ttf  --fontawesome --fontlinux --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --fontawesome --fontlinux --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --fontawesome --fontlinux --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --fontawesome --fontlinux --powerlineextra
./font-patcher ProFontIIx.ttf  --fontawesome --fontlinux --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --fontawesome --fontlinux --fontawesomeextension
./font-patcher ProFontIIx.ttf  --fontawesome --fontlinux --powersymbols
./font-patcher ProFontIIx.ttf  --fontawesome --fontlinux
./font-patcher ProFontIIx.ttf  --fontawesome --pomicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --fontawesome --pomicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --fontawesome --pomicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --fontawesome --pomicons --powerlineextra
./font-patcher ProFontIIx.ttf  --fontawesome --pomicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --fontawesome --pomicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --fontawesome --pomicons --powersymbols
./font-patcher ProFontIIx.ttf  --fontawesome --pomicons
./font-patcher ProFontIIx.ttf  --fontawesome --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --fontawesome --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --fontawesome --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --fontawesome --powerlineextra
./font-patcher ProFontIIx.ttf  --fontawesome --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --fontawesome --fontawesomeextension
./font-patcher ProFontIIx.ttf  --fontawesome --powersymbols
./font-patcher ProFontIIx.ttf  --fontawesome
./font-patcher ProFontIIx.ttf  --octicons --fontlinux --pomicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --octicons --fontlinux --pomicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --octicons --fontlinux --pomicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --octicons --fontlinux --pomicons --powerlineextra
./font-patcher ProFontIIx.ttf  --octicons --fontlinux --pomicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --octicons --fontlinux --pomicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --octicons --fontlinux --pomicons --powersymbols
./font-patcher ProFontIIx.ttf  --octicons --fontlinux --pomicons
./font-patcher ProFontIIx.ttf  --octicons --fontlinux --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --octicons --fontlinux --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --octicons --fontlinux --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --octicons --fontlinux --powerlineextra
./font-patcher ProFontIIx.ttf  --octicons --fontlinux --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --octicons --fontlinux --fontawesomeextension
./font-patcher ProFontIIx.ttf  --octicons --fontlinux --powersymbols
./font-patcher ProFontIIx.ttf  --octicons --fontlinux
./font-patcher ProFontIIx.ttf  --octicons --pomicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --octicons --pomicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --octicons --pomicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --octicons --pomicons --powerlineextra
./font-patcher ProFontIIx.ttf  --octicons --pomicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --octicons --pomicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --octicons --pomicons --powersymbols
./font-patcher ProFontIIx.ttf  --octicons --pomicons
./font-patcher ProFontIIx.ttf  --octicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --octicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --octicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --octicons --powerlineextra
./font-patcher ProFontIIx.ttf  --octicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --octicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --octicons --powersymbols
./font-patcher ProFontIIx.ttf  --octicons
./font-patcher ProFontIIx.ttf  --fontlinux --pomicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --fontlinux --pomicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --fontlinux --pomicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --fontlinux --pomicons --powerlineextra
./font-patcher ProFontIIx.ttf  --fontlinux --pomicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --fontlinux --pomicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --fontlinux --pomicons --powersymbols
./font-patcher ProFontIIx.ttf  --fontlinux --pomicons
./font-patcher ProFontIIx.ttf  --fontlinux --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --fontlinux --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --fontlinux --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --fontlinux --powerlineextra
./font-patcher ProFontIIx.ttf  --fontlinux --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --fontlinux --fontawesomeextension
./font-patcher ProFontIIx.ttf  --fontlinux --powersymbols
./font-patcher ProFontIIx.ttf  --fontlinux
./font-patcher ProFontIIx.ttf  --pomicons --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --pomicons --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --pomicons --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --pomicons --powerlineextra
./font-patcher ProFontIIx.ttf  --pomicons --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --pomicons --fontawesomeextension
./font-patcher ProFontIIx.ttf  --pomicons --powersymbols
./font-patcher ProFontIIx.ttf  --pomicons
./font-patcher ProFontIIx.ttf  --powerlineextra --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --powerlineextra --fontawesomeextension
./font-patcher ProFontIIx.ttf  --powerlineextra --powersymbols
./font-patcher ProFontIIx.ttf  --powerlineextra
./font-patcher ProFontIIx.ttf  --fontawesomeextension --powersymbols
./font-patcher ProFontIIx.ttf  --fontawesomeextension
./font-patcher ProFontIIx.ttf  --powersymbols
```