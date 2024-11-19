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
-- {
--     "method":"report",
--     "msgToken":"DEVICE62MJLVLS",
--     "timestamp":1677762028638,
--     "params":{
--       "temp":1,
--       "humi":1,
--       "oxygen":32
--     }
-- }


Actions = {
    function(args)
        Debug("[====] Received tciothub Command:" .. args);
        local dataT, errJ2T = json:J2T(args);
        if errJ2T ~= nil then
            Throw("json:J2T error:" .. errJ2T);
            return false, args;
        end;
        if dataT.method == "control" then
            Debug("[====] tciothub Send Control CMD:" .. args);
            local errIothub = tciothub:CtrlReplySuccess("DEVICEMUNUKCEQ", dataT.msgToken);
            if errIothub ~= nil then
                Throw("tciothub:CtrlReplySuccess Error:" .. errIothub);
                return false, args;
            end;
        end;
        if dataT.method == "action" then
            Debug("[====] tciothub Send Control CMD:" .. args);
            local errIothub = tciothub:ActionReplySuccess("DEVICEMUNUKCEQ", dataT.msgToken);
            if errIothub ~= nil then
                Throw("tciothub:ActionReplySuccess Error:" .. errIothub);
                return false, args;
            end;
        end;
        if dataT.method == "get_status" then
            Debug("[====] tciothub Get Status:" .. args)
            local errIothub = tciothub:GetPropertyReply('DEVICE62MJLVLS', {
                key = "value"
            })
            if errIothub ~= nil then
                Throw("ithings:PropertyReplySuccess Error:" .. errIothub)
                return false, args
            end
        end;
        return true, args;
    end
};
