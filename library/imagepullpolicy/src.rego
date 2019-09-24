package k8simagepullpolicy

# has_field returns whether an object has a field
has_field(object, field) {
	object[field]
}

# False is a tricky special case, as false responses would create an undefined document unless
# they are explicitly tested for
has_field(object, field) {
	object[field] == false
}

has_field(object, field) = false {
	not object[field]
	not object[field] == false
}

get_default(object, field, _default) = output {
	has_field(object, field)
	output = object[field]
}

get_default(object, field, _default) = output {
	has_field(object, field) == false
	output = _default
}

violation[{"msg": msg, "details": {"image_pull_policy": image_pull_policy}}] {
	container := input.review.object.spec.template.spec.containers[_]
	provided := get_default(container, "imagePullPolicy", "")
	required := input.parameters.policy
	required != provided
	msg := sprintf("imagePullPolicy should be %v", [required])
	image_pull_policy := provided
}
