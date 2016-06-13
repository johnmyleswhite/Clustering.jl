# simple program to test MCL clustering

using Base.Test
using Clustering

srand(34568)

nodes = [:bat, :bit, :cat, :fit, :hat, :hit]
edges = Tuple{Symbol, Symbol, Float64}[(:cat, :hat, 0.2), (:hat, :bat, 0.16),
                                       (:bat, :cat, 1.0), (:bat, :bit, 0.125),
                                       (:bit, :fit, 0.25), (:fit, :hit, 0.5),
                                       (:hit, :bit, 0.16)]
adj_matrix = zeros(Float64, length(nodes), length(nodes))
for edge in edges
    n1 = findfirst(nodes, edge[1])
    n2 = findfirst(nodes, edge[2])
    adj_matrix[n1, n2] = adj_matrix[n2, n1] = edge[3]
end
@assert issym(adj_matrix)

res = mcl(adj_matrix, display=:verbose, inflation=1.8)
@test isa(res, MCLResult)
k = length(res.counts)
# println("k = $k")
@test k == 2
@test all(res.assignments .<= k)
@test length(res.assignments) == length(nodes)
@test length(res.counts) == k
for c = 1:k
    @test countnz(res.assignments .== c) == res.counts[c]
end
@test res.nunassigned == 0
@test res.assignments == [1, 2, 1, 2, 1, 2]

# test allow_singles
res = mcl(diagm([1.0, 1.0]), display=:verbose, allow_singles=true)
@test length(res.counts) == 2
@test res.assignments == [1, 2]
@test res.counts == [1, 1]
@test res.nunassigned == 0

res = mcl(diagm([1.0, 1.0]), display=:verbose, allow_singles=false)
@test length(res.counts) == 0
@test res.assignments == [0, 0]
@test res.nunassigned == 2
