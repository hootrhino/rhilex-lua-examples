function Main(args)
    for i = 1, 10, 1 do
        local command = "t1.txt=\"Value=" .. i .. "\"" .. string:Bin2Str({ 0xFF, 0xFF, 0xFF })
        device:CtrlDevice("DEVICECFBVDSSM", "STRING", command)
        time:Sleep(1000)
    end
end
