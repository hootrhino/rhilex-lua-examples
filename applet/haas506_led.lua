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
        -- LED2
        haas506ld1:Led2On()
        time:Sleep(1000)
        -- LED3
        haas506ld1:Led3On()
        time:Sleep(1000)
        -- LED4
        haas506ld1:Led4On()
        time:Sleep(1000)
        -- LED5
        haas506ld1:Led5On()
        time:Sleep(1000)
        -- LED2
        haas506ld1:Led2Off()
        time:Sleep(1000)
        -- LED3
        haas506ld1:Led3Off()
        time:Sleep(1000)
        -- LED4
        haas506ld1:Led4Off()
        time:Sleep(1000)
        -- LED5
        haas506ld1:Led5Off()
        time:Sleep(1000)
    end
    return 0
end
