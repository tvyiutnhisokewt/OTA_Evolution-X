  TODO: this repository will be renamed to `OTA`, and Evolution X builds will mitigate to `evolution` branch. 
  
  LineageOS builds will be uploaded to `lineage` branch.

### JSON structure (Evolution X) ###
```
{
  "response": [
    {
      "maintainer": "Name (nickname)",
      "oem": "OEM",
      "device": "Device Name",
      "filename": "EvolutionX-14.0-<date>-<device codename>-v<evolution_x_version>.zip",
      "download": "https://sourceforge.net/projects/evolution-x/files/<device codename>/14/EvolutionX-14.0-<date>-<device codename>-v<evolution_x_version>.zip/download",
      "timestamp": 0000000000,
      "md5": "abcdefg123456",
      "sha256": "abcdefg123456",
      "size": 123456789,
      "version": "<evolution_x_version>",
      "buildtype": "Testing/Alpha/Beta/Weekly/Monthly",
      "forum": "https://forum link", #(mandatory)
      "firmware": "https://firmware link",
      "paypal": "https://donation link",
      "telegram": "https://telegram link"
    }
  ]
}
```
### JSON structure (LineageOS) ###
```
{
  "response": [
    {
      "maintainer": "Name (nickname)",
      "oem": "OEM",
      "device": "Device Name",
      "filename": "EvolutionX-14.0-<date>-<device codename>-v<evolution_x_version>.zip",
      "download": "https://sourceforge.net/projects/evolution-x/files/<device codename>/14/EvolutionX-14.0-<date>-<device codename>-v<evolution_x_version>.zip/download",
      "timestamp": 0000000000,
      "md5": "abcdefg123456",
      "sha256": "abcdefg123456",
      "size": 123456789,
      "version": "<evolution_x_version>",
      "buildtype": "Testing/Alpha/Beta/Weekly/Monthly",
    }
  ]
}
```
