# Features
  * record.sh is an automatic recording and broadcasting script. Support youtube channel, twitcast channel, twitch channel, openrec channel, niconico live broadcast, niconico community, niconico channel (support logging into niconico account for recording), mirrativ channel, reality channel, 17live channel, chaturbate channel, bilibili channel, streamlink support live URL , M3u8 address supported by ffmpeg. bilibili recording supports no recording when the above channels have live broadcast, so as to simply exclude the retransmission recording; support the use of agents to record bilibili live broadcast. Support timing segmentation. Support rclone upload, onedrive upload (including 21Vianet version), Baidu cloud upload; support a specified number of upload error retry; support to choose whether to keep local files based on upload results.

  
  * install.sh is a one-click installation script. Currently only tested on ubuntu 18.04 and 19.10 systems, in theory, the newer Linux system should be available (centos system should replace apt with yum).


  * record_twitcast.py is optional and is a streamlined script that can record websocket. Because twitcast provides streams based on h5 and websocket, but the highest resolution of some live broadcasts can only be obtained through websocket, and ffmpeg does not support websocket, so we provide a script that can record websocket. Can also be used alone, the method is `python3 record_twitcast.py "ws或wss网址" "输出文件目录"`。  

  * download.sh has nothing to do with the recording function, it is a completely independent small script. The essence is to poll the first page of the live and video page of the youtube channel, generate a youtube video list, and back up the video recording, cover art, title and introduction of the video in the list. Support to try to download the live video immediately after downloading, because there is still a period of time after the live broadcast is complete before the file is deleted, and the download process is not affected by the file deletion once the download starts. Support to set the maximum live broadcast duration of download after triggering off-demand, because the live broadcast that is more than two hours need to wait for the suppression of downloaded video may not be complete. Support to create a new download after waiting for the completion of the compression in the case of downloading the uncompressed video, to ensure that the undeleted video is downloaded to the completion of the compression. Specific usage can be run directly without parameters`./download.sh`. (In addition, since the working status of the script depends entirely on the content of the video list, it may be strange to directly specify or modify the video list)

