# TriPeaks NEUE

A simple [Tri Peaks game](https://en.wikipedia.org/wiki/Tri_Peaks_(game)), using Flutter. This is a remake of [my previous implementation](https://github.com/mimoguz/tripeaks-gdx) of the same game.<br>

[Play online](https://mimoguz.github.io/tripeaks_neue/index.html)<br>

<div align="center">
<a href="https://f-droid.org/en/packages/io.github.mimoguz.tripeaksneue/"><img src="https://fdroid.gitlab.io/artwork/badge/get-it-on.png" alt="Get it on F-Droid" height="80"></a>

<a href="https://flathub.org/apps/io.github.mimoguz.tripeaks_neue"> <img width="180" alt="Get it on Flathub" src="https://flathub.org/api/badge?locale=en"/></a>

<a href="https://play.google.com/store/apps/details?id=io.github.mimoguz.tripeaksneue&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1"><img alt="Get it on Google Play" src="https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png" height="80"/></a>

<a href="https://mimoguz.itch.io/tripeaks-neue"> <img height="60" alt="Play on itch.io" src="./.github/readme/itch.io.png"/></a>

<a href="https://buymeacoffee.com/mimoguz"><img src="https://cdn.buymeacoffee.com/buttons/default-yellow.png" alt="Buy Me A Coffee" height="41" width="174"></a>
</div>

## Main Features

- Four board layouts
- An option to show the values of face-down cards
- An option to start with an empty discard pile, allowing the player to choose any starting card
- An option to ensure the created games are solvable (developed by [Lykae](https://github.com/Lykae))
- Aggregated and per-layout statistics
- Portrait and landscape orientation support

## Screenshots
![Portait](./.github/readme/screenshot_portrait_2025-05-03.png)
![Landscape](./.github/readme/screenshot_landscape_2025-05-03.png)

## Credit where credit is due

While it's not a copy, I hope, the game draws a lot of design inspiration from Dustland Design's Solitaire - The Clean One. Credit where credit is due.

## License

This software is available under GNU Affero General Public License (AGPL) Version 3, except:

- _fonts/actions.ttf:_ This file includes symbols derived from Material Icons, and therefore available under Apache License Version 2.0 (same as Material Icons).
- _fonts/Outfit-VariableFont_wght.ttf:_ [Outfit Fonts](https://github.com/Outfitio/Outfit-Fonts) were designed by Smartsheet Inc, Rodrigo Fuenzalida, and available under SIL Open Font License (OFL) Version 1.1.

## DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION issue

If you check the required permissions for this game on F-Droid, you will see that it requires ```DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION```.

The best explanation I could find about this was again in the F-Droid repository:

* A closed merge request: [Don't catalog androidx DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION hack](https://gitlab.com/fdroid/fdroidserver/-/merge_requests/1336) 
* An open issue: [handle androidx DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION hack](https://gitlab.com/fdroid/fdroidclient/-/issues/2608)

**Tl;dr**: As far as I could understand, it's a compatibility hack rather than a true permission. Its existence means that the application uses broadcasts, but only internally and rejects intents coming from outside.

## Bonus Content 🙂

Here is a couple of wallpapers I made when trying to make a banner for Google Play: <a href="https://mimoguz.github.io/files/tri_peaks_wallpapers.zip" download>download zip file</a>

<a href="https://mimoguz.github.io/files/tri_peaks_wallpapers.zip" download><img src="./.github/readme/tripeaks_wallpapers.png" alt="Wallpapers"></img></a>