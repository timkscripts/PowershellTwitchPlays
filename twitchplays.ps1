


#######################################################################################
#
#           Script to call AHK scripts
#
#######################################################################################
function ahk($script)
{
    $pipeName = "AHK_" + [System.Environment]::TickCount
    $pipeDir = [System.IO.Pipes.PipeDirection]::Out
    $maxNum = [Int]254
    $pipeTMode = [System.IO.Pipes.PipeTransmissionMode]::Message
    $pipeOptions = [System.IO.Pipes.PipeOptions]::None
    
    $ahkPath = "C:\Users\Babylon\Downloads\AutoHotkey111403_x64\AutoHotkey.exe"
    
    $pipe_ga = new-object System.IO.Pipes.NamedPipeServerStream($pipeName, $pipeDir, $maxNum, $pipeTMode, $pipeOptions)
        
    $pipe = new-object System.IO.Pipes.NamedPipeServerStream($pipeName, $pipeDir, $maxNum, $pipeTMode, $pipeOptions)
    
    if ($pipe_ga -and $pipe) {
        Start-Process $ahkPath "\\.\pipe\$pipeName"
        $pipe_ga.WaitForConnection()
        $pipe_ga.Dispose()
        $pipe.WaitForConnection()
        $script = [char]65279 + $script
        $sw = new-object System.IO.StreamWriter($pipe)
        $sw.Write($script)
            
        $sw.Dispose()
        $pipe.Dispose()
    } else { Write-Host "Operation cancelled: Failed to create named pipe" }
}
#######################################################################################

$code_up = @" 
IfWinExist Snes9X v1.53 for Windows
    WinActivate
    WinWait Snes9X v1.53 for Windows
    SetKeyDelay, 0, 50, Play
    SendPlay a
return
"@
$code_left = @" 
IfWinExist Snes9X v1.53 for Windows
    WinActivate
    WinWait Snes9X v1.53 for Windows
    SetKeyDelay, 0, 50, Play
    SendPlay s
return
"@
$code_down= @" 
IfWinExist Snes9X v1.53 for Windows
    WinActivate
    WinWait Snes9X v1.53 for Windows
    SetKeyDelay, 0, 50, Play
    SendPlay d
return
"@
$code_right = @" 
IfWinExist Snes9X v1.53 for Windows
    WinActivate
    WinWait Snes9X v1.53 for Windows
    SetKeyDelay, 0, 50, Play
    SendPlay f
return
"@
$code_b = @" 
IfWinExist Snes9X v1.53 for Windows
    WinActivate
    WinWait Snes9X v1.53 for Windows
    SetKeyDelay, 0, 50, Play
    SendPlay g
return
"@
$code_a = @" 
IfWinExist Snes9X v1.53 for Windows
    WinActivate
    WinWait Snes9X v1.53 for Windows
    SetKeyDelay, 0, 50, Play
    SendPlay h
return
"@
$code_y = @" 
IfWinExist Snes9X v1.53 for Windows
    WinActivate
    WinWait Snes9X v1.53 for Windows
    SetKeyDelay, 0, 50, Play
    SendPlay j
return
"@
$code_x = @" 
IfWinExist Snes9X v1.53 for Windows
    WinActivate
    WinWait Snes9X v1.53 for Windows
    SetKeyDelay, 0, 50, Play
    SendPlay k
return
"@
$code_start = @" 
IfWinExist Snes9X v1.53 for Windows
    WinActivate
    WinWait Snes9X v1.53 for Windows
    SetKeyDelay, 0, 50, Play
    SendPlay l
return
"@
$code_select = @" 
IfWinExist Snes9X v1.53 for Windows
    WinActivate
    WinWait Snes9X v1.53 for Windows
    SetKeyDelay, 0, 50, Play
    SendPlay x
return
"@
$code_l = @" 
IfWinExist Snes9X v1.53 for Windows
    WinActivate
    WinWait Snes9X v1.53 for Windows
    SetKeyDelay, 0, 50, Play
    SendPlay c
return
"@
$code_r = @" 
IfWinExist Snes9X v1.53 for Windows
    WinActivate
    WinWait Snes9X v1.53 for Windows
    SetKeyDelay, 0, 50, Play
    SendPlay z
return
"@
$oFile = "c:\tmi.twitch.tv.log"
Set-Content $oFile "This is a test" -force
$oFile = "c:\tmi.twitch.tv.log"
$lastKnownString = ""

$timer = 100


do{ 
    $line = get-content $oFile | select -first 1 
    (Get-Content $oFile | Select-Object -Skip 1) | Set-Content $oFile
    if ($lastKnownString -eq $line){

    } else {
        $lastKnownString = $line
        $fields = $line.Split("`t")
        $input = $fields[1].ToLower()

        
        if ($input -eq "up"){
            ahk $code_up
        }
        if ($input -eq "left"){
            ahk $code_left
        }
        if ($input -eq "down"){
            ahk $code_down
        }
        if ($input -eq "right"){
            ahk $code_right
        }
        if ($input -eq "b"){
            ahk $code_b
        }
        if ($input -eq "a"){
            ahk $code_a
        }
        if ($input -eq "y"){
            ahk $code_y
        }
        if ($input -eq "x"){
            ahk $code_x
        }
        if ($input -eq "start"){
            ahk $code_start
        }
        if ($input -eq "select"){
            ahk $code_select
        }
        if ($input -eq "l"){
            ahk $code_l
        }
        if ($input -eq "r"){
            ahk $code_r
        }

        $input
    }
    Start-Sleep -m $timer
} while (1 -eq 1)
