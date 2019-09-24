package k8snodefaultnamespace

test_input_good_namespace {
	input := {"review": {"object": data.input.good}, "parameters": data.constraints.defaultns.spec.parameters}
	results := violation with input as input
	count(results) == 0
}

test_input_bad_namespace {
	input := {"review": {"object": data.input.bad}, "parameters": data.constraints.defaultns.spec.parameters}
	results := violation with input as input
	count(results) == 1
}

test_input_missing_namespace {
	input := {"review": {"object": data.input.missing}, "parameters": data.constraints.defaultns.spec.parameters}
	results := violation with input as input
	count(results) == 0
}
