package k8simagepullpolicy

test_input_good_policy {
	input := {"review": {"object": data.input.good}, "parameters": data.constraints.always.spec.parameters}
	results := violation with input as input
	count(results) == 0
}

test_input_bad_policy {
	input := {"review": {"object": data.input.bad}, "parameters": data.constraints.always.spec.parameters}
	results := violation with input as input
	count(results) == 1
}

test_input_missing_policy {
	input := {"review": {"object": data.input.missing}, "parameters": data.constraints.always.spec.parameters}
	results := violation with input as input
	count(results) == 1
}
