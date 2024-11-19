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
        local dataT, err0 = json:J2T(args);
        if err0 ~= nil then
            Throw(err0);
            return true, args;
        end;
        local schemaData = {}
        for _, row in ipairs(dataT) do
            schemaData[row.tag] = row.value
        end
        local err1 = rds:Save("SCHEMAZ848ZRDG", {
            temp = schemaData.temp,
            resistivity = schemaData.resistivity,
            conductivity = schemaData.conductivity,
            dissolved_oxygen = schemaData.dissolved_oxygen,
            ph_value = schemaData.ph_value
        });
        if err1 ~= nil then
            Throw(err1);
            return true, args;
        end;
        return true, args;
    end
};
