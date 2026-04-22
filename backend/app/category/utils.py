def buildCategoryTree(categories):
  idToCategory = {cat.id: {**cat.__dict__, "children": []} for cat in categories}
  root = []

  for cat in idToCategory.values():
    parentId = cat["parentId"]
    if parentId is None:
      root.append(cat)
    else:
      parent = idToCategory.get(parentId)
      if parent:
        parent["children"].append(cat)

  return root
