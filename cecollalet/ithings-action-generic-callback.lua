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
-- ID: %s                                             --
-- NAME = "%s"                                        --
-- DESCRIPTION = "%s"                                 --
--------------------------------------------------------

--
-- @CecollaId : Cloud Platform Id
-- Report Properties
-- @identifiers: ["key1", "key2",,]
--
function HandleReportProperties(CecollaId, Token, ProductId, DeviceId, identifiers)
    local errIothub = ithings:GetPropertyReplySuccess(CecollaId, Token, ProductId, DeviceId, identifiers)
    if errIothub ~= nil then
        Throw("上传属性失败，错误信息:", errIothub)
        return false, args
    end
end

--
-- Handle Received Params
--
function HandleParams(ProductId, DeviceId, Params)
    Debug("[== 处理属性 ==] ", "产品=", ProductId, "设备=", DeviceId)
    for key, value in pairs(Params) do
        Debug("[== 处理属性 ==] ", "属性名=", key, "值=", value)
    end
end

--
-- Handle Received Action
--
function HandleAction(ProductId, DeviceId, ActionId, Params)
    Debug("[== 处理行为调用 ==] ", "产品=", ProductId, ", 设备=", DeviceId, ", 行为=", ActionId)
    for key, value in pairs(Params) do
        Debug("[== 处理行为调用 ==]", "属性名=", key, "值=", value)
    end
end

--
-- Action Main
-- @CecollaId : Cloud Platform Id
-- @Env: {
--    "Product" : "ProductId"
--    "Device"  : "DeviceId"
--    "Payload" : "Payload"
-- }
--

function Main(CecollaId, Env)
    Debug("[== Cecolla Debug ==] 收到平台下发指令, CecollaId=", CecollaId, ", Payload=", Env.Payload);
    local dataT, errJ2T = json:J2T(Env.Payload);
    if errJ2T ~= nil then
        Throw("JSON解析失败, 错误信息:", errJ2T);
        return false, Env.Payload;
    end;
    if dataT.method == "control" then
        Debug("[== Cecolla Debug ==] 收到控制指令:", Env.Payload);
        HandleParams(Env.Product, Env.Device, dataT.params)
        local errIothub = ithings:CtrlReplySuccess(CecollaId, dataT.msgToken);
        if errIothub ~= nil then
            Throw("控制指令失败，错误信息:", errIothub);
            return false, Env.Payload;
        end;
    end;
    if dataT.method == "action" then
        Debug("[== Cecolla Debug ==] 收到行为调用指令:", Env.Payload);
        HandleAction(Env.Product, Env.Device, dataT.actionID, dataT.params)
        local errIothub = ithings:ActionReplySuccess(CecollaId, dataT.msgToken);
        if errIothub ~= nil then
            Throw("行为调用失败，错误信息:", errIothub);
            return false, Env.Payload;
        end;
    end;
    if dataT.method == "getReport" then
        Debug("[==Debug==] 收到请求上报数据:", Env.Payload);
        HandleReportProperties(CecollaId, dataT.msgToken, Env.Product, Env.Device, dataT.identifiers)
    end;
end
