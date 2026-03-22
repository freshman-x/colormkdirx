#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title cdirsX批量改变文件夹颜色V2
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "颜色代码 (r/b/g/y/p/o/oo)" }

# Documentation:
# @raycast.author xxx

on run argv
    set colorValue to item 1 of argv
    
    -- 判断操作类型
    set isReset to false
    if colorValue is "oo" then
        set isReset to true
    end if
    
    -- 验证参数
    if not isReset then
        if colorValue is not in {"r", "b", "g", "y", "p", "o"} then
            display dialog "无效的颜色代码！" & return & "r=红, b=蓝, g=绿, y=黄, p=紫, o=橙, oo=还原" buttons {"确定"} default button "确定"
            return
        end if
    end if
    
    -- 获取 Finder 选中的文件夹
    tell application "Finder"
        set selectedItems to selection
        if (count of selectedItems) = 0 then
            display dialog "请先在 Finder 中选择文件夹" buttons {"确定"} default button "确定"
            return
        end if
        
        -- 收集所有文件夹路径
        set folderPaths to {}
        repeat with i from 1 to count of selectedItems
            set currentItem to item i of selectedItems
            if kind of currentItem is "文件夹" or kind of currentItem contains "Folder" then
                set end of folderPaths to POSIX path of (currentItem as alias)
            end if
        end repeat
        
        if (count of folderPaths) = 0 then
            display dialog "选中的项目中没有文件夹" buttons {"确定"} default button "确定"
            return
        end if
    end tell
    
    -- 构建并执行命令
    set colormkdirxPath to "《你的本地安装位置》"
    set successCount to 0
    set failCount to 0
    set errorLogs to {}
    
    repeat with targetFolder in folderPaths
        try
            if isReset then
                set shellCmd to "\"" & colormkdirxPath & "\" -r " & quoted form of targetFolder
            else
                set shellCmd to "\"" & colormkdirxPath & "\" -c " & colorValue & " " & quoted form of targetFolder
            end if
            do shell script "export PATH=《你的Python环境路径》:$PATH; " & shellCmd
            set successCount to successCount + 1
        on error errMsg
            set failCount to failCount + 1
            set end of errorLogs to "文件夹: " & targetFolder & return & "错误: " & errMsg
        end try
    end repeat
    
    -- 显示结果
    if isReset then
        if failCount = 0 then
            display notification "成功还原 " & successCount & " 个文件夹颜色" with title "完成"
        else
            display notification "成功: " & successCount & ", 失败: " & failCount with title "完成"
        end if
    else
        if failCount = 0 then
            display notification "成功着色 " & successCount & " 个文件夹" with title "完成"
        else
            display notification "成功: " & successCount & ", 失败: " & failCount with title "完成"
        end if
    end if
    
    -- 如果有错误，显示错误日志
    if failCount > 0 then
        set errorText to ""
        repeat with i from 1 to count of errorLogs
            set errorText to errorText & item i of errorLogs & return & return
        end repeat
        display dialog "部分文件夹处理失败:" & return & return & errorText buttons {"确定"} default button "确定"
    end if
end run
