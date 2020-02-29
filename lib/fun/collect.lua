local function collect(iterator)
	local list = {}

	for value in iterator do
		list[#list + 1] = value
	end

	return list
end

return collect
