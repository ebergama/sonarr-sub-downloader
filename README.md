# sonarr-sub-downloader
Sonarr custom post processor script for handling subtitle download.

# Summary
This project contains 2 main bash scripts for handling Sonarr subtitle download after a TV show has been downloaded.

The script [sub-downloader.sh](sub-downloader.sh) works perfectly as a [Custom Post Processor Script](2) for [Sonarr](1).

The script [search-wanted.sh](wanted/search-wanted.sh)` looks for those subtitles that were not found in previous executions of the first one.

Behind the scenes, both scripts uses [subliminal](3) as subtitle downloader engine.

# Prerequisites
- Install the [subliminal plugin][3]
   - I **highly** recommend follow the author steps for install subliminal, but you can execute:
   ```bash
   sudo pip install -U subliminal
   ```

# How to setup the script in Sonarr
1. Download the [latest][4] release (zip or tar.gz) file.
2. Uncompress the file

         unzip sonarr-sub-downloader-0.1.zip
         # or
         tar -xvf sonarr-sub-downloader-0.1.tar.gz
3. Open Sonarr, go to: `<your-sonar-host>:<port>/settings/connect`
4. Click in the '+' => Custom Script
5. Choose a name for your script, recommended: "Subs Downloader"
6. Enable only "On Download"
7. Choose the path in which the script `sub-downloader` has been cloned.
8. The script requires 1 argument, a comma-separated language list for the subtitles to download, 
   for example, for download English and Spanish subtitles: `-l es,en`
9. How the configuration should look like

![alt example](https://raw.githubusercontent.com/ebergama/sonarr-sub-downloader/master/example/example.png)

# How to enable the not found searcher to run periodically
1. Run [the installation script](wanted/install.sh) 
         
         ./wanted/install.sh
2. Check that the crontab has been setup correctly

         crontab -l


[1]: https://github.com/Sonarr/Sonarr
[2]: https://github.com/Sonarr/Sonarr/wiki/Custom-Post-Processing-Scripts
[3]: https://github.com/Diaoul/subliminal
[4]: https://github.com/ebergama/sonarr-sub-downloader/releases/latest
