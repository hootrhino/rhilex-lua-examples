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
		local conductivity_1 = apure:ParseDOxygen(schemaData.conductivity_1);
		local conductivity_2 = apure:ParseDOxygen(schemaData.conductivity_2);
		local conductivity_3 = apure:ParseDOxygen(schemaData.conductivity_3);
		local conductivity_4 = apure:ParseDOxygen(schemaData.conductivity_4);
		local json = json:T2J({
			3,
			time:TimeMs(),
			{
				conductivity_1 * 1,
				schemaData.con_t1 * 1
			},
			{
				conductivity_2 * 1,
				schemaData.con_t2 * 1
			},
			{
				conductivity_3 * 1,
				schemaData.con_t3 * 1
			},
			{
				conductivity_4 * 1,
				schemaData.con_t4 * 1
			}
		});
		local err = data:ToUart("OUTGQWQP9EL", "\r\n" .. json .. "\r\n");
		if err ~= nil then
			Throw(err);
        end
		return true, args;
	end
};