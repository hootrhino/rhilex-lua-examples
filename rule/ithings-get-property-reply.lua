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
--     "method": "action",
--     "clientToken": "v2530389123MqUdx::3602dfed-c3f8-4d53-804a-7365ba4e8c1f",
--     "actionId": "action",
--     "timestamp": 1727166317,
--     "params": {
--         "a1": 1
--     }
-- }

Actions = {
    function(args)
        Debug("[====] Received Remote Data:" .. args)
        local dataT, errJ2T = json:J2T(args)
        if (errJ2T ~= nil) then
            Throw('json:J2T error:' .. errJ2T)
            return false, args
        end
        if dataT.method == "getReport" then
            Debug("[====] Ithings Get Status:" .. args)
            local errIothub = ithings:GetPropertyReply('DEVICE62MJLVLS', {
                key = "value"
            })
            if errIothub ~= nil then
                Throw("ithings:PropertyReplySuccess Error:" .. errIothub)
                return false, args
            end
        end
        return true, args
    end
}
