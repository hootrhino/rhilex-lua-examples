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
        local errIothub = ithings:PropertyReport('DEVICE62MJLVLS', {
            temp = 12.45,
            humi = 45.6,
            oxygen = 23.1
        })
        if errIothub ~= nil then
            Throw("ithings:PropertyReport Error:" .. errIothub)
            return false, args
        end
        return true, args
    end
}
