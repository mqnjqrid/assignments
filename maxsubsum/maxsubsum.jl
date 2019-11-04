# function to find maxsubsum of a given vector of numbers. It returns the maximum sub-sum, the starting and the ending location of the subarray of that sum

function maxsubsum(x)
	n = length(x)
	sum = zero(eltype(x))
	maxsum = zero(eltype(x))
	for i = 1:n
		sum = max(0, sum + x[i])
		maxsum = max(maxsum, sum)
	end
	return maxsum
end