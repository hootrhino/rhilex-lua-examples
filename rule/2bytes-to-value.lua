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


Actions = {
    function(args)
        local dataT, err = json:J2T(args)
        if (err ~= nil) then
            Throw('parse json error:' .. err)
            return false, args
        end
        local params = {}
        params[dataT['tag']] = math:TFloat(hex:TwoBytesHOrL(dataT['value'].value['value']), 3)
        local jsonString = json:T2J({
            id = time:TimeMs(),
            method = "thing.event.property.post",
            params = params
        })
        Debug(jsonString)
        return true, args
    end
}
