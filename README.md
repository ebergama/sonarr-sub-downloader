# sonarr-sub-downloader
Sonarr custom post processor script for handling subtitle download.

# Summary
This bash script works perfectly as a [Custom Post Processor Script](2) for [Sonarr](1).
Behind the scenes, it uses [subliminal](3) as subtitle downloader engine.

# Prerequisites
- Install the [subliminal plugin](3) 

# How to setup
1. `git clone https://github.com/ebergama/sonarr-sub-downloader.git`
2. Open Sonarr, go to: `<your-sonar-host>:<port>/settings/connect`
3. Click in the '+' => Custom Script
4. Choose a name for your script, recommended: "Subs Downloader"
5. Enable only "On Download"
6. Choose the path in which the script `sub-downloader` has been cloned.
7. The script requires 2 arguments, the first one is the location of the log file and the second one is the language for the subtitles, for example: `/home/pi/sub.log es`
8. How the configuration should look like

![alt example](https://raw.githubusercontent.com/ebergama/sonarr-sub-downloader/master/example/example.png)

[1]: https://github.com/Sonarr/Sonarr
[2]: https://github.com/Sonarr/Sonarr/wiki/Custom-Post-Processing-Scripts
[3]: https://github.com/Diaoul/subliminal
