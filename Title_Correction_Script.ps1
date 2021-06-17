#ffmpeg and ffprobe is requried for this script to operate.  Please refer to http://ffmpeg.org/ for any questions on these items

#Gets Video Name from file Name (Could be used to set filename from video title with a little rework)
#Set Media Path
$mediaPath = "E:\Video"

#Starts a for loop for all files in a directory.  I currently use MP4 and MKV file formates for all my videos hence the *.m*
$Videos_to_Convert = Get-ChildItem -Path $mediaPath\*.m* -Recurse
foreach ($Video_to_Convert in $Videos_to_Convert) {
    #Gets the file name and the file extension
    $file_extension=[System.IO.Path]::GetExtension($Video_to_Convert)
    $Filename_WO_Extension=[System.IO.Path]::GetFileNameWithoutExtension($Video_to_Convert)
    #Runs ffprobe to find the Title of the video 
    $outputtitle=ffprobe -loglevel quiet -show_entries format_tags=title  $Video_to_Convert -hide_banner -of default=noprint_wrappers=1
    $outputtitle = $outputtitle -replace 'TAG:title=', ''
   #if statetment to determine if the file name is already the title and if not then it sets the name to the title using ffmpeg 
   # you will need to enter your own string value, I am using a equal compartor with wild cards myself.  This will create a new temp
   #video file and then copy over the orginal file.  If you do not want it to copy over the orgianl file then remove the Move-Item line. 
    if ($outputtitle -eq "Enter your string Here") {
            ffmpeg -i $Video_to_Convertd -loglevel quiet -metadata title="$Filename_WO_Extension" -vcodec copy -c:a copy -map 0:0 -map 0:1 -map 0:2 tempoutput"$file_extension"
             Move-Item tempoutput"$file_extension" $Video_to_Convert -Force
    }
}
   