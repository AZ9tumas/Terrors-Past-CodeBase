local dinosaur = {}

export type DinosaurObject = {
    Predecessors : {[number] : DinosaurObject},
    Name : string,
    BranchPriority : number,
    Successors : {[number] : DinosaurObject},
    Index : number
}

-- Branch Priorities

dinosaur.HEAD_DINOSAUR = 1
dinosaur.NORMAL_DINOSAUR = 2

function dinosaur.New(name : string, BranchPriority : number, index : number, Predecessors, Successors)
    local dinosaurObj : DinosaurObject = {
        Predecessors = Predecessors or {},
        Name = name,
        BranchPriority = BranchPriority,
        Successors = Successors or {},
        Index = index
    }

    return dinosaurObj
end

function dinosaur.Add(main : DinosaurObject, new : DinosaurObject)
    -- add a successor
    table.insert(main.Successors, new)
    table.insert(new.Predecessors, main)
end

return dinosaur