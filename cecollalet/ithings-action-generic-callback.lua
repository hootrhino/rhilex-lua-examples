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
-- Handle Received Params
--
function HandleParams(Params)
    for key, value in pairs(Params) do
        Debug("[== HandleParams ==] " .. key .. " [== value ==] ", value)
    end
end

--
-- Handle Received Action
--
function HandleAction(ActionId, Params)
    Debug("[== HandleAction ==] ActionId=" .. ActionId)
    for key, value in pairs(Params) do
        Debug("[== HandleAction ==] " .. key .. " [== value ==] ", value)
    end
end

--
-- Action Main
--

function Main(CecollaId, Payload)
    Debug("[==Debug==] Received Ithings Payload:" .. Payload);
    local dataT, errJ2T = json:J2T(Payload);
    if errJ2T ~= nil then
        Throw("json:J2T error:" .. errJ2T);
        return false, Payload;
    end;
    if dataT.method == "control" then
        Debug("[==Debug==] Ithings Send Control:" .. Payload);
        HandleParams(dataT.params)
        local errIothub = ithings:CtrlReplySuccess(CecollaId, dataT.msgToken);
        if errIothub ~= nil then
            Throw("ithings:CtrlReplySuccess Error:" .. errIothub);
            return false, Payload;
        end;
    end;
    if dataT.method == "action" then
        Debug("[==Debug==] Ithings Send Action:" .. Payload);
        HandleAction(dataT.actionID, dataT.params)
        local errIothub = ithings:ActionReplySuccess(CecollaId, dataT.msgToken);
        if errIothub ~= nil then
            Throw("ithings:ActionReplySuccess Error:" .. errIothub);
            return false, Payload;
        end;
    end;
end
