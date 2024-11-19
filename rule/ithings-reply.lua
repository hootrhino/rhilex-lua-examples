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

-- 控制
-- {
--     "method": "control",
--     "msgToken": "token",
--     "params": {
--       "power_switch": 1,
--       "color": 1,
--       "brightness": 66
--     }
-- }
-- 回复
-- {
--     "method":"controlReply",
--     "msgToken":"123",
--     "code":200,
--     "msg":"some message where error"
-- }

Actions = {
    function(args)
        Debug("[====] Received Ithings Command:" .. args);
        local dataT, errJ2T = json:J2T(args);
        if errJ2T ~= nil then
            Throw("json:J2T error:" .. errJ2T);
            return false, args;
        end;
        if dataT.method == "control" then
            Debug("[====] Ithings Send Control CMD:" .. args);
            local errIothub = ithings:CtrlReplySuccess("DEVICEMUNUKCEQ", dataT.msgToken);
            if errIothub ~= nil then
                Throw("ithings:CtrlReplySuccess Error:" .. errIothub);
                return false, args;
            end;
        end;
        if dataT.method == "action" then
            Debug("[====] Ithings Send Control CMD:" .. args);
            local errIothub = ithings:ActionReplySuccess("DEVICEMUNUKCEQ", dataT.msgToken);
            if errIothub ~= nil then
                Throw("ithings:ActionReplySuccess Error:" .. errIothub);
                return false, args;
            end;
        end;
        if dataT.method == "getReport" then
            Debug("[====] Ithings Get Status:" .. args)
            local errIothub = ithings:GetPropertyReply('DEVICE62MJLVLS', {
                --params1
                --params2
                --params...
            })
            if errIothub ~= nil then
                Throw("ithings:PropertyReplySuccess Error:" .. errIothub)
                return false, args
            end
        end
        return true, args;
    end
};
