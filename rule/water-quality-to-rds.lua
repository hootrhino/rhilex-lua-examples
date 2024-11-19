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
		local oxygen1 = apure:ParseDOxygen(schemaData.oxygen);
		local oxygen_t1 = apure:ParseDOxygen(schemaData.oxygen_t);
		local conductivity1 = apure:ParseDOxygen(schemaData.conductivity);
		local err = rds:Save("SCHEMAHWHDVT22", {
			oxygen = oxygen1,
			oxygen_t = oxygen_t1,
			conductivity = conductivity1,
			ph = schemaData.ph
		});
		if err ~= nil then
			Throw(err);
			return 0;
		end;
		return true, args;
	end
};