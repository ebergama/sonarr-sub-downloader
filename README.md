# sonarr-sub-downloader
Sonarr custom post processor script for handling subtitle download.

# Summary
This project contains 2 main bash scripts for handling Sonarr subtitle download after a TV show has been downloaded.

The script [sub-downloader.sh](sub-downloader.sh) works perfectly as a [Custom Post Processor Script](2) for [Sonarr](1).

The script [search-wanted.sh](wanted/search-wanted.sh)` looks for those subtitles that were not found in previous executions of the first one.

Behind the scenes, both scripts uses [subliminal](3) as subtitle downloader engine.

# Prerequisites
- Install the [subliminal plugin](3) 

# How to setup the script in Sonarr
1. `git clone https://github.com/ebergama/sonarr-sub-downloader.git`
2. Open Sonarr, go to: `<your-sonar-host>:<port>/settings/connect`
3. Click in the '+' => Custom Script
4. Choose a name for your script, recommended: "Subs Downloader"
5. Enable only "On Download"
6. Choose the path in which the script `sub-downloader` has been cloned.
7. The script requires 1 argument, a comma-separated language list for the subtitles to download, 
   for example, for download English and Spanish subtitles: `-l es,en`
8. How the configuration should look like

![alt example](https://raw.githubusercontent.com/ebergama/sonarr-sub-downloader/master/example/example.png)

# How to enable the not found searcher to run periodically
- Run [the installation script](wanted/install.sh) 
```bash
./wanted/install.sh
````
- Check that the crontab has been setup correctly
```bash
crontab -l
```

[1]: https://github.com/Sonarr/Sonarr
[2]: https://github.com/Sonarr/Sonarr/wiki/Custom-Post-Processing-Scripts
[3]: https://github.com/Diaoul/subliminal
