local function filter(predicate)
	return function(a, b)
		return function()
			for value in a, b do
				if predicate(value) then
					return value
				end
			end
		end
	end
end

return filter
