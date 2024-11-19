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
        Debug("[====] Received Remote Data:" .. args)
        local dataT, errJ2T = json:J2T(args)
        if (errJ2T ~= nil) then
            Throw('json:J2T error:' .. errJ2T)
            return false, args
        end
        if dataT.method == "control" then
            Debug("[====] Ithings Send Control CMD:" .. args)
            if dataT.params.led1 == 0 then
                rhilexg1:Led1Off()
            end
            if dataT.params.led1 == 1 then
                rhilexg1:Led1On()
            end
            if dataT.params.do1 == 1 then
                rhilexg1:DO1Set(1)
            end
            if dataT.params.do1 == 0 then
                rhilexg1:DO1Set(0)
            end
            if dataT.params.do2 == 1 then
                rhilexg1:DO2Set(1)
            end
            if dataT.params.do2 == 0 then
                rhilexg1:DO2Set(0)
            end
            local errIothub = ithings:ActionReplySuccess('OUTSKGLIQJX', dataT.msgToken)
            if errIothub ~= nil then
                Throw("data:ToMqtt Error:" .. errIothub)
                return false, args
            end
        end
        return true, args
    end
}
