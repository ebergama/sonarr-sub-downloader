# sonarr-sub-downloader
Sonarr custom post processor script for handling subtitle download.

# Summary
This bash script works perfectly as a [Custom Post Processor Script][2] for [Sonarr][1].
Behind the scenes, it uses [subliminal][3] as subtitle downloader engine.

# Prerequisites
- Install the [subliminal plugin][3]
   - I **highly** recommend follow the author steps for install subliminal, but you can execute:
   ```bash
   sudo pip install -U subliminal
   ```

# How to setup
1. Download the [latest][4] release (zip or tar.gz) file.
2. Uncompress the file
```bash
unzip sonarr-sub-downloader-0.1.zip
# or
tar -xvf sonarr-sub-downloader-0.1.tar.gz
```
3. Open Sonarr, go to: `<your-sonar-host>:<port>/settings/connect`
4. Click in the '+' => Custom Script
5. Choose a name for your script, recommended: "Subs Downloader"
6. Enable only "On Download"
7. Choose the path in which the script `sub-downloader` has been cloned.
8. The script requires 1 argument, a comma-separated language list for the subtitles to download, 
   for example, for download English and Spanish subtitles: `-l es,en`
9. How the configuration should look like

![alt example](https://raw.githubusercontent.com/ebergama/sonarr-sub-downloader/master/example/example.png)

[1]: https://github.com/Sonarr/Sonarr
[2]: https://github.com/Sonarr/Sonarr/wiki/Custom-Post-Processing-Scripts
[3]: https://github.com/Diaoul/subliminal
[4]: https://github.com/ebergama/sonarr-sub-downloader/releases/latest
