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
        modbus_slaver:F5("${UUID}", 1, 0)
        modbus_slaver:F5("${UUID}", 1, 1)
        modbus_slaver:F5("${UUID}", 1, "0")
        modbus_slaver:F5("${UUID}", 1, "1")
        modbus_slaver:F6("${UUID}", 1, 0xABCD)
        modbus_slaver:F6("${UUID}", 1, "ABCD")
        return true, args
    end
}
