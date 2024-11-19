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
        local dataT, err = json:J2T(args);
        if err ~= nil then
            Throw(err);
            return true, args;
        end;
        local schemaData = {};
        for _, row in ipairs(dataT) do
            schemaData[row.tag] = row.value;
        end;
        local jsonString = json:T2J(schemaData)
        local errToGreptimeDB = data:ToGreptimeDB('$UUID', jsonString)
        if errToGreptimeDB ~= nil then
            Throw(errToGreptimeDB)
        end
        return true, args
    end
}
