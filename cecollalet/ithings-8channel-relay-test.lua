-- Copyright (C) 2024 wwhai
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU Affero General Public License as
-- published by the Free Software Foundation, either version 3 of the
-- License, or (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU Affero General Public License for more details.
--
-- You should have received a copy of the GNU Affero General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.

--------------------------------------------------------
-- Go https://www.hootrhino.com for more tutorials    --
--                                                    --
-- ID: CECUDRA92A6                                             --
-- NAME = "ITHINGS_IOTHUB_CEC:139.159.188.223"                                        --
-- DESCRIPTION = "ITHINGS_IOTHUB_CEC:139.159.188.223"                                 --
--------------------------------------------------------

-- 继电器开关组
local keys = {
    sw1 = true,
    sw2 = true,
    sw3 = true,
    sw4 = true,
    sw5 = true,
    sw6 = true,
    sw7 = true,
    sw8 = true,
}
-- 上报属性
function ReportProperties(CecollaId, identifiers)
    -- properties: map[k]=value
    local properties, errGetProperties = ithings:GetProperties(CecollaId, identifiers)
    if errGetProperties ~= nil then
        Throw("ithings:GetProperties Error:" .. errGetProperties)
        return false, args
    end
    local errIothub = ithings:PropertyReport(CecollaId, properties)
    if errIothub ~= nil then
        Throw("ithings:PropertyReport Error:" .. errIothub)
        return false, args
    end
end

function HandleParams(ProductId, DeviceId, Params)
    for key, value in pairs(Params) do
        Debug("[== HandleParams ==] " .. key .. " [== value ==] " .. value)
        if keys[key] == true then
            if value == 0 then
                Debug("[== 关闭开关控制指令下发 ==] " .. key .. " [== value ==] " .. value)
                local err1 = modbus:WritePoint("device-id", {
                    tag = key,
                    value = "0",
                });
                if err1 ~= nil then
                    Throw("modbus:WriteRegister error:" .. err1);
                end
            end
            if value == 1 then
                Debug("[== 打开开关控制指令下发 ==] " .. key .. " [== value ==] " .. value)
                local err1 = modbus:WritePoint("device-id", {
                    tag = key,
                    value = "1",
                });
                if err1 ~= nil then
                    Throw("modbus:WriteRegister error:" .. err1);
                end
            end
        end
    end
end

--
-- Handle Received Action
--
function HandleAction(ActionId, ProductId, DeviceId, Params)
    Debug("[== HandleAction ==] ActionId=" .. ActionId)
    for key, value in pairs(Params) do
        Debug("[== HandleAction ==] " .. key .. " [== value ==] " .. value)
    end
end

--
-- Action Main
--

function Main(CecollaId, Env)
    Debug("[==Debug==] Received Ithings Env.Payload:" .. Env.Payload);
    local dataT, errJ2T = json:J2T(Env.Payload);
    if errJ2T ~= nil then
        Throw("json:J2T error:" .. errJ2T);
        return false, Env.Payload;
    end;
    if dataT.method == "control" then
        Debug("[==Debug==] Ithings Send Control:" .. Env.Payload);
        HandleParams(dataT.params)
        local errIothub = ithings:CtrlReplySuccess(CecollaId, dataT.msgToken);
        if errIothub ~= nil then
            Throw("ithings:CtrlReplySuccess Error:" .. errIothub);
            return false, Env.Payload;
        end;
    end;
    if dataT.method == "action" then
        Debug("[==Debug==] Ithings Send Action:" .. Env.Payload);
        HandleAction(dataT.actionID, dataT.params)
        local errIothub = ithings:ActionReplySuccess(CecollaId, dataT.msgToken);
        if errIothub ~= nil then
            Throw("ithings:ActionReplySuccess Error:" .. errIothub);
            return false, Env.Payload;
        end;
    end;
    if dataT.method == "getReport" then
        Debug("[==Debug==] Ithings Send getReport:" .. Env.Payload);
        ReportProperties(CecollaId, dataT.identifiers)
        local errIothub = ithings:ActionReplySuccess(CecollaId, dataT.msgToken);
        if errIothub ~= nil then
            Throw("ithings:ActionReplySuccess Error:" .. errIothub);
            return false, Env.Payload;
        end;
    end;
end