Thanks to [live-stream-recorder](https://github.com/printempw/live-stream-recorder)、[GiGaFotress/Vtuber-recorder](https://github.com/GiGaFotress/Vtuber-recorder)  

# installation method
### A key installation
`curl https://raw.githubusercontent.com/lovezzzxxx/liverecord/master/install.sh | bash`  
  * The one-click script will automatically install all the following environment dependencies, __and will also cover the installation of the go environment and add some environment variables .__ If necessary, you can comment out the corresponding commands or manually install the environment dependencies. Among them, record.sh and record_twitcast.py will be saved in the record folder of the directory where the command line is at runtime, and livedl will be saved in the livedl folder of the directory where the command line is at runtime.
  * __After one-click script installation, the script should be called `record/record.sh`instead of the example below`./record.sh`__  
  * After the one-click script finishes running, it will prompt operations that still need to be performed manually, such as updating environment variables and logging in to the network disk account

### Environmental dependence
Here is a list of all the programs required for the automatic recording and broadcasting script to run. If the installation of the one-click script fails or you want to manually install the environment, you can refer to
  * Automatic recording script, installation method is`mkdir record ; wget -O "record/record.sh" "https://github.com/lovezzzxxx/liverecord/raw/master/record.sh" ; chmod +x record/record.sh`
  * [ffmpeg](https://github.com/FFmpeg/FFmpeg)，the installation method is `sudo apt install ffmpeg`。Otherwise, parameters other than youtube, twitcast, twitcastpy, nicolv, nicoco, nicoch, bilibili, and bilibiliproxy cannot be used.
  * [streamlink](https://github.com/streamlink/streamlink)(based on python3), the installation method is `pip3 install streamlink`. Otherwise, youtube, youtubeffmpeg, twitch, streamlink, 17live parameters cannot be used.
  * [livedl](https://github.com/himananiito/livedl)(based on go), the specific compilation and installation method can refer to the author's instructions, __please place the compiled livedl file in the livedl / folder of the directory where the command line is located at runtime .__ Otherwise, twitcast, nicolv, nicoco, and nicoch parameters cannot be used.
  * [record_twitcast.py文件](https://github.com/lovezzzxxx/liverecord/blob/master/record_twitcast.py)(based on the python3 websocket library), the installation method is`mkdir record ; wget -O "record/record_twitcast.py" "https://github.com/lovezzzxxx/liverecord/raw/master/record_twitcast.py" ; chmod +x "record/record_twitcast.py"`， __if you install manually, please put the record_twitcast.py file in the record / folder of the directory where the command line is running and give executable permissions__ .Otherwise, the twitcastpy parameter cannot be used.
  * [you-get](https://github.com/soimort/you-get)(based on python3), the installation method is`pip3 install you-get`。. Otherwise, the bilibili and bilibiliproxy parameters cannot be used. 
  * [rclone](https://github.com/rclone/rclone)(supports onedrive, dropbox, googledrive and other network disks, you need to log in to use), the installation method is`curl https://rclone.org/install.sh | sudo bash`, the configuration method is `rclone config`based on the instructions. Otherwise, you cannot upload using rclone parameters.
  * [OneDriveUploader](https://github.com/MoeClub/OneList/tree/master/OneDriveUploader)(supports various OneDrive network drives including 21Vianet version, which needs to be used after login). For installation and login methods, please refer to [Rat's Blog](https://www.moerats.com/archives/1006) . Otherwise, you cannot upload using the onedrive parameter.
  * [BaiduPCS-Go](https://github.com/iikira/BaiduPCS-Go)(give go, support Baidu cloud disk, need to use after login), installation and login method can refer to the author's instructions. Otherwise, you cannot upload using baidupan parameters.

# Instructions
### method
`./record.sh youtube|youtubeffmpeg|twitcast|twitcastffmpeg|twitcastpy|twitch|openrec|nicolv[:用户名,密码]|nicoco[:用户名,密码]|nicoch[:用户名,密码]|mirrativ|reality|17live|chaturbate|bilibili|bilibiliproxy[,代理ip:代理端口]|streamlink|m3u8 频道号码 [best|其他清晰度] [loop|once|视频分段时间] [10,10,1|循环检测间隔,最短录制间隔,录制开始所需连续检测开播次数] [record_video/other|其他本地目录] [nobackup|rclone:网盘名称:|onedrive|baidupan[重试次数][keep|del]] [noexcept|排除转播的youtube频道号码] [noexcept|排除转播的twitcast频道号码] [noexcept|排除转播的twitch频道号码] [noexcept|排除转播的openrec频道号码] [noexcept|排除转播的nicolv频道号码] [noexcept|排除转播的nicoco频道号码] [noexcept|排除转播的nicoch频道号码] [noexcept|排除转播的mirrativ频道号码] [noexcept|排除转播的reality频道号码] [noexcept|排除转播的17live频道号码]  [noexcept|排除转播的chaturbate频道号码] [noexcept|排除转播的streamlink支持的频道网址]`

### Examples
  * Record with default parameters https://www.youtube.com/channel/UCWCc8tO-uUl_7SJXIKJACMw   
`./record.sh youtube "UCWCc8tO-uUl_7SJXIKJACMw"`  

  * Use ffmpeg to record https://www.youtube.com/channel/UCWCc8tO-uUl_7SJXIKJACMw ，get the first available resolution in 1080p 720p 480p 360p worst in turn, and terminate after a live broadcast is detected and a recording is made, with a 30-second interval detection , The video is saved in the record_video / mea folder and is automatically uploaded to the same path of the network disk named vps and Baidu cloud disk in rclone after the recording is completed. If an error occurs, retry up to three times. After the upload is completed, delete the local video , If the upload fails, the local recording will be retained
`./record.sh youtubeffmpeg "UCWCc8tO-uUl_7SJXIKJACMw" 1080p,720p,480p,360p,worst once 30 "record_video/mea" rclone:vps:baidupan3`  

  * Running in the background, using a proxy server 127.0.0.1:1080 to record https://live.bilibili.com/12235923 ，, the highest resolution, loop detection and segmentation at 7200 seconds of recording, 30 seconds interval detection from the beginning to the beginning of each recording The minimum interval is 5 seconds after the end. The video is saved in the record_video / mea folder and is automatically uploaded to the same path as the vps named vps and onedrive and Baidu cloud disk in rclone after the recording is completed. Regardless of whether it is successful or not, the local video will be retained. At https://www.youtube.com/channel/UCWCc8tO-uUl_7SJXIKJACMw https://twitcasting.tv/kaguramea_vov, there will be no recording during live broadcast, and the log record will be saved in the mea_bilibili.log file
`nohup ./record.sh bilibiliproxy,127.0.0.1:1080 "12235923" best 7200 30,5 "record_video/mea_bilibili" rclone:vps:onedrivebaidupan3keep "UCWCc8tO-uUl_7SJXIKJACMw" "kaguramea_vov" > mea_bilibili.log &`  


### Parameter Description

  * Required parameters, select recording method and corresponding channel number

website|The first parameter|The second parameter|Explanation|Precautions
:---|:---|:---|:---|:---
youtube|`youtube`、`youtubeffmpeg`|`个人主页网址中的ID部分`(如UCWCc8tO-uUl_7SJXIKJACMw)|youtubeffmpeg for recording using ffmpeg|Please do not specify the third resolution parameter as best or 1080p60 and above
twitcast|`twitcast`、`twitcastffmpeg`、`twitcastpy`|`个人主页网址中的ID部分`(如kaguramea_vov)|twitcastffmpeg uses ffmpeg for recording, twitcastpy uses record_twitcast.py for recording|If the corresponding dependency is not installed, only the twitcast parameter can be used, and the highest resolution of twitcast cannot be recorded.__Please do not make multiple recordings of the same live broadcast, it will cause file naming problems__
niconico|`nicolv`、`nicoco`、`nicoch`|They are`niconico生放送号码`(eg. lv320447549)，`niconico社区号码`(eg. co41030)，`niconico频道号码`(eg. macoto2525)|Can be added at the back`:用户名,密码`to log in to the nico account for recording (such as nicolv: user@mail.com , password)|If the corresponding dependencies are not installed, niconico cannot be recorded.  __Please do not use the same account for multiple recordings of the same live broadcast, websocket link conflicts may occur, resulting in video freezes or repeated disconnections__
bilibili|`bilibili`、`bilibiliproxy`|`直播间网址中的ID部分`(eg. 12235923)|bilibiliproxy is to record through a proxy, you can directly add a`,代理ip:代理端口`designated proxy server (such as bilibiliproxy, 127.0.0.1:1080), or you can add a proxy acquisition method in the corresponding part of the script
Other sites| `twitch`、`openrec`、`mirrativ`、`reality`、`17live`、`chaturbate`|`个人主页网址中的ID部分`，Where reality is the channel name (if it is a partial name, it matches one of the channels containing these texts) or vlive_id (the acquisition method can be found in the script)|Among them, twitch uses streamlink to detect the live broadcast status, the system occupies a high||
other|`streamlink`、`m3u8`|`streamlink支持的个人主页网址或直播网址`、`直播媒体流的m3u8网址`||

  * Optional parameters, you __need to fill in the middle parameters to specify subsequent parameters__

parameter|Features|Defaults|Other optional values|Explanation
:---|:---|:---|:---|:---
The third parameter|Sharpness|`best`|`清晰度1,清晰度2`，Can be used to specify multiple definitions|Only the resolution contained in streamlink is supported and will be tried in sequence until the first available resolution is obtained
The fourth parameter|Whether to loop and record split time|`loop`|`once`or`分段秒数`|If it is specified as once, it will be terminated after the live broadcast is detected and a recording is made. If it is specified as a number, it will be recorded in loop mode and segmented when the recording is performed for the corresponding number of seconds.  __Note that there may be about ten seconds of video missing during segmentation__
The fifth parameter|Loop detection interval and minimum recording interval and the number of continuous detection starts required for recording start|`10,10,1`|`循环检测间隔秒数,最短录制间隔秒数,录制开始所需连续检测开播次数`, If it is not separated by, the shortest recording interval is also this value and the number of continuous detection starts required for recording start is 1|The loop detection interval means that if no live broadcast is detected, it will wait for the corresponding time for the next detection; the shortest recording interval means that after one recording ends, if the distance from the start of recording is less than the shortest recording interval, the shortest recording interval will be waited for the next detection . The shortest recording interval is mainly to prevent the situation that the live broadcast is detected but the recording is wrong. At this time, once a recording ends, if the next detection is performed immediately, it may be blocked because of too frequent detection or lead to high system occupation. This situation may appear on the website In special periods such as revisions, it should be noted that if a live broadcast time is too short or frequent interruption can also trigger waiting; the continuous detection of the number of start broadcasts required for recording start refers to the need to continuously detect the corresponding number of start broadcasts to start recording, which can be used for Prevent some situations where the live broadcast status is detected but not live broadcasted.
The sixth parameter|Local video storage directory|`record_video/other`|`本地目录`||
The seventh parameter|Whether to automatically backup|`nobackup`|`rclone:网盘名称:` + `onedrive` + `baidupan` + `重试次数` + `无/keep/del`，Directly connect together without spaces (such as rclone1del or rclone: vps: onedrivebaidupan3keep)|The first three items of rclone, onedrive, and baidupan refer to the network drives with the corresponding names uploaded by rclone, the onedrive network drives logged in by OneDriveUploader, and the Baidu cloud network drives logged in by BaiduPCS-Go. The fourth item is the number of retries. If not specified, the default is one try. The fifth item is whether to keep the local file after the upload is completed. If not specified, the local file will be deleted if the upload is successful, and the local file will be kept if the upload fails. The keep parameter is to keep the local file regardless of the result, and the del parameter is to delete the local file regardless of the result. If the recording is started when there is no live broadcast due to the occasional detection abnormality, and then a log file without a corresponding video file is generated, the script will automatically delete the log file without the corresponding video file
Eighth to fourteenth parameters|bilibili recording needs to be excluded from rebroadcast|`noexcept`|`相应频道号码`，The same as the second parameter, the order is youtube, twitcast, twitch, openrec, nicolv, nicoco, nicoch, mirrativ, reality, 17live, chaturbate, streamlink|Only bilibili recording is valid, and bilibili recording is not performed when it is detected that the corresponding channel is being broadcast live
