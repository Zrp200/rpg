def sum_arr(arr1, arr2)
	summed_arr = [0, 0]
	arr1.each_with_index { |el, idx| summed_arr[idx] += el }
	arr2.each_with_index { |el, idx| summed_arr[idx] += el }
	summed_arr
end