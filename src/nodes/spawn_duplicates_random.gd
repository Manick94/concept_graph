tool
extends ConceptNode


func _init() -> void:
	unique_id = "duplicate_nodes_random"
	display_name = "Spawn Random Duplicates"
	category = "Nodes/Instancers"
	description = "Spawns multiple copies of a random node at the given positions"

	set_input(0, "Sources", ConceptGraphDataType.NODE)
	set_input(1, "Transforms", ConceptGraphDataType.NODE)
	set_input(2, "Seed", ConceptGraphDataType.SCALAR)
	set_output(0, "Duplicates", ConceptGraphDataType.NODE)


func _generate_output(idx: int) -> Array:
	var sources = get_input(0)
	var transforms = get_input(1)
	var random_seed: int = get_input_single(2, 0)
	var nodes = []

	if not sources or sources.size() == 0 or \
		not transforms or transforms.size() == 0:
		return nodes

	var count = sources.size()
	var rng = RandomNumberGenerator.new()
	rng.set_seed(random_seed)

	for t in transforms:
		var i = rng.randi_range(0, count - 1)
		var n = sources[i].duplicate() as Spatial
		n.global_transform = t.transform
		nodes.append(n)

	return nodes
