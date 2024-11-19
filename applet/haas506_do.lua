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

function Main(arg)
    while true do
        -- DO1
        haas506ld1:DO1On()
        time:Sleep(1000)
        -- DO2
        haas506ld1:DO2On()
        time:Sleep(1000)
        -- DO3
        haas506ld1:DO3On()
        time:Sleep(1000)
        -- DO4
        haas506ld1:DO4On()
        time:Sleep(1000)
        -- DO1
        haas506ld1:DO1Off()
        time:Sleep(1000)
        -- DO2
        haas506ld1:DO2Off()
        time:Sleep(1000)
        -- DO3
        haas506ld1:DO3Off()
        time:Sleep(1000)
        -- DO4
        haas506ld1:DO4Off()
        time:Sleep(1000)
    end
    return 0
end
