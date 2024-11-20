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
		local json = json:T2J({
			1,
			time:TimeMs(),
			{
				schemaData.ph_1 * 1,
				schemaData.ph_t1 * 1
			},
			{
				schemaData.ph_2 * 1,
				schemaData.ph_t2 * 1
			},
			{
				schemaData.ph_3 * 1,
				schemaData.ph_t3 * 1
			},
			{
				schemaData.ph_4 * 1,
				schemaData.ph_t4 * 1
			}
		});
		local err = data:ToUart("OUTGQWQP9EL", "\r\n" .. json .. "\r\n");
		if err ~= nil then
			Throw(err);
		end;
		return true, args;
	end
}
