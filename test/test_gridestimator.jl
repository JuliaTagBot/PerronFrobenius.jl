tol = 1e-10

@testset "Grid estimator" begin
    points_2D = rand(2, 200)
    points_3D = rand(3, 400)
    E_2D = invariantize(StateSpaceReconstruction.customembed(points_2D))
    E_3D = invariantize(StateSpaceReconstruction.customembed(points_3D))
    ϵ = 3
    bins_visited_by_orbit_2D = assign_bin_labels(E_2D, ϵ)
    bins_visited_by_orbit_3D = assign_bin_labels(E_3D, ϵ)

    bininfo_2D = organize_bin_labels(bins_visited_by_orbit_2D)
    bininfo_3D = organize_bin_labels(bins_visited_by_orbit_3D)

    TO_2D = TransferOperatorEstimatorRectangularBinVisits(bininfo_2D)
    TO_3D = TransferOperatorEstimatorRectangularBinVisits(bininfo_3D)

    invm_2D = invariantmeasure(TO_2D)
    invm_3D = invariantmeasure(TO_3D)

    @test all(invm_2D.dist .>= -tol)
    @test sum(invm_2D.dist) <= 1 + tol || sum(invm_2D.dist) ≈ 1
end
