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
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
--
-- APPID: APPEAJ3L2DP
--
AppNAME = "a1"
AppVERSION = "1.0.0"
AppDESCRIPTION = ""
--
-- Main
--
function Main(arg)
    local time1 = require("time1")
    local time2 = require("time2")
    for key, value in pairs(_G) do
        print(key, value)
    end
    Debug("Time1:" .. time1:Time())
    Debug("Time2:" .. time2:Time())
    return 0
end
